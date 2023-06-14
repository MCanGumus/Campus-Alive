import 'package:destek_ve_sikayet_portali/Signup/components/social_icon.dart';
import 'package:destek_ve_sikayet_portali/business_layer/users_bl.dart';
import 'package:destek_ve_sikayet_portali/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../Login/components/already_have_an_account_check.dart';
import '../../Login/components/rounded_input_field.dart';
import '../../Login/components/rounded_password_field.dart';
import '../../Login/login_screen.dart';
import '../../Problem/Report/components/rounded_button.dart';
import '../../components/flash_message_screen.dart';
import 'background.dart';
import 'or_divider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = "";
  String nameSurname = "";
  String password = "";
  String secondPassword = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.035,
            ),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Mail adresi",
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            RoundedInputField(
              hintText: "İsim Soyisim",
              onChanged: (value) {
                setState(() {
                  nameSurname = value;
                });
              },
            ),
            RoundedPasswordField(
              text: "Şifre",
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            RoundedPasswordField(
              text: "Şifreni tekrarla",
              onChanged: (value) {
                setState(() {
                  secondPassword = value;
                });
              },
            ),
            RoundedButton(
              color: kEventColor,
              text: "Kayıt Ol",
              press: () async {
                final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(email);
                final Future<bool> emailExist =
                    UserDAO().checkEmailExists(email);

                if (email == "") {
                  showMessage(
                      context,
                      "Hay Aksi!",
                      "E-Mail alanı boş bırakılamaz! Lütfen alanları kontrol edin.",
                      ContentType.warning);
                }
                if (nameSurname == "") {
                  showMessage(
                      context,
                      "Hay Aksi!",
                      "İsim Soyisim boş bırakılamaz! Lütfen alanları kontrol edin.",
                      ContentType.warning);
                } else if (password == "") {
                  showMessage(
                      context,
                      "Hay Aksi!",
                      "Şifre alanı boş bırakılamaz! Lütfen alanları kontrol edin.",
                      ContentType.warning);
                } else if (secondPassword == "") {
                  showMessage(context, "Hay Aksi!", "Şifrenizi tekrarlayın.",
                      ContentType.warning);
                } else if (!emailValid) {
                  showMessage(
                      context,
                      "Bir hata oluştu!",
                      "Geçerli bir e-mail adresi giriniz.",
                      ContentType.failure);
                } else if (await emailExist) {
                  showMessage(
                      context,
                      "Hesap kullanılmakta.",
                      "Girdiğiniz e-mail adresi sistemimizde zaten kayıtlı.",
                      ContentType.help);
                } else {
                  UserDAO().addUser(nameSurname, email, password);
                  showMessage(
                      context,
                      "Kayıt Olundu.",
                      "Kaydınızı başarıyla oluşturduk. Giriş yapma sayfasına yönlendiriliyorsunuz.",
                      ContentType.help);
                  //Bundan sonra
                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  });
                }

                // Kayıt ol butonuna basıldığında yapılacak işlemler
              },
            ),
            SizedBox(
              height: size.height * 0.035,
            ),
            AlreadyHaveAnAccountCheck(login: false),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SocialIcon(
                    src: "assets/icons/facebook.svg",
                    press: () {
                      // Facebook ile giriş yap butonuna basıldığında yapılacak işlemler
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SocialIcon(
                    src: "assets/icons/twitter.svg",
                    press: () {
                      // Twitter ile giriş yap butonuna basıldığında yapılacak işlemler
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SocialIcon(
                    src: "assets/icons/google-plus.svg",
                    press: () {
                      // Google ile giriş yap butonuna basıldığında yapılacak işlemler
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SocialIcon(
                    src: "assets/icons/linkedin.svg",
                    press: () {
                      // LinkedIn ile giriş yap butonuna basıldığında yapılacak işlemler
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
