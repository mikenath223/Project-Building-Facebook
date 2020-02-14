import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    console.log('Server is live!')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    window.location.reload()
    // $('#msg').append('<div class="message">' + data.content + data.time + '</div>')
    // document.getElementById('msg').appendChild('<div class="message">' + data.content + data.time + '</div>')
    console.log(data.content)
    // Called when there's incoming data on the websocket for this channel
  }
});
