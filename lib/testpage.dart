import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var date = DateTime.timestamp();
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("테스트"),
        ElevatedButton(onPressed: (){print(date);}, child:Text("date") )
      ],
    );
  }
}