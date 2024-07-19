if ($('.toast')) {
    setTimeout(() => {
        $('.toast').removeClass('show'); 
    }, 3000)
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


// Using debounce for follow/unfollow button
document.querySelectorAll('.custom_btn').forEach((btn) => {
    btn.addEventListener('click', setDebounce((e) => {
        const followBtn = e.target;
        const userId = window.location.pathname.split('/')[2];
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