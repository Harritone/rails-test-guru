document.addEventListener('turbolinks:load', function () {
  const timer = document.getElementById('timer');
  if (timer) {
    let seconds = timer.dataset.duration;
    setInterval(() => {
      seconds--;
      if(seconds <= 1) {
        const host = window.location.origin
        const takenQuizId = window.location.pathname.replace('/quiz-passage/', '')
        window.location.replace(`${host}/${takenQuizId}/result`)
      }
      const date = new Date(0, 0, 0);
      date.setSeconds(seconds);
      const hours = date.getHours();
      const min = date.getMinutes();
      const sec = date.getSeconds();
      console.log(hours);
      timer.textContent = `${hours}:${min}:${sec}`;
    }, 1000);
  }
});
