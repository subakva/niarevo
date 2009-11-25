$(function() {
  $('a.help-popup-link').boxy({x:10});
  $('#messages .clearMessage').click(function(event) {
    $(this).closest('#messages').slideUp();
  });
});
