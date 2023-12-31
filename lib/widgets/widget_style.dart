import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

final btnStyle = ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 44));
const testBtnStyle = TextStyle(
  color: Color.fromRGBO(189, 189, 189, 1), 
  decoration: TextDecoration.underline
);
const inputDecoration = InputDecoration(
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.all(12),
  counterText: "",
);

final greyShadow = BoxShadow(
  color: Colors.grey.withOpacity(.6),
  blurRadius: 6,
  spreadRadius : 1,
  offset: Offset(2, 4)
);

const fontBigColorTitle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 24,
  color: Color.fromRGBO(126, 87, 194, 1),
);
const fontSmallTitle =  TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16);
const fontSmallGrey = TextStyle(
  fontSize: 12,
  color: Colors.grey
);

final defaultPin = PinTheme(
  height: 60,
  width: 60,
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(20)
));
final focusedPin = PinTheme(
  height: 60,
  width: 60,
  decoration: BoxDecoration(
    color: Colors.purple.shade100,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.purple, width: 1.2 )
));
final submittedPin = PinTheme(
  height: 60,
  width: 60,
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.purple.shade200, width: 1),
));


navPush(context, screen) =>  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => screen)
);
navPop(context) => Navigator.pop(context);

