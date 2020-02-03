const comment = document.querySelector(".comment-btn");
const commentForm = document.querySelector(".comment-form")

comment.addEventListener('click', function(){
  commentForm.classList.toggle("active");  
})


const commentind = [...document.querySelectorAll(".index-comment-btn")];
const commentindForm = [...document.querySelectorAll(".index-comment-form")];

commentind.map((e,ind) => {e.addEventListener('click', () => {
  commentindForm[ind].classList.toggle("active");
})})

