import 'package:flutter/material.dart';
import 'package:kurs2_sabak8/screens/home_screen.dart';

// Map
// API
// Json
// Asynchronous programming, Future (async, await, then), Stream
// Model
// Error handling
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
      home: HomeScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, @required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   @override
//   void initState() {
//     super.initState();
//     // okuuchuKosh();
//     // print(okuuchular);
//     callMethods();
//   }

//   void callMethods() async {
//     m1();
//     String _m2T = await m2();
//     m3(_m2T);
//   }

//   void m1() {
//     print('bul method 1');
//   }

//   Future<String> m2() async {
//     Duration _duration = Duration(microseconds: 250);

//     // sleep(duration);

//     String _text = 'method 2';

//     await Future.delayed(_duration, () {
//       print('bul method 2');
//     });

//     return _text;
//   }

//   void m3(String m2Text) {
//     print('bul method 3 with $m2Text');
//   }

//   //List, array, massiv
//   List<int> sandar1 = [1, 2, 3, 4, 5, 6];
//   List<int> sandar2 = [1, 2, 3, 4, 5, 6];
//   List<int> sandar3 = [1, 2, 3, 4, 5, 6];
//   List<String> jazuular = ['1', '2', '3', 'abc'];

//   // Okuuchu aty -- Baasy
//   //Map, key, value
//   Map<String, int> okuuchular = {
//     'Azim': 5,
//     'Aynura': 4,
//     'Azat': 5,
//   };

//   void okuuchuKosh() {
//     okuuchular['Azamat'] = 4;
//   }

//   Map<int, String> test = {
//     1: 'asd',
//     2: 'asdas',
//     3: 'adsa',
//   };

//   Map<String, List<int>> test2 = {
//     'Azim': [1, 2, 3, 4, 5, 6],
//     'Aynura': [1, 2, 5, 6],
//     'Azat': [4, 5, 6],
//   };

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
