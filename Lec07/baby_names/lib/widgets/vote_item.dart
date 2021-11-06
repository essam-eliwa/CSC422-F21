import 'package:baby_names/model/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VoteItem extends StatelessWidget {
  const VoteItem({
    Key key,
    @required this.record,
  }) : super(key: key);

  final Record record;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
          color: record.gender == Gender.male
              ? Colors.blue[100]
              : Colors.pink[100],
        ),
        child: ListTile(
          title: Text(record.name + "    " + record.votes.toString()),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red[800],
              ),
              onPressed: () async {
                print('test');
                await FirebaseFirestore.instance
                    .runTransaction((Transaction transaction) async {
                  transaction.delete(record.reference);
                });
              }),
          onTap: () =>
              FirebaseFirestore.instance.runTransaction((transaction) async {
            final freshSnapshot = await transaction.get(record.reference);
            final freshRecord = Record.fromSnapshot(freshSnapshot);

            transaction
                .update(record.reference, {'votes': freshRecord.votes + 1});
          }),
        ),
      ),
    );
  }
}
