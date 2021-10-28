main(List<String> args) {
  List<dynamic> l = [];
  //l[0] = 10;
  //l[1] = 20;
  //l[2] = 7;
  l.add(200);
  l.add("abc");
  l[0] = 10;
  print(l.runtimeType);
  print(l);
}
