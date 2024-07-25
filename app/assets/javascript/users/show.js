import sendRequest from "../common/sendRequest";
import setDebounce from "../common/debounce";

// Redirect when clicking on name or avatar
document.querySelectorAll('.user_info_part').forEach((user_info_part) => {
    user_info_part.addEventListener('click', (e) => {
        // navigate to user profile
        const userId = user_info_part.closest('#card-follower').dataset.id;
        window.location.href = `/users/${userId}/photos`;
    });
});

// Using debounce for follow/unfollow button
document.querySelectorAll('.custom_btn').forEach((btn) => {
    btn.addEventListener('click', setDebounce((e) => {
        const followBtn = e.target;
        const userId = $("#card-follower").data('id');
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