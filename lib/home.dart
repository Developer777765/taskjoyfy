import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  String? recieve;
  HomePage([this.recieve]);
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: const Center(child: Text('Joyfy Tech. Private Limited')),
    );
  }
}
