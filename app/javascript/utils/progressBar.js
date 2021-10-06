document.addEventListener('turbolinks:load', function () {
  const progressBarElement = document.getElementById('progress-bar');

  if (progressBarElement) {
    showCurrentProgress(progressBarElement);
  }
});

function showCurrentProgress(element) {
  const progress = element.dataset.progress;
  let value = element.getAttribute('aria-valuenow');
  value = progress;
  element.style.width = progress + '%';
}
