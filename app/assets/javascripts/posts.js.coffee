window.posts = class posts
  constructor: ->
    @list = ko.observableArray([
      { title: 'asdasd', description: 'ddddddd' },
      { title: 'asdasd2', description: 'ddddddd2' },
      ])
