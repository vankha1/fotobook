// Prevent the modal from showing when clicking the heart icon
document.querySelectorAll('.fa-heart').forEach((icon) => {
    icon.addEventListener('click', (e) => {
        e.stopPropagation();
    });
});