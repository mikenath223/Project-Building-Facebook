
const chats = document.querySelectorAll("#chats");
chats.forEach((e) => {
  e.scrollTo(0, e.scrollHeight);
});

let count = 0;
const toggleText = ["Click to hide...", "Friends"];
const text = document.querySelector(".change-text");
const headerFriend = document.querySelector(".head-friend");
const friendsChat = document.querySelector(".friends-chat");
const chatWrapper = document.querySelectorAll(".chat-wrapper");

if (document.querySelector(".request")) {
  friendsChat.setAttribute("style", "background-color: none; height: 0px");  
  
  document.querySelector(".chat-wrapper").style.top = "10px";
}


headerFriend.addEventListener('click', () => {
  toggleClass(friendsChat, "friends-chat-prop");
  chats.forEach((e) => {
    toggleClass(e, "chat-prop")
  });
  chatWrapper.forEach((e) => {
    toggleClass(e, "chat-wrapper-prop")
  });
  if (count > 1) {count = 0};
  text.textContent = toggleText[count];
  count += 1;
});

function toggleClass(elem, cssClass) {
  elem.classList.toggle(cssClass);
}