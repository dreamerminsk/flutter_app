import 'dart:async';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kbapp/src/kb/kb.dart';
import 'package:kbapp/src/kb/model.dart';
import 'package:kbapp/src/services/firestore_service.dart';
import 'package:provider/provider.dart';

import '../utils/formatters.dart';
import 'weekend_box_office_screen.dart';
import 'year_box_office_screen.dart';

class BoxOfficeHomeModel with ChangeNotifier {
  List<YearRecord> items;
  FirestoreService db = new FirestoreService();

  StreamSubscription<QuerySnapshot> yearSub;

  List<Thursday> thursdays;
  StreamSubscription<QuerySnapshot> thursdaySub;

  List<Weekend> weekends;
  StreamSubscription<QuerySnapshot> weekendSub;

  final KbApi kb = KbApi();

  BoxOfficeHomeModel() {
    initState();
  }

  void initState() {
    items = new List();

    thursdaySub?.cancel();
    thursdaySub = db.getThursdayList().listen((QuerySnapshot snapshot) {
      final List<Thursday> thursdays = snapshot.documents
          .map((documentSnapshot) => Thursday.fromMap(documentSnapshot.data))
          .toList();
      this.thursdays = thursdays;
      if (this.thursdays != null && this.thursdays.length > 0) {
        var diff = DateTime.now().difference(this.thursdays[0].lastUpdated);
        developer.log(
            '${DateTime.now()} - ${this.thursdays[0].lastUpdated} = ${diff
                .inHours}');
        if (diff.inHours.abs() > 24) {
          kb.getThursdaysv2().then((data) =>
              data.forEach((element) {
                db.createThursday(element);
              }));
        }
      }

      notifyListeners();
    });

    weekendSub?.cancel();
    weekendSub = db.getWeekendList().listen((QuerySnapshot snapshot) {
      final List<Weekend> weekends = snapshot.documents
          .map((documentSnapshot) => Weekend.fromMap(documentSnapshot.data))
          .toList();
      this.weekends = weekends;
      developer.log('${this.weekends}');
      if (this.weekends != null && this.weekends.length > 0) {
        var diff = DateTime.now().difference(this.weekends[0].lastUpdated);
        developer.log(
            '${DateTime.now()} - ${this.weekends[0].lastUpdated} = ${diff
                .inHours}');
        if (diff.inHours.abs() > 24) {
          kb.getWeekendsv2().then((data) =>
              data.forEach((element) {
                db.createWeekend(element);
              }));
        }
      }
      notifyListeners();
    });

    yearSub?.cancel();
    yearSub = db.getYearList(limit: 20).listen((QuerySnapshot snapshot) {
      final List<YearRecord> years = snapshot.documents
          .map((documentSnapshot) => YearRecord.fromMap(documentSnapshot.data))
          .toList();

      this.items = years;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    thursdaySub?.cancel();
    weekendSub?.cancel();
    yearSub?.cancel();
    super.dispose();
  }
}

class BoxOfficeHome extends StatelessWidget {
  final items = <String>['ЧЕТВЕРГ', 'УИКЕНД', 'ГОД', 'ДИСТРИБЬЮТОРЫ'];
  final headers = <Widget>[];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BoxOfficeHomeModel(),
        child: Consumer<BoxOfficeHomeModel>(
            builder: (context, model, child) =>
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${items[0]} ${model.thursdays != null ? model
                                .thursdays[0]?.title : ''}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text('$index. Нет информации'),
                              );
                            },
                            itemCount: 10, // this is a hardcoded value
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${items[1]} ${model.weekends != null ? model
                                .weekends[0]?.title : ''}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text('$index. Нет информации'),
                              );
                            },
                            itemCount: 10, // this is a hardcoded value
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${items[2]}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Table(columnWidths: {
                                  0: FlexColumnWidth(3),
                                  1: FlexColumnWidth(20),
                                  2: FlexColumnWidth(10),
                                }, children: <TableRow>[
                                  TableRow(children: <Widget>[
                                    TableCell(
                                        child: Padding(
                                            padding:
                                            EdgeInsets.only(right: 8.0),
                                            child: Text('${index + 1}',
                                                textAlign: TextAlign.end))),
                                    TableCell(
                                        child: Text(
                                          '${model.items[index].title}',
                                          textAlign: TextAlign.start,
                                        )),
                                    TableCell(
                                        child: Text(
                                            '${decimalFormatter.format(
                                                model.items[index].boxOffice)}',
                                            textAlign: TextAlign.end))
                                  ])
                                ]),
                              );
                            },
                            itemCount:
                            model.items.length, // this is a hardcoded value
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${items[3]}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText1,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text('$index. Нет информации'),
                              );
                            },
                            itemCount: 10, // this is a hardcoded value
                          ),
                        ],
                      ),
                    ),
                  ],
                )));
  }
}

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  List<String> _titles = <String>['БОКСОФИС', 'АФИША', 'УИКЕНД', 'ГОД'];

  List<Widget> _widgets = <Widget>[
    BoxOfficeHome(),
    ComingSoonPage(),
    WeekendBoxOffice(),
    YearBoxOffice()
  ];

  get currentIndex => _currentIndex;

  get currentTitle => _titles[_currentIndex];

  get currentWidget => _widgets[_currentIndex];

  get loading => false;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  update() {
    if (currentWidget is YearBoxOffice) {
      //(currentWidget as YearBoxOffice).update();
    }
  }
}

class ComingSoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('NOT IMPLEMENTED YET'));
  }
}

class BoxOfficePage extends StatelessWidget {
  final rng = new Random();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('${provider.currentTitle}'), actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.autorenew),
          onPressed: () async {
            var idx = provider.currentIndex;
            if (idx == 2) {
              Provider.of<WeekendModel>(context, listen: false).load();
            } else if (idx == 3) {
              Provider.of<YearModel>(context, listen: false).load();
            }
          },
        ),
      ]),
      body: provider.currentWidget,
      bottomNavigationBar: new BottomNavigationBar(
        selectedItemColor: Colors.deepOrange,
        //backgroundColor: Colors.indigoAccent,
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: const Icon(Icons.monetization_on),
              title: new Text("БОКСОФИС")),
          new BottomNavigationBarItem(
              icon: const Icon(Icons.movie), title: new Text("АФИША")),
          new BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today),
              title: new Text("УИКЕНД")),
          new BottomNavigationBarItem(
              icon: const Icon(Icons.date_range), title: new Text("ГОД"))
        ],
      ),
    );
  }
}
