function initializeForms() {
  const dirtyForms = document.querySelectorAll("[data-disabled-until-dirty]");

  dirtyForms.forEach((form) => {
    const submitButon = form.querySelector("[data-submit]");
    submitButon.disabled = true;

    form.addEventListener("change", function () {
      submitButon.disabled = false;
    });
  });
}

document.addEventListener("turbolinks:load", initializeForms);
