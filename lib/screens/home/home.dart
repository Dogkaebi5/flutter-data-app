import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/provider/user_basic_data_provider.dart';
import 'package:data_project/provider/user_interest_data_provider.dart';
import 'package:data_project/screens/home/detail_dialog.dart';
import 'package:data_project/screens/start/auth_router.dart';
import 'package:data_project/widgets/detail_card.dart';
import 'package:data_project/widgets/nav_bar.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:data_project/screens/point/withdraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List details = List.empty(growable: true);
  int point = 0;
  bool hasNewNotice = false;
  List<bool> sortSelections = [true, false];
  DateTime signUpDate = DateTime(2023, 1, 1);
  DateTime today = DateTime.now();
  String sortStartDate ="2023-01-01";
  String sortEndDate ="2023-01-31";
  
  void setSortDateText(selectStartDate, selectEndDate){
    setState((){
      sortStartDate = selectStartDate;
      sortEndDate = selectEndDate;
    });
  }
  void setOneMonth(){
    setState((){
      sortSelections = [true, false];
      sortStartDate = today.subtract(Duration(days:30)).toString().split(' ')[0];
      sortEndDate =  today.toString().split(' ')[0];
    });
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      details = context.read<SettingProvider>().details;
      point = context.read<SettingProvider>().point;
      hasNewNotice = context.read<SettingProvider>().hasNewNotice;
      setSortDateText(
        today.subtract(Duration(days:30)).toString().split(' ')[0],
        today.toString().split(' ')[0]);
    });
  }

  @override
  Widget build(BuildContext context, ) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      bottomSheet: NavBar(), 
      body:  WillPopScope(
        onWillPop: () => Future(() => false),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal:24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 40,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("My Point",  style: TextStyle(color: Colors.white, fontSize: 18)),
                            const SizedBox(height: 4,),
                            Row(children: [
                              const Icon(Icons.account_balance_wallet, color: Colors.white, size: 32),
                              const SizedBox(width: 12,),
                              Text("$point P", 
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30))
                            ])
                        ]),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,),
                            child: const Icon(Icons.analytics, color: Colors.deepPurple, size: 28))
                    ]),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => navPush(context, WithdrawScreen()),
                      child: const SizedBox(width: 120, height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.toll,), SizedBox(width: 4),
                            Text("출금신청"), SizedBox(width: 8),
                          ],
                        ),
                    )),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 220),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),),
                  color: Color.fromARGB(255, 245, 245, 245),
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(.6),
                    blurRadius: 6,
                    spreadRadius : 1,
                  )]
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 28,),
                    ToggleButtons(
                      isSelected: sortSelections,
                      onPressed: (index) {
                        setState(() {
                          sortSelections = [false, false];
                          sortSelections[index] = !sortSelections[index];
                        });
                        if (index == 1) {showDatePickerDialog();
                        }else {setOneMonth();}
                      },              
                      children: const [
                        SizedBox(
                          width: 120,
                          child: Text("1개월", textAlign: TextAlign.center,)
                        ),
                        SizedBox(
                          width: 120,
                          child: Text("직접입력", textAlign: TextAlign.center,)
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  
                    if(sortSelections[1])
                      Text(
                        '검색기간 : $sortStartDate ~ $sortEndDate', 
                        style: fontSmallGrey
                      ),
                    const SizedBox(height: 12,),
                
                    if(details.isEmpty)
                      Row(children: const[
                        SizedBox(height:30, width:24),
                        Text("기록이 없습니다."),
                      ])
                    else 
                      for(int i = details.length-1; i > -1; i--)
                        DetailCard(
                          title: details[i]['title'], 
                          date: details[i]['date'], 
                          point: details[i]['point'],
                          onTap: (){detailDialog(context, i, details);}
                        ),

                    /////////////////test btns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: (){
                            FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) =>  AuthRouter()),
                              ModalRoute.withName('/'),
                            );
                          },
                          child: Text("/test\nlogout",style: testBtnStyle)
                        ),
                        TextButton(
                          onPressed: (){
                            FirebaseAuth.instance.signOut();
                            context.read<NewUserProvider>().setNewUser();
                            context.read<SettingProvider>().reset();
                            context.read<UserBasicData>().reset();
                            context.read<UserInterestData>().reset();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => AuthRouter()),
                              ModalRoute.withName('/'),
                            );
                          },
                          child: Text("/test\nnewUser", style: testBtnStyle)
                        ),
                        TextButton(
                          onPressed: (){setState((){
                            context.read<SettingProvider>().pointTest([10000]);
                            point = context.read<SettingProvider>().point;
                            hasNewNotice = context.read<SettingProvider>().hasNewNotice;
                          });},
                          child: Text("/test\n+10k", style: testBtnStyle)
                        ),
                        TextButton(
                          onPressed: (){setState((){
                            context.read<SettingProvider>().clearDetail();
                            point = context.read<SettingProvider>().point;
                          });},
                          child: Text("/test\ndel all", style: testBtnStyle)
                        ),
                      ],
                    ),
                    const SizedBox(height: 80,),
                  ]
                ),
              ),
            ]
              ),
          ),
        )
      ),
    );
  }

  showDatePickerDialog()=>
    showDialog(
      context: context, 
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Dialog(
          child: 
          SfDateRangePicker(
            selectionMode: DateRangePickerSelectionMode.range,
            showActionButtons: true,
            maxDate: DateTime.now(),
            minDate: signUpDate,
            onCancel: (){
              Navigator.pop(context);
              setOneMonth();
            },
            onSubmit: (pickerDate) {
              List date = pickerDate.toString().split(" ");
              if (date.length > 4 && date[4] != "null)"){
                setSortDateText(date[1], date[4]);
                print("4: $date");
                Navigator.pop(context);
              } else if (date.length > 4 && date[4] == "null)"){
                setSortDateText(date[1], date[1]);
                print("1: $date");
                Navigator.pop(context);
              } else {
                setOneMonth();
                Navigator.pop(context);
              }
            }
          ),
        )
      )
    );
}