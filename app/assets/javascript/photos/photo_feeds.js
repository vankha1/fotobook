import setDebounce from "../common/debounce";
import sendRequest from "../common/sendRequest";

// Using debounce for heart button
document.querySelectorAll('.fa-heart').forEach((icon) => {
    icon.addEventListener('click', setDebounce((e) => {
        const heartIcon = e.target;
        const photoId = heartIcon.closest('.card').dataset.id;
        const heartCount = heartIcon.querySelector('span');
        console.log(heartIcon, photoId, heartCount)
        if (heartIcon.classList.contains('text-secondary')){
            sendRequest(`/photos_reactions`, 'POST', { photo_id: photoId }, (data) => {
                heartIcon.classList.remove('text-secondary');
                heartCount.textContent = parseInt(heartCount.textContent) + 1;
            });
        } else {
            sendRequest(`/photos_reactions/${photoId}`, 'DELETE', null, (data) => {
                heartIcon.classList.add('text-secondary');
                heartCount.textContent = parseInt(heartCount.textContent) - 1;
            });
        }
    }, 1000));
});