import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import '../login_screen.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function? press;
  const AlreadyHaveAnAccountCheck({super.key, this.login = true, this.press});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(login ? "Hesabın yok mu? " : "Zaten bir hesabın var mı? ",
            style: TextStyle(color: kEventColor)),
        GestureDetector(
          onTap: () {
            if (login) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SignUpScreen();
                }),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }),
              );
            }
          },
          child: Text(login ? "Hemen kayıt ol" : "O zaman giriş yap",
              style:
                  TextStyle(color: kEventColor, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
