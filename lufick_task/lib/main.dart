import 'package:flutter/material.dart';
import 'package:lufick_task/constants/constants.dart';
import 'package:lufick_task/routes/routing.dart';

void main() {
  runApp(new MyHomePage(initialRoute: RoutingNamesConstant.MAIN_SCREEN));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RoutingNamesConstant.MAIN_SCREEN,
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String initialRoute;
  MyHomePage({Key key, this.title, this.initialRoute}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState(initialRouteName: initialRoute);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String initialRouteName = "";
  _MyHomePageState({Key key, this.initialRouteName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute: initialRouteName,
      initialRoute: initialRouteName,
      routes: routes,
    );
  }
}
