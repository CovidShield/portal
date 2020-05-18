import { addOnce } from "../utilities/add-once";

export function initializePopovers() {
  const popovers = document.querySelectorAll("[data-popover]");

  popovers.forEach((popover) => {
    const activator = popover.querySelector("[data-popover-activator]");
    const content = popover.querySelector("[data-popover-content]");

    if (!activator || !content) {
      return;
    }

    activator.addEventListener("click", (event) => {
      event.stopPropagation();
      if (popover.dataset.popoverActive) {
        activator.removeAttribute = "aria-expanded";
        delete popover.dataset.popoverActive;
        return;
      }

      popover.dataset.popoverActive = true;
      activator.setAttribute = ("aria-expanded", "true");

      addOnce(document, "click", () => delete popover.dataset.popoverActive);

      window.addEventListener("keydown", (event) => {
        if (event.key === "Escape") {
          delete popover.dataset.popoverActive;
        }
      });
    });

    content.addEventListener("click", (event) => {
      event.stopPropagation();
    });
  });
}

document.addEventListener("turbolinks:load", initializePopovers);
