import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Radiopage extends StatefulWidget {
  const Radiopage({super.key});

  @override
  State<Radiopage> createState() => _RadioState();
}

class _RadioState extends State<Radiopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
    );
  }
}
