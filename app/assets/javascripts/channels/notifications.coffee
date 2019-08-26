App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#notification').prepend '<div class="m-1 p-1 shadow shadow-regular">' + data['notification'] + '<small>' + " Just Now " + '</small>' + '</div>'
    $('.notifications-count').text data['count']
    # Called when there's incoming data on the websocket for this channel
