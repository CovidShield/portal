export function handleLoadFocus() {
  const alert = document.querySelector("[data-alert]");

  if (alert) {
    alert.tabIndex = -1;
    alert.focus();
    return;
  }

  const firstError = document.querySelector("[aria-invalid]");

  if (firstError) {
    firstError.focus();
    return;
  }

  const heading = document.querySelector("h1");

  if (heading) {
    heading.focus();
    return;
  }
}

document.addEventListener("turbolinks:load", handleLoadFocus);
