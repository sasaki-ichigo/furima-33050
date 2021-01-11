window.addEventListener('load', function () {
  // console.log("OK");
  const priceInput = document.getElementById("item-price")
  // console.log(priceInput);
  priceInput.addEventListener("input", function () {
  // console.log("イベント発火");
  const inputValue = priceInput.value;
  // console.log(inputValue);
  const addTaxDom = document.getElementById("add-tax-price");
  addTaxDom.innerHTML = Math.floor(inputValue * 0.1)
  // console.log(addTaxDom);
  const profitDom = document.getElementById("profit");
  profitDom.innerHTML = Math.floor(inputValue - (inputValue * 0.1))
  // console.log(profitDom);
  })
})