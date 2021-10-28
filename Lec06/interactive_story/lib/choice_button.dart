import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final title;
  final onpress;
  final color;
  final visibilty;

  const ChoiceButton(this.title, this.onpress, this.color, this.visibilty,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.2,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Visibility(
          visible: visibilty,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: onpress,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
