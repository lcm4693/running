import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPress;
  final Function onLongPress;
  final String label;
  final IconData icon;

  Button({this.onPress, this.onLongPress, this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(32),
      color: Colors.grey[400],
      shape: CircleBorder(
        side: BorderSide(),
      ),
      onPressed: onPress,
      onLongPress: onLongPress,
      child: Column(
        children: [
          Visibility(
            child: Icon(icon),
            visible: icon != null,
          ),
          Visibility(
            child: Text(label,
                style: TextStyle(
                  fontSize: 16,
                )),
            visible: label != null,
          ),
        ],
      ),
    );
  }
}
