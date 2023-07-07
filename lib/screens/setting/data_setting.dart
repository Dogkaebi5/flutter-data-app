import 'package:data_project/screens/setting/interest_info.dart';
import 'package:data_project/screens/setting/additional_info.dart';
import 'package:data_project/screens/setting/basic_info.dart';
import 'package:data_project/screens/setting/permission.dart';
import 'package:flutter/material.dart';

class DataPage extends StatelessWidget {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('데이터 설정')),
      body: Container(
        margin: EdgeInsets.only(top: 20, left:20, right:20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BasicInfo(isNewUser:false)),
                );
              },
              child: Container(
                padding: EdgeInsets.all(20),
                color: const Color.fromARGB(255, 194, 226, 241) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("기본정보 설정"),
                    Icon(Icons.arrow_forward_ios),
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(color: Colors.black, thickness: 1,),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Interest(isNewUser:false)),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(20),
                color: const Color.fromARGB(255, 194, 226, 241) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("관심사 설정"),
                    Icon(Icons.arrow_forward_ios),
                  ]
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddInfo(false)),
                );
              },
              child: Container(
                padding: EdgeInsets.all(20),
                color: const Color.fromARGB(255, 194, 226, 241) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("추가정보 설정"),
                    Icon(Icons.arrow_forward_ios),
                  ]
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Divider(color: Colors.black, thickness: 1,),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoPremission()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(20),
                color: const Color.fromARGB(255, 194, 226, 241) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("데이터 판매범위 설정"),
                    Icon(Icons.arrow_forward_ios),
                  ]
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}