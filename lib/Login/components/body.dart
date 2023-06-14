import 'package:destek_ve_sikayet_portali/Home/home_page.dart';
import 'package:destek_ve_sikayet_portali/Login/components/rounded_password_field.dart';
import 'package:destek_ve_sikayet_portali/business_layer/users_bl.dart';
import 'package:destek_ve_sikayet_portali/components/flash_message_screen.dart';
import 'package:destek_ve_sikayet_portali/constants.dart';
import 'package:destek_ve_sikayet_portali/data_layer/users_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Problem/Report/components/rounded_button.dart';
import '../../current_user.dart';
import 'already_have_an_account_check.dart';
import 'background.dart';
import 'rounded_input_field.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("", style: TextStyle(fontWeight: FontWeight.bold)),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Mail adresin",
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            RoundedPasswordField(
              text: "Şifren",
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            RoundedButton(
              color: kEventColor,
              text: "Giriş Yap",
              press: () async {
                final Future<bool> emailExist =
                    UserDAO().checkEmailExists(email);

                Users? user = await UserDAO().findUser(email, password);

                if (await emailExist && user == null) {
                  showMessage(context, "Hata!", "Şifreniz yanlış.",
                      ContentType.failure);
                } else if (await emailExist == false) {
                  showMessage(
                      context,
                      "Hata!",
                      "Verilen e-mail adresi sistemimizde kayıtlı değil.",
                      ContentType.failure);
                } else if (user != null) {
                  showMessage(
                      context,
                      "Hoşgeldiniz ${user.nameSurname}",
                      "Ana sayfaya yönlendiriliyorsunuz...",
                      ContentType.success);
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return HomePage(
                          name: user.nameSurname,
                          pk: user.pk,
                        );
                      }),
                    );
                  });
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(),
          ],
        ),
      ),
    );
  }
}
