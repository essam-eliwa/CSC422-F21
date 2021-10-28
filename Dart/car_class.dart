void main() {
  //Car c = new Car(model: "Test", maxSpeed: 180);
  Car c = Car(model: "test", maxSpeed: 100);
  print("Model: ${c.model}, Max Speed: ${c.maxSpeed}");
}

class Car {
  final String model;
  int maxSpeed;

  Car({this.model = "Batmobile", this.maxSpeed = 350});
  //Car(this.model, this.maxSpeed);
  //Car.abc() {
  //  this.model = "test";
  //  this.maxSpeed = 100;
  //}
}

//
//  Car.model(String m) {
//    this.model = m;
//    this.maxSpeed = 200;
//  }
// Car(this.model);
// Car(this.maxSpeed);
//}
