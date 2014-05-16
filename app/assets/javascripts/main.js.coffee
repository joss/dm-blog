$ ->
  $(@).on "ajax:success", "#new-comment form", (event, data, status, xhr) ->
    $('#new-comment').html(data.new_form_html)
    $('#comments').prepend(data.new_comment_html) if data.new_comment_html
    initializeFileupload()

  $(@).on "ajax:error", "#new-comment form", (event, xhr, status, error) ->
    console.log 'error'

  $(@).on "ajax:complete", "button.remove-comment", (event, xhr, status) ->
    $(@).closest('.blog-comment').remove()

  $(@).on 'click', '.remote-page .remove-preview', ->
    $(@).closest('.remote-page').remove()
    $('input#comment_remote_post_attributes_title').val('')

  $(@).on 'click', '.remote-page img', imageCarousel

  initializeCommentBodyInput()
  initializeFileupload()

# Core extension
String.prototype.getUrl = ->
  urlRegExp = /\(?(?:(http|https|ftp):\/\/)?(?:((?:[^\W\s]|\.|-|[:]{1})+)@{1})?((?:www.)?(?:[^\W\s]|\.|-)+[\.][^\W\s]{2,4}|localhost(?=\/)|\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})(?::(\d*))?([\/]?[^\s\?]*[\/]{1})*(?:\/?([^\s\n\?\[\]\{\}\#]*(?:(?=\.)){1}|[^\s\n\?\[\]\{\}\.\#]*)?([\.]{1}[^\s\?\#]*)?)?(?:\?{1}([^\s\n\#\[\]]*))?([\#][^\s\n]*)?\)?/g
  return (@.match(urlRegExp) || [])[0]

# Other functions
delayedJob = (->
  timer = 0
  (callback, ms) ->
    clearTimeout timer
    timer = setTimeout(callback, ms)
    return
)()

imageCarousel = ->
  currentIdx = $(@).data('currentIdx')
  images = $(@).data('images')
  nextIdx = if currentIdx + 1 < images.length then currentIdx + 1 else 0
  $(@).attr('src', images[nextIdx])
  $(@).closest('.remote-page').find('#logo-url-field').val(images[nextIdx])
  $(@).data('currentIdx', nextIdx)

initializeCommentBodyInput = ->
  lastCommentValue = ''
  input_selector = "#comment_body"

  $(document).on 'change keyup paste', input_selector, (event)->
    if $(input_selector).val() != lastCommentValue
      lastCommentValue = $(input_selector).val()

      delayedJob((->
        url = $(input_selector).val().getUrl()
        if url
          $.get($(input_selector).data('parseRemotePostPath'), { url: url }, (data) ->
            $('#previews').append(data.remote_post_preview_html) unless data.error
          )
      ), 500)

initializeFileupload = ->
  $('#fileupload').fileupload(
    previewMaxWidth: 200,
    previewMaxHeight: 200,
    dataType: 'json',
    done: (e, data) ->
      $.each data.result.files, (index, file) ->
        $("#comment_image_ids").append($("<input type='hidden' name='comment[comment_image_ids][]'/>").val(file.id))
  ).on('fileuploadadd', (e, data) ->
    data.context = $('<div/>').appendTo('#files')
    $.each data.files, (index, file) ->
      node = $('<p/>').append($('<span/>').text(file.name))
      node.append('<br>')

      node.appendTo(data.context)
  ).on('fileuploadprocessalways', (e, data) ->
    index = data.index
    file = data.files[index]
    node = $(data.context.children()[index])
    node.prepend('<br>').prepend(file.preview) if file.preview
  )
