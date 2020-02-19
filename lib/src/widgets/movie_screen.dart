import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kbapp/src/kb/kb.dart';
import 'package:kbapp/src/kb/model.dart';
import 'package:kbapp/src/utils/formatters.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MovieModel with ChangeNotifier {}

class MovieScreen extends StatelessWidget {
  final Movie movie;

  MovieScreen(this.movie);

  @override
  Widget build(BuildContext context) {
    final kb = KbApi();
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${this.movie.title}',
              style: Theme
                  .of(context)
                  .primaryTextTheme
                  .headline6,
            ),
            Text(
              '${this.movie.original}',
              style: Theme
                  .of(context)
                  .primaryTextTheme
                  .subtitle2,
            )
          ],
        ),
        actions: <Widget>[new Icon(Icons.more_vert)],
      ),
      body: FutureBuilder<Movie>(
        future: kb.getMovie(this.movie.kbRef),
        builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = ListView(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(
                        snapshot.data.poster ??
                            'https://img.icity.life/upload/no_poster.jpg',
                        width: 128),
                    Column(
                        mainAxisSize: MainAxisSize.min, children: <Widget>[]),
                  ],
                ),
                Wrap(
                  spacing: 4.0,
                  children: (snapshot.data.genres ?? <String>[])
                      .map(
                        (g) =>
                        Chip(
                          label: AutoSizeText(
                            g,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                          ),
                        ),
                  )
                      .toList(),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(snapshot.data.description ?? '',
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle2)
                  ],
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      Text('Кассовые сборы в России и СНГ:',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18)),
                    ]),
                Table(children: <TableRow>[
                  TableRow(children: <Widget>[
                    TableCell(
                      child: snapshot.data.thursdayRus.isNotEmpty
                          ? Text(
                          'Первый четверг (${fullDateFormatter.format(
                              snapshot.data.thursdayRus.entries
                                  .elementAt(0)
                                  ?.key)}):',
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18))
                          : Text('Первый четверг:'),
                    ),
                    TableCell(
                      child: snapshot.data.thursdayRus.isNotEmpty
                          ? Text(
                          '${decimalFormatter.format(
                              snapshot.data.thursdayRus.entries
                                  .elementAt(0)
                                  ?.value)}',
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18))
                          : Text(''),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text('Первый уик-энд:'),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text('Общий сбор:'),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text('Зрителей:'),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                  ]),
                ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      Text('Касса мирового проката:',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18)),
                    ]),
                Table(children: <TableRow>[
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text('Сборы в США:'),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text('Международные сборы:'),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text('Мировые сборы:'),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                  ]),
                ]),
              ],
            );
          } else if (snapshot.hasError) {
            children = Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 3)),
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            children = LoadingIndicator(
                color: Colors.deepOrange,
                indicatorType: Indicator.ballSpinFadeLoader);
          }
          return children;
        },
      ),
    );
  }
}
