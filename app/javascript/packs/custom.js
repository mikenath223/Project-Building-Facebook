const comment = document.querySelector(".comment-btn");
const commentForm = document.querySelector(".comment-form")
comment.addEventListener('click', function(){
  commentForm.classList.toggle("active");  
})

