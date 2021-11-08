import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'intro_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'List of Contributors'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: listOfUsers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(listOfUsers[index]['name']),
                onTap: () {
                  _launchURL(listOfUsers[index]['name']);
                },
                subtitle: Text(listOfUsers[index]['year']),
                trailing: ElevatedButton(
                  child: Text("View Profile"),
                  onPressed: () {
                    _launchURL(listOfUsers[index]['gitHubUrl']);
                  },
                ),
              );
            }));
  }

  void _launchURL(String url) async => await canLaunch(
        url,
      )
          ? await launch(
              url,
              forceWebView: true,
              enableJavaScript: true,
            )
          : throw 'Could not launch $url';
}
