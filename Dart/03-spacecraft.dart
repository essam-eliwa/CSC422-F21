class Spacecraft {
  late String name;
  DateTime? launchDate;

  Spacecraft.other() {
    name = 'other';
  }

  // Read-only non-final property
  int? get launchYear => launchDate?.year;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate);

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  // Method.
  void describe() {
    print('Spacecraft: $name');
    // Type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}

main() {
  var sn = Spacecraft.unlaunched('newSpace');
  print(sn.name);
  sn.describe();
  var s = Spacecraft('Orion', DateTime(2019, 9, 5));
  s.describe();
}
