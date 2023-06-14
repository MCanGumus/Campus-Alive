import 'dart:io';
import 'package:destek_ve_sikayet_portali/Suggestion/Give/components/rounded_button.dart';
import 'package:destek_ve_sikayet_portali/Suggestion/Give/components/rounded_input_fields.dart';
import 'package:destek_ve_sikayet_portali/Suggestion/suggestion_page.dart';
import 'package:destek_ve_sikayet_portali/business_layer/suggestions_bl.dart';
import 'package:destek_ve_sikayet_portali/current_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../components/flash_message_screen.dart';
import '../../constants.dart';
import '../../data_layer/users_db.dart';

class GiveSuggestion extends StatefulWidget {
  final int userFK;

  GiveSuggestion({required this.userFK});
  @override
  _GiveSuggestion createState() => _GiveSuggestion();
}

class _GiveSuggestion extends State<GiveSuggestion> {
  String title = '';
  String text = '';
  bool isAnonymous = false;
  File? selectedImage;
  ImportanceLevel importanceLevel = ImportanceLevel.low;

  @override
  Widget build(BuildContext context) {
    void _selectImageFromGallery() async {
      final pickedImage =
          await ImagePicker().getImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        setState(() {
          selectedImage = File(pickedImage.path);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fotoğraf yüklendi: ${pickedImage.path}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fotoğraf seçilemedi')),
        );
      }
    }

    return Scaffold(
      backgroundColor: kSuggestionBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            backgroundColor: kSuggestionBackgroundColor,
            title: Center(
                child: Text('Tavsiye',
                    style: GoogleFonts.montserrat(
                        color: kSuggestionColor, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)),
            pinned: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    'Başlık',
                    style: GoogleFonts.montserrat(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  RoundedInputField(
                    hintText: 'Başlık girin',
                    isBold: true,
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Metin',
                    style: GoogleFonts.montserrat(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  RoundedInputField(
                    hintText: 'Metin girin',
                    isBold: false,
                    onChanged: (value) {
                      text = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Divider(),
                  Divider(),
                  RoundedButton(
                    press: () {
                      if (title == "") {
                        showMessage(
                            context,
                            "Boş alanlar var!",
                            "Başlık alanı boş bırakılamaz.",
                            ContentType.warning);
                      } else if (text == "") {
                        showMessage(
                            context,
                            "Boş alanlar var!",
                            "Metin alanı boş bırakılamaz.",
                            ContentType.warning);
                      } else {
                        SuggestionDAO().addSuggestion(
                            widget.userFK, title, text); // John Doe

                        showMessage(
                            context,
                            "Başarılı",
                            "Önerinizi kaydettik. Listeleme sayfasına yönlendiriliyorsunuz.",
                            ContentType.success);
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuggestionPage(
                                userFK: widget.userFK,
                              ),
                            ),
                          );
                        });
                      }
                    },
                    text: "TAVSİYE ET",
                    color: kSuggestionColor,
                    textColor: Colors.white,
                    // Butona tıklandığında yapılacak işlemler
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ImportanceLevel { low, medium, high }
