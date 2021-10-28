class Car {
  String brand;
  late int maxSpeed;

  Car(this.brand, this.maxSpeed);

  Car.withBrand(this.brand) {
    this.maxSpeed = 180;
  }
}

main() {
  Car c = Car.withBrand('ford');
  Car c2 = Car('Toyta', 200);
  print(' brand is ${c.brand}');
  print(' max speed ${c.maxSpeed}');
}
