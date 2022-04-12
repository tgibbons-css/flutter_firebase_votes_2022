import 'package:flutter/material.dart';

void main() {
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
  
  void _actionButtonClick() {
    setState(() {
      print('Action button click');
      _colors.add("blue");
    });
  }

  void _voteButtonClick() {
    setState(() {
      print('Vote button click');
      _colors.add(_favColor.text);
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
          Row(
            children: [
              Text('Enter your color:  '),
              SizedBox(child: TextField(controller: _favColor,), width: 200,),
              ElevatedButton(
                  onPressed: _voteButtonClick,
                  child: Text('Vote'))
            ],
          ),
          Text(
            'List of colors:',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: _colors.length,
              itemBuilder: (BuildContext context, int position) {
                return Text(_colors[position]);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _actionButtonClick,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
