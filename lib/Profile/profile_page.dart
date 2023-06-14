import 'components/rounded_input_fields.dart';
import 'components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String nameSurname;

  const ProfilePage(
      {super.key, required this.email, required this.nameSurname});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text('Profil',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ))),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage(
                  "assets/images/cangumus.jpg"), // Kullanıcının fotoğrafını burada gösterin
            ),
            SizedBox(height: 10.0),
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                // Fotoğraf değiştirme işlemini burada gerçekleştirin
              },
            ),
            SizedBox(height: 20.0),
            RoundedInputField(
              hintText: "Mail Adresi",
              isBold: false,
              onChanged: (value) {},
            ),
            SizedBox(height: 10.0),
            RoundedInputField(
              hintText: "İsim Soyisim",
              isBold: false,
              onChanged: (value) {},
            ),
            SizedBox(height: 10.0),
            SizedBox(height: 20.0),
            RoundedButton(text: "Uygula", press: () {})
          ],
        ),
      ),
    );
  }
}
