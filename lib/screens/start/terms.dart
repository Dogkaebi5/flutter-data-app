import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/setting/set_password.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsScreen extends StatefulWidget{
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreen();
}

class _TermsScreen extends State<TermsScreen>{
  List<bool> checklist = List.filled(5, false);
  final boxDecoration = BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Colors.black,
        width: .8,
  )));

  createCheckbox(i) => Checkbox(
    value: checklist[i], 
    onChanged: (value){
      setState(() => checklist[i] = value!);
      allCheckControl();
    }
  );

  void allCheck(){
    setState(() {
      checklist[0] = !checklist[0];
      if(checklist[0]){
        checklist = List.filled(5, true);
      }else{
        checklist = List.filled(5, false);
  }});}
  void allCheckControl(){
    (checklist[1] && checklist[2] && checklist[3] && checklist[4])
      ?setState(() => checklist[0] = true)
      :setState(() => checklist[0] = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => allCheck(),
                    child: Text('전체동의',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                  ),),), 
                  Checkbox(
                    value: checklist[0], 
                    onChanged: (val) => allCheck(),
                  ),
                ]
              ),
              Divider(thickness: 2,),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      // need link
                    },
                    child: Container(
                      decoration: boxDecoration,
                      child: Text('서비스 이용약관 동의',),
                    ),
                  ), 
                  Text(" (필수)", style: TextStyle(color: Colors.deepPurple),),
                  Spacer(),
                  createCheckbox(1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){},
                    child: Container(
                      decoration: boxDecoration,
                      child: Text('개인정보이용동의',),
                    ),
                  ), 
                  Text(" (필수)", style: TextStyle(color: Colors.deepPurple),),
                  Spacer(), 
                  createCheckbox(2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){},
                    child: Container(
                      decoration: boxDecoration,
                      child: Text('텔레마케팅 활용 동의',),
                    ),
                  ), 
                  Spacer(),
                  createCheckbox(3),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('만 14세 이상입니다'),
                  Text(" (필수)", style: TextStyle(color: Colors.deepPurple),),
                  Spacer(),
                  createCheckbox(4),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: btnStyle,
                onPressed:(checklist[1] && checklist[2] && checklist[4])
                  ?(){
                    context.read<SettingProvider>().setTmPermission(checklist[3]);
                    navPush(context, SetPasswordScreen());
                  } : null,
                child: Text("다음"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}