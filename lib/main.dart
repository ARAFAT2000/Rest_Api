import 'package:api/pages/sign_up.dart';
import 'package:api/screen/example.dart';
import 'package:api/screen/example2.dart';
import 'package:api/screen/example3.dart';
import 'package:api/screen/home_screen.dart';

import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Exampletwo(),
    );
  }
}
