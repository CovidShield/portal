function showModal(id) {
  let focusableElements;
  const modalNode = document.getElementById(id);
  const dialogNode = modalNode.querySelector("[role=dialog]");

  if (!modalNode || !dialogNode) {
    return;
  }

  lastFocusedElement = document.activeElement;
  focusableElements = dialogNode.querySelectorAll(
    'a[href], button, textarea, input[type="text"], input[type="radio"], input[type="checkbox"], select'
  );

  const handleKeydown = (event) => {
    if (event.key === "Escape") {
      hideModal();
    } else if (
      event.key === "Tab" &&
      !event.shiftKey &&
      focusableElements !== null &&
      document.activeElement === focusableElements[focusableElements.length - 1]
    ) {
      event.preventDefault();
      focusableElements[0].focus();
    } else if (
      event.key === "Tab" &&
      event.shiftKey &&
      focusableElements !== null &&
      document.activeElement === focusableElements[0]
    ) {
      event.preventDefault();
      focusableElements[focusableElements.length - 1].focus();
    }
  };

  window.addEventListener("keydown", handleKeydown);

  modalNode.dataset.modalActive = "true";
  document.body.dataset.scrollLock = "true";

  dialogNode.focus();
}

function hideModal() {
  const modalNode = document.querySelector("[data-modal-active]");
  if (modalNode) {
    delete modalNode.dataset.modalActive;
    delete document.body.dataset.scrollLock;

    if (lastFocusedElement !== null) {
      lastFocusedElement.focus();
    }
  }
}

function bindActivators() {
  const modalActivators = document.querySelectorAll("[data-modal-activator]");

  if (!modalActivators) {
    return;
  }

  modalActivators.forEach((activator) => {
    const modalId = activator.dataset.modalActivator;
    activator.addEventListener("click", () => {
      showModal(modalId);
    });
  });
}

function bindDeactivators() {
  const modalDeactivators = document.querySelectorAll("[data-modal-close]");
  if (!modalDeactivators) {
    return;
  }
  modalDeactivators.forEach((deactivator) => {
    deactivator.addEventListener("click", hideModal);
  });
}

document.addEventListener("turbolinks:load", function () {
  bindActivators();
  bindDeactivators();
});
