import setDebounce from "../common/debounce";
import sendRequest from "../common/sendRequest";

// Using debounce for heart button
document.querySelectorAll('.fa-heart').forEach((icon) => {
    icon.addEventListener('click', setDebounce((e) => {
        const heartIcon = e.target;
        const albumId = heartIcon.closest('.card').dataset.id;
        const heartCount = heartIcon.querySelector('span');
        console.log(heartIcon, albumId, heartCount)
        if (heartIcon.classList.contains('text-secondary')){
            sendRequest(`/albums_reactions`, 'POST', { album_id: albumId }, (data) => {
                heartIcon.classList.remove('text-secondary');
                heartCount.textContent = parseInt(heartCount.textContent) + 1;
            });
        } else {
            sendRequest(`/albums_reactions/${albumId}`, 'DELETE', null, (data) => {
                heartIcon.classList.add('text-secondary');
                heartCount.textContent = parseInt(heartCount.textContent) - 1;
            });
        }
    }, 1000));
});