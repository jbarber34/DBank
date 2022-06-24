import Debug "mo:base/Debug"

actor DBank {
  stable var currentValue: Nat = 300; 

  let id = 293843023482039842;

  // Debug.print(debug_show(id));

  public func topUp(amount: Nat){
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Nat){
    let tempValue: Int = currentValue - amount;
    if(tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Not enough funds available to complete transaction.")
    }
  };

  public query func checkBalance(): async Nat { // the ': async Nat' ensures the function returns an asyncronous, natural number
    return currentValue;
  };

  // topUp();
}
