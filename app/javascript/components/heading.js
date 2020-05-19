export function focusHeading() {
  const heading = document.querySelector("h1");

  if (heading) {
    heading.focus();
  }
}

document.addEventListener("turbolinks:load", focusHeading);
