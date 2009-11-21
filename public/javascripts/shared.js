$(function() {
  $('#messages .clearMessage').click(function(event) {
    $(this).closest('#messages').slideUp();
  });
});
