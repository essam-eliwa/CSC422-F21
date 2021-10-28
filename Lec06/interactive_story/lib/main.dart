import 'package:flutter/material.dart';
import 'story.dart';
import 'choice_button.dart';

void main() => runApp(InteractiveStory());

class InteractiveStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MainView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final IStoryData appLogic = IStoryData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Interactive Story'),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: const DecorationImage(
              image: AssetImage('assets/ocean.jpeg'),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              color: Colors.black,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(180, 230, 230, 255),
                  border: Border.all(
                    color: Colors.blue[900]!,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 240,
                margin: EdgeInsets.all(12.0),
                child: Center(
                  child: Text(
                    appLogic.getStory()[0],
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ChoiceButton(appLogic.getStory()[1], () {
                setState(() {
                  appLogic.nextStory(1);
                });
              }, Colors.teal, true),
              ChoiceButton(appLogic.getStory()[2], () {
                setState(() {
                  appLogic.nextStory(2);
                });
              }, Colors.blue[500], appLogic.isVisible()),
              ChoiceButton(appLogic.getStory()[3], () {
                setState(() {
                  appLogic.nextStory(3);
                });
              }, Colors.amber, appLogic.isVisible())
            ],
          )),
    );
  }
}
