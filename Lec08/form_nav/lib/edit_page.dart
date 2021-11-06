import 'package:flutter/material.dart';

typedef StringValue = String Function(String);

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  _EditPageState createState() => _EditPageState();
  var callback;
  EditPage(this.callback);
}

class _EditPageState extends State<EditPage> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Widget Communication"),
        backgroundColor: Colors.red,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            margin: EdgeInsets.all(8),
            child: TextFormField(
              controller: textController,
              maxLines: 1,
              maxLength: 20,
              decoration: InputDecoration(
                hintText: "Enter Some Text Here",
                contentPadding: EdgeInsets.all(8),
              ),
            ),
          ),
          RaisedButton(
              color: Colors.red,
              child: Text("Submit"),
              onPressed: () {
                widget.callback(textController.text);
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
