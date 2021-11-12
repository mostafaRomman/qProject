import 'package:flutter/material.dart';

class QLayout extends StatefulWidget {
  const QLayout({Key? key}) : super(key: key);

  @override
  _QLayoutState createState() => _QLayoutState();
}

class _QLayoutState extends State<QLayout> {
  List qModels = ['D/D/1/K-1', 'M/M/1', 'M/M/1/K', 'M/M/C', 'M/M/C/K'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Queueing Theory',
            style: TextStyle(color: Colors.black),
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
              height: 20,
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
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        color: Colors.teal,
                        height: MediaQuery.of(context).size.height / 8,
                        elevation: 8,
                        onPressed: () {},
                        child: Text(
                          qModels[index].toString(),
                          textScaleFactor: 2,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.black87),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                        color: Colors.black12,
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
