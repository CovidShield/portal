function initializeForms() {
  const dirtyForms = document.querySelectorAll("[data-disabled-until-dirty]");

  dirtyForms.forEach((form) => {
    const submitButton = form.querySelector("[data-submit]");
    submitButton.disabled = true;

    form.addEventListener("change", function () {
      submitButton.disabled = false;
    });
  });
}

document.addEventListener("turbolinks:load", initializeForms);
