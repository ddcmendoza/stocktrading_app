$(document).ready(function () {

  // Check for click events on the navbar burger icon
  $(".navbar-burger").click(function () {

    // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
    $(".navbar-burger").toggleClass("is-active");
    $(".navbar-menu").toggleClass("is-active");

  });
});

function hideNotice() {
  setInterval(function () {
    document.querySelector('.notification').style.display = "none";
    document.querySelector('.notif').style.display = "none";
  }, 5000);


}

hideNotice();