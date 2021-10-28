void main() {
  Student s1 = new Student();
  s1.stud_name = 'Ayman';
  s1.stud_age = 1;
  print(s1.stud_name);
  print(s1.stud_age);
}

class Student {
  String? _name;
  int? age;

  String? get stud_name {
    return _name;
  }

  void set stud_name(String? name) {
    this._name = name;
  }

  void set stud_age(int? age) {
    if (age! <= 4) {
      print("Age should be greater than 5");
    } else {
      this.age = age;
    }
  }

  int? get stud_age {
    return age;
  }
}
