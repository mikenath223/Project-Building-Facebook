
// chat.scrollTo(0, chat.scrollHeight)

const text = document.querySelector(".change-text");
const chats = document.querySelectorAll("#chats");
const headerFriend = document.querySelector(".head-friend");
const friendsChat = document.querySelector(".friends-chat");
const chatWrapper = document.querySelectorAll(".chat-wrapper");
headerFriend.addEventListener('click', () => {
  toggleClass(friendsChat, "friends-chat-prop");
  chats.forEach((e) => {
    e.setAttribute("style", "height: 120px; bottom: 0");
  });
  chatWrapper.forEach((e) => {
    e.setAttribute("style", "top: initial; bottom: -140px, height: 120px");
  });
  text.textContent = "Click to hide...";
});

function toggleClass(elem, cssClass) {
  elem.classList.toggle(cssClass);
}