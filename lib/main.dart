import 'package:flutter/material.dart';
import 'package:lab6/page/pageform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: const Color.fromARGB(255, 5, 176, 255)),
      ),
      home: const FirstPage()
    );
  }
}
