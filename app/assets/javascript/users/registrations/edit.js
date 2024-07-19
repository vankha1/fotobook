$(document).on("ready", function () {
  handle_preview($("#files"), $(".card-img"));
});

function readURL(input, image) {
  console.log(input.files);
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function (e) {
      image.attr("src", e.target.result);
    };

    reader.readAsDataURL(input.files[0]);
  }
}

function handle_preview(input, image) {
  input.on("change", function () {
    readURL(this, image);
  });
}
