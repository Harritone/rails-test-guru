document.addEventListener('turbolinks:load', function () {
  const controlElement = document.getElementById('new_user');

  if (controlElement) {
    const passwordConfirmationInput = document.getElementById(
      'user_password_confirmation',
    );
    const passwordErrorElement = document.querySelector(
      '.password-confirmation-error',
    );

    passwordConfirmationInput.addEventListener('input', function () {
      const passwordInput = document.getElementById('user_password');
      if (this.value === passwordInput.value || this.value == '') {
        passwordErrorElement.classList.remove('d-block');
      } else {
        passwordErrorElement.classList.add('d-block');
      }
    });
  }
});
