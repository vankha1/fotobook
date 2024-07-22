// Image preview
const cardImg = document.getElementById('card-img');
const filesInput = document.getElementById('files_inputs');

filesInput.addEventListener('change', (e) => {
    const file = e.target.files[0];
    const reader = new FileReader();

    reader.onload = (e) => {
        cardImg.src = e.target.result;
        $("#plus_icon").hide();
        $("img#card-img").css('display', 'block');
    }

    reader.readAsDataURL(file);
});

// Validate photos
const form = $('form.row');
form.on('submit', (e) => {
    const title = $('#photo_title').val();
    if (title === '') {
        e.preventDefault();
        alert('Please enter a title');
    }
});

// Show alert after click "Delete" button
const deleteBtn = $('#delete-photo');
deleteBtn.on('click', () => {
    const result = confirm('Are you sure you want to delete this photo?');
    if (!result) {
        return false;
    }
});
