import 'package:flutter/material.dart';
import 'package:tstorage/tstorage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Storage Demo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
 final String title;


_incrementCounter(int count) async {
  count = count + 1;
    await Storage().write("count", count);
}
  @override
  Widget build(BuildContext context) {
    var count;
    Storage().read('count', defaultValue: 0);
    return Scaffold(
      appBar: AppBar(

        title: Text(title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<dynamic>(
              stream: Storage().val.stream,
              builder: (context, snapshot) {
                if(!snapshot.hasData)
                return CircularProgressIndicator();
                count = snapshot.data;
            return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.headline4,
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(count),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
