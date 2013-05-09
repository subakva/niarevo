$ ->
  $('a.preview-link').click (event)->
    previewLink = $(this)
    form        = previewLink.closest('form')
    data        = form.formSerialize()
    previewURL  = previewLink.attr('href')

    previewContainer = $('#preview .preview-content')
    previewContainer.load(previewURL, data)
    $('#preview').modal()

    false
