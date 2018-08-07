import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new ScopedModel(
        model: new CounterModel(),
        child: new MaterialApp(
          title: 'Incrementor',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new MyHomePage(title: 'Incrementor'),
        ),
    );
  }
}

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new ScopedModelDescendant<CounterModel>(
              builder: (context, child, model) => new Text(
                  model.counter.toString(),
                  style: Theme.of(context).textTheme.display1),
            ),
          ],
        ),
      ),
      floatingActionButton: new ScopedModelDescendant<CounterModel>(
        builder: (context, child, model) => new FloatingActionButton(
          onPressed: model.increment,
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
