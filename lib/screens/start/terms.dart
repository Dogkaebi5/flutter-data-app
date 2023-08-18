import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/screens/setting/set_password.dart';
import 'package:data_project/widgets/term_checkbox.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsScreen extends StatefulWidget{
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreen();
}

class _TermsScreen extends State<TermsScreen>{
  List<bool> checklist = List.filled(5, false);
  final UserDataController controller = Get.put(UserDataController());

  void allCheck(){
    setState(() {
      checklist[0] = !checklist[0];
      (checklist[0])? checklist = List.filled(5, true) : checklist = List.filled(5, false);
    });
  }
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
                    child: const Text('전체동의',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))), 
                  Checkbox(value: checklist[0], onChanged: (val) => allCheck()),
              ]),
              const Divider(thickness: 2),

              TermCheckbox(text: "서비스 이용약관 동의", isLink: true, isRequired: true, 
                isChecked: checklist[1], 
                textOnTap: (){}, 
                checkboxOnChanged: (value){
                  setState(() => checklist[1] = value);
                  allCheckControl();
                }),

              TermCheckbox(text: "개인정보이용동의", isLink: true, isRequired: true, 
                isChecked: checklist[2], 
                textOnTap: (){}, 
                checkboxOnChanged: (value){
                  setState(() => checklist[2] = value);
                  allCheckControl();
                }),

              TermCheckbox(text: "텔레마케팅 활용 동의", isLink: true, isRequired: false, 
                isChecked: checklist[3], 
                textOnTap: (){}, 
                checkboxOnChanged: (value){
                  setState(() => checklist[3] = value);
                  allCheckControl();
                }),

              TermCheckbox(text: "만 14세 이상입니다", isLink: false, isRequired: true, 
                isChecked: checklist[4], 
                textOnTap: (){}, 
                checkboxOnChanged: (value){
                  setState(() => checklist[4] = value);
                  allCheckControl();
                }),

              const SizedBox(height: 16),
              ElevatedButton(
                style: btnStyle,
                onPressed:(checklist[1] && checklist[2] && checklist[4])
                  ?(){
                    bool isPermit = checklist[3]; 
                    controller.setUserPermit(4, isPermit);
                    navPush(context, SetPasswordScreen());
                  } : null,
                child: const Text("다음"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}