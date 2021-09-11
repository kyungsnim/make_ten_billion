import 'package:flutter/material.dart';

/*
SnsLoginButton(
                backgroundColor: Colors.black,
                textColor: Colors.white,
                labelText: 'SIGN IN WITH GOOGLE',
                onPressed: () => signInWithGoogle('Submit'),
              ),
*/

class SnsLoginButton extends StatelessWidget {
  SnsLoginButton(
      {required this.backgroundColor,
      required this.textColor,
      required this.labelText,
      required this.onPressed});

  final Color backgroundColor;
  final Color textColor;
  final String labelText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(primary: backgroundColor),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              labelText.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Binggrae',
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
