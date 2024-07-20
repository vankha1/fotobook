// Prevent propagation for follow button
document.querySelectorAll("#follow_btn").forEach((btn) => {
  btn.addEventListener("click", (e) => {
    e.stopPropagation();
  });
});
