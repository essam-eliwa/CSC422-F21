main(List<String> args) {
  var newPen = Pen(color: "red", price: 123.5, brand: "any");
  print(newPen.brand);
  print(newPen.color);
  print(newPen.price);
}

class Pen {
  String color;
  double? price;
  String? brand;

  Pen({this.color = 'white', this.price = 0.0, this.brand = ''});
  Pen.colorOnly(this.color);
}
