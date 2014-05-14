window.app = class app
  constructor: ->
    @posts = ko.observableArray([
      { title: 'asdasd', description: 'ddddddd' },
      { title: 'asdasd2', description: 'ddddddd2' },
      ])
