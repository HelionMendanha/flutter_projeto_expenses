import 'package:expenses/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    */
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyDelayPage extends StatefulWidget {
  @override
  State<MyDelayPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyDelayPage> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return ExpenseApp();
              }),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          "assets/images/dinheiro.gif",
          gaplessPlayback: true,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
