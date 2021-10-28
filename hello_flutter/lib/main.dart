import 'package:flutter/material.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Title',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My AppBar Text'),
        ),
        body: Center(
            child: Column(
          children: const [
            Text('My Body Text'),
            ElevatedButton(onPressed: null, child: Text('My First Button'))
          ],
        )),
      ),
    );
  }
}
