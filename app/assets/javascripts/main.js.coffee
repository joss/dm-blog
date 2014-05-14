$ ->
  $(@).on "ajax:success", "#new-comment form", (event, data, status, xhr) ->
    $('#new-comment').html(data.new_form_html)
    $('#comments').prepend(data.new_comment_html) if data.new_comment_html

  $(@).on "ajax:error", "#new-comment form", (event, xhr, status, error) ->
    console.log 'error'

  $(@).on "ajax:complete", "button.remove-comment", (event, xhr, status) ->
    $(@).closest('.blog-comment').remove()

  $(@).on 'click', '.remote-page .remove-preview', -> $(@).closest('.remote-page').remove()

  initializeCommentBodyInput()


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

initializeCommentBodyInput = ->
  lastCommentValue = ''
  $input = $("#comment_body")

  $input.on 'change keyup paste', (event)->
    if $input.val() != lastCommentValue
      lastCommentValue = $input.val()

      delayedJob((->
        url = $input.val().getUrl()
        if url
          $.get($input.data('parseRemotePostPath'), { url: url }, (data) ->
            $('#previews').html(data.remote_post_preview_html) unless data.error
          )
      ), 500)
