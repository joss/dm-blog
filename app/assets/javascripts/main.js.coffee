$ ->
  $(@).on "ajax:success", "#new-comment form", (event, data, status, xhr) ->
    $('#new-comment').html(data.new_form_html)
    $('#comments').prepend(data.new_comment_html) if data.new_comment_html

  $(@).on "ajax:error", "#new-comment form", (event, xhr, status, error) ->
    console.log 'error'

  $(@).on "ajax:complete", "button.remove-comment", (event, xhr, status) ->
    $(@).closest('.blog-comment').remove()
