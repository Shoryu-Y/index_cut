import 'package:flutter/material.dart';
import 'package:index_cut/index_cut.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final items = [
    const Text('1', style: TextStyle(fontSize: 18)),
    const Text('2', style: TextStyle(fontSize: 18)),
    const Text('3', style: TextStyle(fontSize: 18)),
    const Text('4', style: TextStyle(fontSize: 18)),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: SafeArea(
          child: IndexCut(
            currentIndex: currentIndex,
            icons: items,
            isOneWay: false,
            onChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            child: Center(
              child: items[currentIndex],
            ),
          ),
        ),
      ),
    );
  }
}
