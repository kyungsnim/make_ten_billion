import 'package:flutter/material.dart';

/*
PrimaryButton(
                labelText: 'UPDATE',
                onPressed: () => print('Submit'),
              ),
*/

class PrimaryButton extends StatelessWidget {
  PrimaryButton({required this.labelText, required this.onPressed});

  final String labelText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.06,
        child: Text(
          labelText.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.05),
        ),
      ),
    );
  }
}
