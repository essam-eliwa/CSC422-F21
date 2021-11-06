import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Gender { male, female }

class AddName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new name'),
      ),
      body: AddNameForm(),
    );
  }
}

// Define a custom Form widget.
class AddNameForm extends StatefulWidget {
  @override
  _AddNameFormState createState() {
    return _AddNameFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class _AddNameFormState extends State<AddNameForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  Gender _gender = Gender.male;
  Map nameMap = {'name': '', 'votes': 0, 'gender': Gender.male};

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter suggested baby name';
                }
                //If there are no errors, the validator must return null.
                return null;
              },
              onSaved: (newValue) {
                nameMap['name'] = newValue;
              },
            ),
          ),
          ListTile(
            title: const Text('Male'),
            leading: Radio(
              value: Gender.male,
              groupValue: _gender,
              onChanged: (Gender newValue) {
                setState(() {
                  _gender = newValue;
                });
                nameMap['gender'] = newValue;
              },
            ),
          ),
          ListTile(
            title: const Text('Female'),
            leading: Radio(
              value: Gender.female,
              groupValue: _gender,
              onChanged: (Gender newValue) {
                setState(() {
                  _gender = newValue;
                });
                nameMap['gender'] = newValue;
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Processing Data ${nameMap['gender']}')));
                _handleSubmit();
              }
            },
            child: Text('Submit'),
            color: Theme.of(context).accentColor,
            textTheme: ButtonTextTheme.primary,
            splashColor: Colors.blue[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Theme.of(context).accentColor),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit() {
    final FormState form = _formKey.currentState;

    if (form.validate() == true) {
      form.save();
      FirebaseFirestore.instance.collection('baby_names').add({
        'name': nameMap['name'],
        'votes': 0,
        'gender': nameMap['gender'].toString().split('.')[1],
      });

      form.reset();
      //FocusScope.of(context).unfocus();
    }
  }
} //_AddNameFormState
