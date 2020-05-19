export function initializeFocus() {
  const alert = document.querySelector("[data-alert]");

  if (alert) {
    alert.tabIndex = -1;
    alert.focus();
    return;
  }

  const heading = document.querySelector("h1");

  if (heading) {
    heading.focus();
    return;
  }
}

document.addEventListener("turbolinks:load", initializeFocus);
