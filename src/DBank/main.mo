import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue: Float = 300; 
  // currentValue := 300; 
  let id = 293843023482039842;
  // Debug.print(debug_show(id));
  
  stable var startTime = Time.now(); 
  // startTime := Time.now();
  // Debug.print(debug_show(startTime));

  public func topUp(amount: Float){
    currentValue += amount;
    Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float){
    let tempValue: Float = currentValue - amount;
    if(tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Not enough funds available to complete transaction.")
    }
  };

  public query func checkBalance(): async Float { // the ': async Nat' ensures the function returns an asyncronous, natural number
    return currentValue;
  };

  // topUp();

  public func compound() {
    let currentTime = Time.now(); 
    let timeElapsedS = (currentTime - startTime) / 1000000000; // 1 billion nano-seconds in a second
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS)); // ** is the 'to the power of' in Motoko
    startTime := currentTime;
  };
}
