class User {
  static const String passionCooking = 'cooking';
  static const String passionHiking = 'hiking';
  static const String passionTraveling = 'traveling';
  String firstName = '';
  String lastName = '';
  Map<String, bool> passions = {
    passionCooking: false,
    passionHiking: false,
    passionTraveling: false
  };
  bool newsletter = true;

  save() {
    print('saving user data');
    print('$firstName $lastName');
    if (passions[passionCooking]) {
      print('$passionCooking');
    }

    if (passions[passionHiking]) {
      print('$passionHiking');
    }

    if (passions[passionTraveling]) {
      print('$passionTraveling');
    }
  }
}
