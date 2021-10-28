void main() {
  final myMap = {'a': 1, 'b': 2, 'c': 3};

  for (var element in myMap.keys) {
    print("$element, ${myMap[element]}");
  }
}
