import sendRequest from '../common/sendRequest'
import setDebounce from '../common/debounce'

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

// Using debounce for follow/unfollow button
document.querySelectorAll('.custom_btn').forEach((btn) => {
    btn.addEventListener('click', setDebounce((e) => {
        const followBtn = e.target;
        const userId = followBtn.closest('.card').dataset.user;
        console.log(followBtn, userId, followBtn.classList.contains('custom_btn_followed'))
        if (!followBtn.classList.contains('custom_btn_followed')){
            sendRequest(`/follows`, 'POST', { follower_id: userId }, (data) => {
                // add class custom_btn_followed to all buttons of photos that have been followed
                followBtn.classList.add('custom_btn_followed');
                followBtn.textContent = 'Following';
            });
        } else {
            sendRequest(`/follows/${userId}`, 'DELETE', null, (data) => {
                followBtn.classList.remove('custom_btn_followed');
                followBtn.textContent = 'Follow';
            });
        }
    }, 1000));
});