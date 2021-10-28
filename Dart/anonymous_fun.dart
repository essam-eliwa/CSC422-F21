main(List<String> args) {
  var list = [1, 2, 3, 4];

  var list2 = [];
  list2.add('val1');
  list2.add(100);

  list.forEach((item) {
    print(item / 2);
  });
}
