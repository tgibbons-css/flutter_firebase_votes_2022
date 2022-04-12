import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> _colors = [];
  TextEditingController _favColor = new TextEditingController();
  CollectionReference colorListDB = FirebaseFirestore.instance.collection('COLORS');

  void _actionButtonClick() {
    setState(() {
      print('Action button click');
      _colors.add("blue");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'What is your favorite color?',
            style: Theme.of(context).textTheme.headline4,
          ),
          voteWidget(),
          Text(
            'List of colors:',
            style: Theme.of(context).textTheme.headline4,
          ),
          colorList()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _actionButtonClick,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  SizedBox colorList() {
    return SizedBox(
          height: 300,
          child: StreamBuilder(
            stream: colorListDB.snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                //itemCount: _colors.length,
                itemBuilder: (BuildContext context, int position) {
                  //return Text(_colors[position]);
                  return Text(snapshot.data?.docs[position]['fav_color']);
                },
              );
            }
          ),
        );
  }
  void _voteButtonClick() {
    setState(() async {
      print('Vote button click');
      //_colors.add(_favColor.text);
      await colorListDB.add({'fav_color': _favColor.text});
      _favColor.clear();
    });
  }

  Row voteWidget() {
    return Row(
          children: [
            Text('Enter your color:  '),
            SizedBox(child: TextField(controller: _favColor,), width: 200,),
            ElevatedButton(
                onPressed: _voteButtonClick,
                child: Text('Vote'))
          ],
        );
  }
}
