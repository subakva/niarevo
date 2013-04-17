$(function() {
  $('a.preview-link').click(function(event) {
    var previewContainer = $('#preview .preview-content');
    var previewLink = $(this);
    var previewURL = previewLink.attr('href');

    var form = previewLink.closest('form');
    var data = form.formSerialize();
    previewContainer.load(previewURL, data);
    console.log(previewContainer.html());
    previewContainer.modal();
    return false;
  });
  $('#messages .clearMessage').click(function(event) {
    $(this).closest('#messages').slideUp();
  });
});
