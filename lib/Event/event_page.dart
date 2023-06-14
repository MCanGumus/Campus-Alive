import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Event/components/card_widget.dart';
import '../constants.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kEventBackgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            backgroundColor: kEventColor,
            title: Center(
                child: Text('Etkinlikler',
                    style: GoogleFonts.montserrat(),
                    textAlign: TextAlign.center)),
            pinned: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          color: kEventColor,
                          blurRadius: 3.0,
                          spreadRadius: 0,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                      border: Border.all(
                        color: kEventLightColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: CardWidget(
                        title: 'Başlık $index',
                        text:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        retweetCount: 42,
                        name: 'Konum $index',
                        important: index % 4),
                  ),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
