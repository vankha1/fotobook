// Show alert after click "Delete" button
const deleteBtn = $('#delete-user');
deleteBtn.on('click', () => {
    const result = confirm('Are you sure you want to delete this user?');
    if (!result) {
        return false;
    }
});
