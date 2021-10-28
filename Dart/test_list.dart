main(List<String> args) {
  var myList = [1, 2, 3, 4, "aaa"];
  myList[0] = 100;
  myList[1] = "asd";
  myList.add(5);
  print(myList);
  print(myList.runtimeType);
}
