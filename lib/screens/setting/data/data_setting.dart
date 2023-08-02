import 'package:data_project/screens/setting/data/interest.dart';
import 'package:data_project/screens/setting/data/additional.dart';
import 'package:data_project/screens/setting/data/basic.dart';
import 'package:data_project/screens/setting/data/permission.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  createLinkBox(context, title, color, screen){
    return InkWell(
      onTap: () => navPush(context, screen),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 48, horizontal: 28),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(
              color: Colors.grey.withOpacity(.6),
              blurRadius: 6,
              spreadRadius : 1,
              offset: Offset(2, 4)
            )],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),),
            Icon(Icons.arrow_forward_ios,
              size: 16,
              color: Colors.deepPurple.shade50,
    )])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(title: Text('데이터 설정')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          createLinkBox(context, "기본정보 설정", Colors.deepPurple, BasicDataScreen()),
          SizedBox(height: 16,),
          createLinkBox(context, "관심사 설정", Colors.deepPurple.shade300, InterestScreen()),
          SizedBox(height: 8,),
          createLinkBox(context, "추가정보 설정", Colors.purple.shade200, AdditionalScreen()),
          SizedBox(height: 20,),
          InkWell(
            onTap: () => navPush(context, PermissionScreen()),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(
                    color: Colors.grey.withOpacity(.6),
                    blurRadius: 6,
                    spreadRadius : 1,
                    offset: Offset(2, 4)
                  )],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [ 
                  Text("데이터 판매설정",
                    style: TextStyle(
                      fontSize: 16,
                    ),),
                  Icon(Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ]
              ),
            ),
          ),
        ]
      ),
    );
  }
}