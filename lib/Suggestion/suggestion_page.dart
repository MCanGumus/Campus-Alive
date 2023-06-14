import 'package:destek_ve_sikayet_portali/Suggestion/Give/give_a_suggestion.dart';
import 'package:destek_ve_sikayet_portali/business_layer/suggestions_bl.dart';
import 'package:destek_ve_sikayet_portali/data_layer/suggestions_db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Problem/Report/report_a_problem.dart';
import '../Suggestion/components/card_widget.dart';
import '../business_layer/users_bl.dart';
import '../constants.dart';
import '../data_layer/users_db.dart';

class SuggestionPage extends StatefulWidget {
  final int userFK;

  SuggestionPage({required this.userFK});
  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  List<Suggestions> _suggestions = [];

  @override
  void initState() {
    super.initState();
    showItems();
  }

  Future<void> showItems() async {
    List<Suggestions> items = await SuggestionDAO().getSuggestions();
    setState(() {
      _suggestions = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                'Öneriler ve Tavsiyeler',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, color: kSuggestionColor),
                textAlign: TextAlign.center,
              ),
            ),
            pinned: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final item = _suggestions[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<Users?>(
                    future: UserDAO().findUserWithPk(item.userFK),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final user = snapshot.data;
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurStyle: BlurStyle.outer,
                                color: kSuggestionColor,
                                blurRadius: 3.0,
                                spreadRadius: 0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                            border: Border.all(
                              color: kSuggestionColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: CardWidget(
                            title: item.title.length >= 27
                                ? item.title.substring(0, 25) + '...'
                                : item.title,
                            text: item.text.length >= 150
                                ? item.text.substring(0, 150) + '...'
                                : item.text,
                            retweetCount: item.retweetCount,
                            name: user?.nameSurname ?? '',
                            important: 1,
                            imgAssetName: "",
                          ),
                        );
                      }
                    },
                  ),
                );
              },
              childCount: _suggestions.length,
            ),
          ),
        ],
      ),
      floatingActionButton: Positioned(
        bottom: 16.0,
        right: 16.0,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GiveSuggestion(
                  userFK: widget.userFK,
                ),
              ),
            );
          },
          backgroundColor: kSuggestionColor,
          child: Icon(Icons.add_reaction_rounded),
        ),
      ),
    );
  }
}
