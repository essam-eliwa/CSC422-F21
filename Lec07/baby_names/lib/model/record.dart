import 'package:cloud_firestore/cloud_firestore.dart';

enum Gender { male, female }

class Record {
  final String name;
  final int votes;
  final Gender gender;
  final DocumentReference reference;

  Record(this.name, this.votes, this.gender, this.reference);

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        assert(map['gender'] != null),
        name = map['name'],
        votes = map['votes'],
        gender = map['gender'] == 'male' ? Gender.male : Gender.female;

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() {
    return "Record: {$name:$votes:$gender}";
  }
}
