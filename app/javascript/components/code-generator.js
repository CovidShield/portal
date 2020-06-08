const CODE_TIMEOUT = 600000;

async function postData() {
  const csrfTokenElement = document.querySelector("[name='csrf-token']");
  const csrfToken = csrfTokenElement ? csrfTokenElement.content : "";
  const response = await fetch("/keys/generate", {
    method: "POST",
    headers: {
      "X-CSRF-Token": csrfToken,
      "Content-Type": "application/json",
    },
  });
  return response;
}

function formatCode(code) {
  const codeString = code.toString();
  return codeString.substring(0, 4) + " " + codeString.substring(4, 8);
}

export function initializeCodeGenerator() {
  let codeTimeout;

  const generateButton = document.querySelector("[data-generate-code]");
  const resetButton = document.querySelector("[data-reset-code]");
  const codeBanner = document.querySelector("[data-code-banner]");
  const expiredMessage = document.querySelector("[data-code-expired]");
  const errorMessage = document.querySelector("[data-code-error]");

  if (
    !generateButton ||
    !resetButton ||
    !codeBanner ||
    !expiredMessage ||
    !errorMessage
  ) {
    return;
  }

  const codeResult = codeBanner.querySelector("[data-code-result]");
  const emptyResult = codeBanner.querySelector("[data-code-empty-result]");

  if (!codeResult || !emptyResult) {
    return;
  }

  const generateContent = generateButton.querySelector(
    "[data-generate-content]"
  );
  const generateNewContent = generateButton.querySelector(
    "[data-generate-new-content]"
  );

  if (!generateContent || !generateNewContent) {
    return;
  }

  generateButton.addEventListener("click", async function () {
    generateButton.disabled = true;
    const response = await postData();

    if (!response || response.status !== 200) {
      codeBanner.dataset.hidden = "true";
      delete errorMessage.dataset.hidden;
      errorMessage.tabIndex = -1;
      errorMessage.focus();
      generateButton.disabled = false;
      return;
    }

    const data = await response.json();

    expiredMessage.dataset.hidden = "true";
    errorMessage.dataset.hidden = "true";
    emptyResult.dataset.hidden = "true";
    delete codeBanner.dataset.hidden;
    codeResult.innerHTML = formatCode(data.key);

    generateContent.dataset.hidden = "true";
    delete generateNewContent.dataset.hidden;

    generateButton.disabled = false;
    resetButton.disabled = false;

    window.clearTimeout(codeTimeout);

    codeTimeout = window.setTimeout(() => {
      codeBanner.dataset.hidden = "true";
      delete expiredMessage.dataset.hidden;
    }, CODE_TIMEOUT);
  });

  resetButton.addEventListener("click", async function () {
    codeResult.innerHTML = "";
    delete generateContent.dataset.hidden;
    delete codeBanner.dataset.hidden;
    delete emptyResult.dataset.hidden;
    generateNewContent.dataset.hidden = "true";
    expiredMessage.dataset.hidden = "true";
    resetButton.disabled = true;
  });
}

document.addEventListener("turbolinks:load", initializeCodeGenerator);
