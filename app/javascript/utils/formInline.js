document.addEventListener('turbolinks:load', function () {
  const editLinks = document.querySelectorAll('.form-inline-link');

  if (editLinks.length) {
    for (link of editLinks) {
      link.addEventListener('click', formInlineLinkHandler);
    }
  }

  const errors = document.querySelector('.resource-errors');
  const formInline = document.querySelector('.form-inline');

  if (errors && formInline) {
    const resourceId = errors.dataset.resourceId;
    console.log(resourceId);
    formInlineHandler(resourceId);
  }
});

const formInlineLinkHandler = function (e) {
  e.preventDefault();

  const quizId = this.dataset.quizId;
  formInlineHandler(quizId);
};

const formInlineHandler = function (quizId) {
  const link = document.querySelector(
    `.form-inline-link[data-quiz-id="${quizId}"]`,
  );
  const quizTitle = document.querySelector(
    `.quiz-title[data-quiz-id="${quizId}"]`,
  );
  const formInline = document.querySelector(
    `.form-inline[data-quiz-id="${quizId}"]`,
  );
  if (formInline.classList.contains('d-none')) {
    formInline.classList.remove('d-none');
    quizTitle.classList.add('d-none');
    link.textContent = 'Cancel';
  } else {
    formInline.classList.add('d-none');
    quizTitle.classList.remove('d-none');
    link.textContent = 'Edit';
  }
};
