import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:destek_ve_sikayet_portali/Problem/Report/components/rounded_button.dart';
import 'package:destek_ve_sikayet_portali/Problem/Report/components/rounded_input_fields.dart';
import 'package:destek_ve_sikayet_portali/Problem/problems_page.dart';
import 'package:destek_ve_sikayet_portali/components/flash_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../business_layer/problems_bl.dart';
import '../../constants.dart';

class ReportAProblem extends StatefulWidget {
  final int userFK;

  const ReportAProblem({Key? key, required this.userFK}) : super(key: key);

  @override
  _ReportAProblemState createState() => _ReportAProblemState();
}

class _ReportAProblemState extends State<ReportAProblem> {
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

    Future<String> saveImageToAssets(File imageFile) async {
      final appDir = await path_provider.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage = await imageFile.copy('${appDir.path}/$fileName');
      return savedImage.path;
    }

    return Scaffold(
      backgroundColor: kProblemBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            backgroundColor: kProblemBackgroundColor,
            title: Center(
              child: Text(
                'Bildir',
                style: GoogleFonts.montserrat(
                  color: kProblemColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
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
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
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
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
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
                  CheckboxListTile(
                    activeColor: kProblemColor,
                    title: Text(
                      'Anonim Paylaş',
                      style: GoogleFonts.montserrat(),
                    ),
                    value: isAnonymous,
                    onChanged: (value) {
                      setState(() {
                        isAnonymous = value ?? false;
                      });
                    },
                  ),
                  Divider(),
                  Text(
                    'Önemlilik Derecesi',
                    style: GoogleFonts.montserrat(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<ImportanceLevel>(
                          activeColor: Colors.green,
                          title: Text(
                            'Düşük',
                            style: GoogleFonts.montserrat(fontSize: 9),
                          ),
                          value: ImportanceLevel.low,
                          groupValue: importanceLevel,
                          onChanged: (value) {
                            setState(() {
                              importanceLevel = value ?? ImportanceLevel.low;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<ImportanceLevel>(
                          activeColor: Colors.orange,
                          title: Text(
                            'Orta',
                            style: GoogleFonts.montserrat(fontSize: 9),
                          ),
                          value: ImportanceLevel.medium,
                          groupValue: importanceLevel,
                          onChanged: (value) {
                            setState(() {
                              importanceLevel = value ?? ImportanceLevel.low;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<ImportanceLevel>(
                          activeColor: Colors.red,
                          title: Text(
                            'Yüksek',
                            style: GoogleFonts.montserrat(fontSize: 9),
                          ),
                          value: ImportanceLevel.high,
                          groupValue: importanceLevel,
                          onChanged: (value) {
                            setState(() {
                              importanceLevel = value ?? ImportanceLevel.low;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  selectedImage == null
                      ? GestureDetector(
                          onTap: _selectImageFromGallery,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: kProblemBackgroundColor,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'FOTOĞRAF SEÇ',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.add, color: Colors.grey, size: 40.0),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(selectedImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(height: 0),
                  Divider(
                    color: Colors.black,
                  ),
                  RoundedButton(
                    press: () async {
                      if (title == "") {
                        showMessage(
                          context,
                          "Boş alanlar var!",
                          "Başlık alanı boş bırakılamaz.",
                          ContentType.warning,
                        );
                      } else if (text == "") {
                        showMessage(
                          context,
                          "Boş alanlar var!",
                          "Metin alanı boş bırakılamaz.",
                          ContentType.warning,
                        );
                      } else {
                        String? imagePath;
                        if (selectedImage != null) {
                          imagePath = await saveImageToAssets(selectedImage!);
                        }

                        ProblemDAO().addProblem(
                          widget.userFK,
                          title,
                          text,
                          isAnonymous,
                          imagePath!,
                          importanceLevel.index + 1,
                        );

                        showMessage(
                          context,
                          "Başarılı",
                          "Bildirinizi kaydettik. Listeleme sayfasına yönlendiriliyorsunuz.",
                          ContentType.success,
                        );

                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProblemsPage(
                                userFK: widget.userFK,
                              ),
                            ),
                          );
                        });
                      }
                    },
                    text: "BİLDİR",
                    color: kProblemColor,
                    textColor: Colors.white,
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
