import 'package:baby_names/Screens/add_name.dart';
import 'package:baby_names/widgets/vote_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './model/record.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MIU Names Vote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //**Warning**: When using initialRoute, don’t define a home property.
      //home: MyHomePage(title: 'Baby Votes Demo'),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the MyHomePage widget.
        '/': (context) => MyHomePage(title: 'MIU Names Vote'),
        // When navigating to the "/addName" route, build the AddNameForm widget.
        '/addName': (context) => AddName(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // dummy data Used for testing
// final dummy = [
//   {
//     "name": "Ahmed",
//     "votes": 5,
//     "gender": "male",
//   },
//   {
//     "name": "Doha",
//     "votes": 3,
//     "gender": "female",
//   },
//   {
//     "name": "Salma",
//     "votes": 1,
//     "gender": "female",
//   },
// ];

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('baby_names').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
    //_buildList(context, dummy);
  }

  Widget _buildList(BuildContext context, List<dynamic> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, dynamic data) {
    final record = Record.fromSnapshot(data);
    return VoteItem(record: record);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addName');
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.amberAccent,
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          child: Text('2020 \u00a9 MIU CSC422'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
