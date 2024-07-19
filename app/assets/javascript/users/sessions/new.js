// Client-side validation
const email = document.querySelector('input[type="email"]');
const password = document.querySelector('input[type="password"]');
const error_message = document.querySelector("#error_message");
const form = document.querySelector(".new_user");

form.addEventListener("submit", (e) => {
  if (email.value === "") {
    e.preventDefault();
    alert("Email cannot be blank");
    return false;
  }

  if (password.value === "") {
    e.preventDefault();
    alert("Password cannot be blank");
    return false;
  }
});
