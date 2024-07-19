function toggleModal(id) {
    var modal = new bootstrap.Modal(document.getElementById(id), {
        keyboard: false
    });
    modal.show();
}

const setDebounce = (func, delay) => {
    let debounce;
    return function () {
        const context = this;
        const args = arguments;
        clearTimeout(debounce);
        debounce = setTimeout(() => func.apply(context, args), delay);
    };
};

const sendRequest = (url, method, data, callback) => {
    $.ajax({
        url: url,
        type: method,
        dataType: 'script',
        data: data,
        success: callback(data),
        error: function (error) {
            console.log(error);
        }
    });
}

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
// Prevent the modal from showing when clicking the heart icon
document.querySelectorAll('.fa-heart').forEach((icon) => {
    icon.addEventListener('click', (e) => {
        e.stopPropagation();
    });
});

// Prevent propagation for user_info_part
document.querySelectorAll('.user_info_part').forEach((user_info_part) => {
    user_info_part.addEventListener('click', (e) => {
        e.stopPropagation();
        // navigate to user profile
        const userId = user_info_part.closest('.card').dataset.user;
        window.location.href = `/users/${userId}/photos`;
    });
});