import 'package:destek_ve_sikayet_portali/business_layer/users_bl.dart';
import 'package:destek_ve_sikayet_portali/data_layer/problems_db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../business_layer/problems_bl.dart';
import '../data_layer/users_db.dart';
import 'Report/report_a_problem.dart';
import '../constants.dart';
import 'components/card_widget.dart';

class ProblemsPage extends StatefulWidget {
  final int userFK;

  const ProblemsPage({super.key, required this.userFK});
  @override
  _ProblemsPageState createState() => _ProblemsPageState();
}

class _ProblemsPageState extends State<ProblemsPage> {
  List<Problems> _problems = [];

  @override
  void initState() {
    super.initState();
    showProblems();
  }

  Future<void> showProblems() async {
    List<Problems> problems = await ProblemDAO().getProblems();
    setState(() {
      _problems = problems;
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
                'Şikayetler ve Problemler',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, color: kProblemColor),
                textAlign: TextAlign.center,
              ),
            ),
            pinned: false,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final problem = _problems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<Users?>(
                    future: UserDAO().findUserWithPk(problem.userFK),
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
                                color: kProblemBackgroundColor,
                                blurRadius: 3.0,
                                spreadRadius: 0,
                                offset: Offset(0.0, 0.0),
                              ),
                            ],
                            border: Border.all(
                              color: kProblemColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: CardWidget(
                            title: problem.title,
                            text: problem.text,
                            retweetCount: problem.retweetCount,
                            name: user?.nameSurname ?? '',
                            important: problem.importance,
                            imgAssetName: problem.photoPath == null
                                ? ""
                                : problem.photoPath,
                          ),
                        );
                      }
                    },
                  ),
                );
              },
              childCount: _problems.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportAProblem(userFK: widget.userFK),
            ),
          );
        },
        backgroundColor: kProblemColor,
        child: Icon(Icons.note_add_rounded),
      ),
    );
  }
}
