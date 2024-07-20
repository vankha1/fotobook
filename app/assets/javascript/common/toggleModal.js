function toggleModal(id) {
    var modal = new bootstrap.Modal(document.getElementById(id), {
        keyboard: false
    });
    modal.show();
}