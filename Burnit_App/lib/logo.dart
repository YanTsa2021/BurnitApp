//Logo or splash implementation

import 'package:burnit_app/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => LogoPage(),
    },
  ));
}

class LogoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds:10),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Login()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 450,
      //height: 450,
      width: MediaQuery.of(context).size.height,
        alignment:Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/ImgBurnit.png'),
             )
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => Login()));
          },
        )
    );
  }
}