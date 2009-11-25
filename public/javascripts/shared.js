$(function() {
  $('a[rel=boxy]').boxy();
  $('#messages .clearMessage').click(function(event) {
    $(this).closest('#messages').slideUp();
  });
});
