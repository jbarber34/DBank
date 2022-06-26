import { DBank } from "../../declarations/DBank";

window.addEventListener("load", async () => {
  // console.log("Finished loading");
  // Update Current Balance with interest on refresh
  DBank.compound();
  update();
});


document.querySelector("form").addEventListener("submit", async (event) => {
  event.preventDefault();
  // console.log("Submitted");

  // Tap into the button to trigger events after deposit/withdrawal
  const button = event.target.querySelector("#submit-btn");

  // Grab values from the input form
  const depositAmount = parseFloat(document.getElementById("input-amount").value);
  const withdrawalAmount = parseFloat(document.getElementById("withdrawal-amount").value);

  // Disable submit button after click to allow time for balance to be updated
  button.setAttribute("disabled", true);

  // Conditional operations based on user wanting to deposit or withdraw funds
  if (document.getElementById("input-amount").value.length != 0) {
    await DBank.topUp(depositAmount); // Call topUp() function to add funds
  } else if (document.getElementById("withdrawal-amount").value.length != 0) {
    await DBank.withdraw(withdrawalAmount); // Call withdraw() function to withdraw funds
  }

  // Compound value by the interest
  await DBank.compound();

  // Update Current Balance amount after deposit or withdrawal
  update();

  // Remove the value of deposit/withdrawal once added
  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";

  // Re-enable submit button after balance updates
  button.removeAttribute("disabled");
});

// Update Current Balance amount after deposit or withdrawal
async function update() {
  const currentAmount = await DBank.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
}