import 'package:destek_ve_sikayet_portali/Event/event_page.dart';
import 'package:destek_ve_sikayet_portali/Problem/problems_page.dart';
import 'package:destek_ve_sikayet_portali/Profile/profile_page.dart';
import 'package:destek_ve_sikayet_portali/Suggestion/suggestion_page.dart';
import 'package:destek_ve_sikayet_portali/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final String name;
  final int pk;
  const HomePage({super.key, required this.name, required this.pk});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kHomeBackgroundColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kHomeColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: Text(
                      'Merhaba ${widget.name}',
                      style: GoogleFonts.montserrat(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Hoşgeldin!',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ProfilePage(email: "", nameSurname: "");
                          }),
                        );
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/images/cangumus.jpg'),
                      ),
                    )),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: kHomeColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: kHomeBackgroundColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: itemDashboard(
                      index == 0
                          ? 'Şikayetler ve Problemler'
                          : (index == 1 ? 'Öneriler' : 'Etkinlikler'),
                      index == 0
                          ? CupertinoIcons.doc_append
                          : (index == 1
                              ? CupertinoIcons.graph_circle
                              : CupertinoIcons.person_3),
                      index == 0
                          ? Colors.deepOrange
                          : (index == 1 ? Colors.green : Colors.purple),
                      size,
                      index == 0
                          ? kProblemLightColor
                          : (index == 1
                              ? kSuggestionLightColor
                              : kEventLightColor),
                      index == 0
                          ? ProblemsPage(userFK: widget.pk)
                          : (index == 1
                              ? SuggestionPage(
                                  userFK: widget.pk,
                                )
                              : EventsPage()),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background, Size size,
          Color color, Widget page) =>
      GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return page;
              }),
            );
          },
          child: Container(
            width: size.width * 0.9,
            height: size.height * 0.22,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 5),
                      color: Theme.of(context).primaryColor.withOpacity(.2),
                      spreadRadius: 2,
                      blurRadius: 5)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: size.width * 0.15,
                    height: size.height * 0.15,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(iconData, color: Colors.white)),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ));
}
