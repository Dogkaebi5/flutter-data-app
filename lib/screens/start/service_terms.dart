import 'package:data_project/screens/setting/set_password.dart';
import 'package:flutter/material.dart';

class Terms extends StatefulWidget{
  const Terms({super.key});

  @override
  State<Terms> createState() => _Terms();
}

class _Terms extends State<Terms>{
  bool isAllChecked = false;
  bool isTermChecked = false;
  bool isPolicyChecked = false;
  bool isTMChecked = false;
  bool is14Checked = false;
  bool isButtonActive(){
    bool isActive = false;
    if(isTermChecked && isPolicyChecked && is14Checked){
      isActive = true;
    } 
    return isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('전체동의'), 
                Checkbox(
                  value: isAllChecked, 
                  onChanged: (value){
                    setState(() {
                      isAllChecked = value!;
                    });
                    if(isAllChecked){
                      setState(() {
                        isTermChecked = true;
                        isPolicyChecked = true;
                        isTMChecked = true;
                        is14Checked = true;
                        isButtonActive();
                      });
                    }else {
                      setState(() {
                        isTermChecked = false;
                        isPolicyChecked = false;
                        isTMChecked = false;
                        is14Checked = false;
                        isButtonActive();
                      });
                    }
                  }
                ),
              ]
            ),
            Divider(thickness: 2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {}, 
                  child: Text('서비스 이용약관 동의(필수)'),
                ), 
                Checkbox(
                  value: isTermChecked, 
                  onChanged: (value){setState((){
                    isTermChecked = value!;
                    isButtonActive();
                  });}
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {}, 
                  child: Text('개인정보이용동의(필수)'),
                ), 
                Checkbox(
                  value: isPolicyChecked, 
                  onChanged: (value){setState((){
                    isPolicyChecked = value!;
                    isButtonActive();
                  });}
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {}, 
                  child: Text('텔레마케팅 활용 동의'),
                ), 
                Checkbox(
                  value: isTMChecked, 
                  onChanged: (value){setState((){
                    isTMChecked = value!;
                  });}
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('   만 14세 이상입니다(필수)'), 
                Checkbox(
                  value: is14Checked,
                  onChanged: (bool? value){
                    setState((){
                      is14Checked = value!;
                      isButtonActive();
                    });
                  }
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              width: double.infinity,
              height: 60, 
              child: ElevatedButton(
                onPressed:isButtonActive()
                  ?(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SetPassword()),
                    );
                  } : null,
                child: Text("다음"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}