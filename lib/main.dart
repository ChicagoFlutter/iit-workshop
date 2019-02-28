import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:random_names/random_names.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final numberOfItems = 500;
    final names = Future.delayed(
      Duration(seconds: 5),
      () {
        return Future.value(
          generateRandomNames(numberOfItems),
        );
      },
    );
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('IIT Rocks'),
        ),
        body: FutureBuilder(
          initialData: [],
          future: names,
          builder: (_, AsyncSnapshot value) {
            return ListView.builder(
              itemCount: value.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(value.data[index]),
                  onTap: () {
                    final Widget details = Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Icon(Icons.insert_emoticon),
                          Text(value.data[index])
                        ],
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return NewPage(child: details);
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  final Widget child;

  NewPage({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Center(child: child),
    );
  }
}
