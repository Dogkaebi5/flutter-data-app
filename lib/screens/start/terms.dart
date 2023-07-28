import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/setting/set_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsScreen extends StatefulWidget{
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreen();
}

class _TermsScreen extends State<TermsScreen>{
  List<bool> checklist = List.filled(5, false);
  
  void allCheck(){
    setState(() {
      checklist[0] = !checklist[0];
    });
    if(checklist[0]){
      setState(() => checklist = List.filled(5, true));
    }else {
      setState(() => checklist = List.filled(5, false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => allCheck(),
                    child: Text('전체동의',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ), 
                  Checkbox(
                    value: checklist[0], 
                    onChanged: (val) => allCheck(),
                  ),
                ]
              ),
              Divider(thickness: 2,),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: .8,
                            )
                          )
                        ),
                        child: Text('서비스 이용약관 동의',),
                      ),
                    ), 
                    Text(" (필수)", style: TextStyle(color: Colors.deepPurple),),
                    Spacer(),
                    Checkbox(
                      value: checklist[1], 
                      onChanged: (value){
                        setState(() => checklist[1] = value!);
                        (checklist[1] && checklist[2] && checklist[3] && checklist[4])
                          ?setState(() => checklist[0] = true)
                          :setState(() => checklist[0] = false);
                      }
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: .8,
                            )
                          )
                        ),
                        child: Text('개인정보이용동의',),
                      ),
                    ), 
                    Text(" (필수)", style: TextStyle(color: Colors.deepPurple),),
                    Spacer(), 
                    Checkbox(
                      value: checklist[2], 
                      onChanged: (value){
                        setState(() => checklist[2] = value!);
                        (checklist[1] && checklist[2] && checklist[3] && checklist[4])
                          ?setState(() => checklist[0] = true)
                          :setState(() => checklist[0] = false);
                      }
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: .8,
                            )
                          )
                        ),
                        child: Text('텔레마케팅 활용 동의',),
                      ),
                    ), 
                    Spacer(),
                    Checkbox(
                      value: checklist[3], 
                      onChanged: (value){
                        setState(() => checklist[3] = value!);
                        (checklist[1] && checklist[2] && checklist[3] && checklist[4])
                          ?setState(() => checklist[0] = true)
                          :setState(() => checklist[0] = false);
                      }
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('만 14세 이상입니다'),
                    Text(" (필수)", style: TextStyle(color: Colors.deepPurple),),
                    Spacer(),
                    Checkbox(
                      value: checklist[4], 
                      onChanged: (value){
                        setState(() => checklist[4] = value!);
                        (checklist[1] && checklist[2] && checklist[3] && checklist[4])
                          ?setState(() => checklist[0] = true)
                          :setState(() => checklist[0] = false);
                      }
                    )
                  ],
                ),
              ]),
              
              Container(
                padding: EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 60, 
                child: ElevatedButton(
                  onPressed:(checklist[1] && checklist[2] && checklist[4])
                    ?(){
                      if(checklist[3]){
                        String date = DateTime.now().toString().split(' ')[0];
                        context.read<SettingProvider>().setTmPermission(true, date);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SetPasswordScreen()),
                      );
                    } : null,
                  child: Text("다음"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}