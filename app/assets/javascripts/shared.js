$(function() {
  $('a.help-link').boxy({ x: 10 });
  $('a.preview-link').click(function(event) {
    var previewContainer = $('#preview .preview-content');
    var previewLink = $(this);
    var previewURL = previewLink.attr('href');
    new Boxy(previewContainer, {
      title: previewLink.attr('title'),
      actuator: previewLink,
      x: 10,
      clone: true,
      afterShow: function() {
        var form = previewLink.closest('form');
        var data = form.formSerialize();
        this.getContent().load(previewURL, data);
      }
    });
    return false;
  });
  $('#messages .clearMessage').click(function(event) {
    $(this).closest('#messages').slideUp();
  });
});
