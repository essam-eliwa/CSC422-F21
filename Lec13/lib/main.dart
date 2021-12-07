import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

Future<Album> fetchAlbum(int id) async {
  //simulate delay to test CircularProgressIndicator
  //await Future.delayed(const Duration(milliseconds: 1500));
  final response =
      await http.get('https://jsonplaceholder.typicode.com/album/$id');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    //Map<String, dynamic> jsonMap = jsonDecode(response.body);
    print(response.body);
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;
  int _id = 1;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum(_id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Album>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print('data recieved');
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        '${snapshot.data.id} - ${snapshot.data.title}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "${snapshot.error}",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  print('data not recieved yet');
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _id++;
                          futureAlbum = fetchAlbum(_id);
                        });
                      },
                      child: Text('Next')),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _id = 1;
                          futureAlbum = fetchAlbum(_id);
                        });
                      },
                      child: Text('Reset'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
