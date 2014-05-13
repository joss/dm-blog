$ ->
  console.log '1'
  console.log document.getElementById('container')
  qwe = new window.posts()
  console.log qwe
  ko.applyBindings(qwe, document.getElementById('container'))
  console.log '2'
