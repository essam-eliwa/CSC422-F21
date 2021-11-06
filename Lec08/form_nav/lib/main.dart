import 'package:flutter/material.dart';
import 'package:form_nav/edit_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String editableText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Widget Communication")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              editableText != null ? editableText : "Want To Change Text?",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            RaisedButton(
                color: Colors.blue,
                child: Text("Next Page"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditPage((value) {
                                setState(() {
                                  editableText = value;
                                });
                              })));
                }),
          ],
        ),
      ),
    );
  }
}
