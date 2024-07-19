handle_preview(
  $("div.nested-fields:last #files_inputs"),
  $("div.nested-fields:last #card-img")
);
const add_photo_upload = document.getElementById("add_photo_upload");
add_photo_upload.addEventListener("click", function () {
  setTimeout(() => {
    handle_preview(
      $("div.nested-fields:last #files_inputs"),
      $("div.nested-fields:last #card-img")
    );
  }, 0);
});

function readURL(input, image) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      image.attr("src", e.target.result);
      image.css("width", "100%");
      image.css("height", "100%");
    };
    reader.readAsDataURL(input.files[0]);
  }
}

function handle_preview(input_tag, image) {
  input_tag.on("change", function (e) {
    if (this.files.length) {
      var file = this.files[0];
      readURL(this, image);
    }
  });
}

// Validate photos
const form = $("form.row");
// const filesInput = document.getElementById('files_inputs');
form.on("submit", (e) => {
  const title = $("#album_title").val();
  //const files = filesInput.files;
  //if (files.length === 0) {
  //    e.preventDefault();
  //    alert('Please select a file to upload');
  //}
  if (title === "") {
    e.preventDefault();
    alert("Please enter a title");
  }
});
