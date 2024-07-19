console.log(11111);

export default function setDebounce (func, delay) {
  let debounce;
  return function () {
    const context = this;
    const args = arguments;
    clearTimeout(debounce);
    debounce = setTimeout(() => func.apply(context, args), delay);
  };
};
