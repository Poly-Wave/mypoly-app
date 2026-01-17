import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypoly/enum/flavor.dart';

void main() {
  final flavor = Flavor.fromString(appFlavor ?? "prod");

  print(flavor);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
