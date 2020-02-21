import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kbapp/src/kb/kb.dart';
import 'package:kbapp/src/kb/model.dart';
import 'package:kbapp/src/utils/formatters.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MovieModel with ChangeNotifier {}

class MovieScreenV2 extends StatelessWidget {
  final Movie movie;

  MovieScreenV2(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

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
              padding: EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 5.0,
              ),
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.network(
                        snapshot.data.poster ??
                            'https://img.icity.life/upload/no_poster.jpg',
                        width: 140),
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
                            .bodyText2)
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
                      child: Text('Первый четверг',
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                    TableCell(
                      child: Text(
                          '${fullDateFormatter.format(
                              snapshot.data.thursdayRus?.date ??
                                  DateTime.now())}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                    TableCell(
                      child: Text(
                          '${decimalFormatter.format(
                              snapshot.data.thursdayRus?.total ?? 0)}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text('Первый уик-энд',
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                    TableCell(
                      child: Text(
                          '${fullDateFormatter.format(
                              snapshot.data.weekendRus?.date ??
                                  DateTime.now())}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                    TableCell(
                      child: Text(
                          '${decimalFormatter.format(
                              snapshot.data.weekendRus?.total ?? 0)}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text('Общий сбор',
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                    TableCell(
                      child: Text(
                          '${fullDateFormatter.format(
                              snapshot.data.totalRus?.date ?? DateTime.now())}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                    TableCell(
                      child: Text(
                          '${decimalFormatter.format(
                              snapshot.data.totalRus?.total ?? 0)}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                  ]),
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text('Зрители',
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                    TableCell(
                      child: Text(
                          '${fullDateFormatter.format(
                              snapshot.data.spectaculars?.date ??
                                  DateTime.now())}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                    TableCell(
                      child: Text(
                          '${decimalFormatter.format(
                              snapshot.data.spectaculars?.total ?? 0)}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            //color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 18)),
                    ),
                  ]),
                ]),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      Text('Касса мирового проката',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18)),
                    ]),
                Table(children: <TableRow>[
                  TableRow(children: <Widget>[
                    TableCell(
                      child: Text('Сборы в США'),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 0.0),
                      child: Text(
                        'Режиссёр(ы)',
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontSize: 18.0),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: const Size.fromHeight(120.0),
                      child: ListView.builder(
                        itemCount: snapshot.data.directors.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(top: 0.0, left: 0.0),
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.deepOrange,
                                    backgroundImage: NetworkImage(
                                      //snapshot
                                      //.data.directors
                                      //.elementAt(index)
                                      //.avatar ??
                                        'https://m.media-amazon.com/images/G/01/imdb/images/nopicture/medium/name-2135195744._CB466677935_.png'),
                                    radius: 40.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(snapshot.data.directors
                                        .elementAt(index)
                                        .fullName),
                                  ),
                                ],
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 0.0),
                      child: Text(
                        'Актёры',
                        style: Theme
                            .of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(fontSize: 18.0),
                      ),
                    ),
                    SizedBox.fromSize(
                      size: const Size.fromHeight(120.0),
                      child: ListView.builder(
                        itemCount: snapshot.data.actors.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(top: 0.0, left: 0.0),
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.deepOrange,
                                    backgroundImage: NetworkImage(snapshot
                                        .data.actors
                                        .elementAt(index)
                                        .avatar ??
                                        'https://m.media-amazon.com/images/G/01/imdb/images/nopicture/medium/name-2135195744._CB466677935_.png'),
                                    radius: 40.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(snapshot.data.actors
                                        .elementAt(index)
                                        .fullName),
                                  ),
                                ],
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
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
