import 'package:data_project/provider/new_user_provider.dart';
import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/provider/user_basic_data_provider.dart';
import 'package:data_project/provider/user_interest_data_provider.dart';
import 'package:data_project/screens/home/detail_dialog.dart';
import 'package:data_project/screens/home/notifications.dart';
import 'package:data_project/screens/setting/setting.dart';
import 'package:data_project/screens/start/auth_router.dart';
import 'package:data_project/screens/widget_style.dart';
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
      bottomSheet: customNavBar(), 
      body:  WillPopScope(
        onWillPop: () => Future(() => false),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal:24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 40,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("My Point", 
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18, ),),
                            SizedBox(height: 4,),
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet,
                                  color: Colors.white,
                                  size: 32,
                                  ),
                                SizedBox(width: 12,),
                                Text("$point P", 
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30))
                            ])
                        ]),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,),
                          child: Icon(
                            Icons.analytics,
                            color: Colors.deepPurple,
                            size: 28))
                    ]),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => navPush(context, WithdrawScreen()),
                      child: SizedBox(
                        width: 120,
                        height: 44,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.toll,),
                            SizedBox(width: 4),
                            Text("출금신청"),
                            SizedBox(width: 8),
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
                    SizedBox(height: 28,),
                    ToggleButtons(
                      isSelected: sortSelections,
                      onPressed: (index) {
                        setState(() {
                          sortSelections = [false, false];
                          sortSelections[index] = !sortSelections[index];
                        });
                        if (index == 1) {
                          showDatePickerDialog();
                        } else {
                          setOneMonth();
                        }
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
                    SizedBox(height: 8,),
                  
                    if(sortSelections[1])
                      Text(
                        '검색기간 : $sortStartDate ~ $sortEndDate', 
                        style: fontSmallGrey
                      ),
                    SizedBox(height: 12,),
                
                    if(details.isEmpty)
                      Row(
                        children: const [Padding(
                          padding: EdgeInsets.all(28),
                          child: Text("기록이 없습니다."),
                        )],
                      )
                    else 
                      for(int i = details.length-1; i > -1; i--)
                        createDetailCards(i),

                    //test btns
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
                    SizedBox(height: 80,),
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
  
  customNavBar(){
    return Container(
        height: 60,
        margin: EdgeInsets.only(bottom: 12, left: 8, right: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(.6),
            blurRadius: 6,
            spreadRadius : 1,
            offset: Offset(2, 4)
          ),],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            items:[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
              BottomNavigationBarItem(
                icon: (hasNewNotice) 
                  ?Stack(children: [
                    Icon(Icons.notifications),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    )
                  ],) 
                  :Icon(Icons.notifications),
                label: "알림"
              ),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "설정")
            ],
          selectedItemColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          currentIndex: 0,
          unselectedItemColor: Colors.deepPurple.shade200,
          
          onTap: (index){
            switch(index){
              case 0 : break;
              case 1 : navPush(context, NotificationScreen());
              case 2 : navPush(context, SettingScreen());
            }
          },
        ),
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

  createDetailCards(int loopInt){
    return InkWell(
      onTap: () => detailDialog(context, loopInt, details), 
      child: Card(
        margin: EdgeInsets.all(1),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(details[loopInt]['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 4,),
                  Text(
                    details[loopInt]['date'].split(' ')[0], 
                    style: fontSmallGrey
                  ),
                ],
              ),
              Text(details[loopInt]['point'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: details[loopInt]['point'].split(' ')[0] == "+"
                    ? Colors.deepPurple.shade300
                    : Colors.red.shade300
                ),)
              // Icon(Icons.arrow_forward_ios),
          ]),
        ),
      ),
    );
  }
}