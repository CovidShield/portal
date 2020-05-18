export function addOnce(node, type, callback) {
  const eventListener = (event) => {
    node.removeEventListener(event.type, eventListener);
    callback(event);
  };

  node.addEventListener(type, eventListener);
}
