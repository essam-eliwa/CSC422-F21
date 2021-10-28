main(List<String> args) {
  const myList = [1, 2, 3, 4, 5, 6, 7, 8];
  Iterable odds = myList.where((e) => e.isOdd);
  var test01 = myList.fold(0, (int prev, element) => prev + element);
  var test02 = myList.asMap();
  var test03 = myList.expand((i) => [i, i + 1, 0]).toList();
  print(odds);
  print(test01);
  print(test02);
  print(test03);
}
