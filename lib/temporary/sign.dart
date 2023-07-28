import 'package:flutter/material.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  String telNum = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height:320),
            TextField(
              keyboardType: TextInputType.phone,
              maxLength: 11,
              decoration: InputDecoration(
                icon: Icon(Icons.phone_iphone),
                labelText: "전화번호",
                border: OutlineInputBorder(),
                counterText: "",
              ),
              onChanged: (value) => setState(()=> telNum = value.toString()),
            ),
            SizedBox(height: 12,),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: (telNum.length == 11)
                  ?(){}
                  :null,                
                child: Text("확인"),
              ),
            )
          ],
        ),
      ),
    );
  }
}