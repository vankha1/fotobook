// Prevent propagation for user_info_part
document.querySelectorAll('.user_info_part').forEach((user_info_part) => {
    user_info_part.addEventListener('click', (e) => {
        e.stopPropagation();
        // navigate to user profile
        const userId = user_info_part.closest('.card').dataset.user;
        window.location.href = `/users/${userId}/photos`;
    });
});