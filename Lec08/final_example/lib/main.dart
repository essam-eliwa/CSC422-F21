import 'package:flutter/material.dart';
import 'package:final_example/model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(title: Text('Profile')),
          body: HomeMaterial(),
        ));
  }
}

class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'First name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
              onSaved: (val) => setState(() => _user.firstName = val),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last name'),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your last name.';
                }
                return null;
              },
              onSaved: (val) => setState(() => _user.lastName = val),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
              child: Text('Subscribe'),
            ),
            SwitchListTile(
                title: const Text('Monthly Newsletter'),
                value: _user.newsletter,
                onChanged: (bool val) =>
                    setState(() => _user.newsletter = val)),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
              child: Text('Interests'),
            ),
            CheckboxListTile(
                title: const Text('Cooking'),
                value: _user.passions[User.passionCooking],
                onChanged: (val) {
                  setState(() => _user.passions[User.passionCooking] = val);
                }),
            CheckboxListTile(
                title: const Text('Traveling'),
                value: _user.passions[User.passionTraveling],
                onChanged: (val) {
                  setState(() => _user.passions[User.passionTraveling] = val);
                }),
            CheckboxListTile(
              title: const Text('Hiking'),
              value: _user.passions[User.passionHiking],
              onChanged: (val) {
                setState(() => _user.passions[User.passionHiking] = val);
              },
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    _user.save();
                    _showDialog(context);
                  }
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
