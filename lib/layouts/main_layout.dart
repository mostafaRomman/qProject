// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q_project/modules/deterministic_qs_ui.dart';

class QLayout extends StatefulWidget {
  const QLayout({Key? key}) : super(key: key);

  @override
  _QLayoutState createState() => _QLayoutState();
}

class _QLayoutState extends State<QLayout> {
  List qModels = ['D/D/1/K', 'M/M/1', 'M/M/1/K', 'M/M/C', 'M/M/C/K'];

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: const Center(
          child: Text(
            'Queueing Theory',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Chose your model',
                textAlign: TextAlign.left,
                textScaleFactor: 1.8,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Colors.blueAccent,
                        height: MediaQuery.of(context).size.height / 8,
                        elevation: 4,
                        onPressed: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DD1K()),
                            );
                          } else {
                            Scaffold.of(context).showSnackBar(
                              const SnackBar(
                                elevation: 4,
                                duration: Duration(milliseconds: 500),
                                content: Text(
                                  'Not working now',
                                  style: TextStyle(color: Colors.yellow),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          qModels[index].toString(),
                          textScaleFactor: 2,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: 1,
                      ),
                  itemCount: qModels.length),
            ),
          ],
        )),
      ),
    );
  }
}
