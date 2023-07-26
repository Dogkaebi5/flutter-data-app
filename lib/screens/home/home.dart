import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/home/home_dialog.dart';
import 'package:data_project/screens/home/home_nav.dart';
import 'package:data_project/screens/start/authentication.dart';
import 'package:data_project/testpage.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:data_project/screens/point/withdraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List details = List.empty(growable: true);
  int point = 0;

  List<bool> _selections = [true, false];
  DateTime signUpDate = DateTime(2023, 1, 1);
  DateTime today = DateTime.now();
  String sortStartDate ="2023-01-01";
  String sortEndDate ="2023-01-31";
  
  setSortDateText(selectStartDate, selectEndDate){
    setState((){
      sortStartDate = selectStartDate;
      sortEndDate = selectEndDate;
    });
  }
  
  @override
  void initState(){
    super.initState();
    setState(() {
      details = context.read<SettingProvider>().details;
      point = context.read<SettingProvider>().point;
    });
    changeSortTextToMonth();
  }

  @override
  Widget build(BuildContext context, ) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      bottomSheet: Nav(),
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
                                    fontSize: 30,),),
                            ],),
                        ],),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,),
                          child: Icon(
                            Icons.analytics,
                            color: Colors.deepPurple,
                            size: 28,),)
                    ],),
                    SizedBox(height: 8,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Withdraw()),
                        );},
                        child: SizedBox(
                          width: 112,
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
                  ),],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 28,),
                    ToggleButtons(
                      isSelected: _selections,
                      onPressed: (index) {
                        setState(() {
                          _selections = [false, false];
                          _selections[index] = !_selections[index];
                        });
                        if (index == 1) {
                          showDatePickerDialog();
                        } else {
                          changeSortTextToMonth();
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
                  
                    if(_selections[1])
                      Text(
                        '검색기간 : $sortStartDate ~ $sortEndDate', 
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),  
                      ),
                    SizedBox(height: 12,),
                
                    //디테일 링크
                    if(details.length < 1)
                      Row(
                        children: const [Padding(
                          padding: EdgeInsets.all(28),
                          child: Text("기록이 없습니다."),
                        )],
                      )
                    else 
                      for(int i = details.length-1; i > -1; i--)
                        createDetailCards(i),

                    TextButton(
                      onPressed: (){
                        FirebaseAuth.instance.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>  Authentication()),
                          ModalRoute.withName('/'),
                        );
                      },
                      child: Text("테스트 로그아웃")
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  TestPage()),
                        );
                        },
                      child: Text("테스트 페이지")
                    ),
                    TextButton(
                      onPressed: (){setState((){
                        context.read<SettingProvider>().addDetailTest(10000, null);
                        point = context.read<SettingProvider>().point;
                      });},
                      child: Text("만P 추가")
                    ),
                    TextButton(
                      onPressed: (){setState((){
                        context.read<SettingProvider>().clearDetail();
                        point = context.read<SettingProvider>().point;
                      });},
                      child: Text("디테일 전부 삭제")
                    ),
                    SizedBox(height: 100,),
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
  
  void changeSortTextToMonth(){
    String monthAgo = today.subtract(Duration(days:30)).toString().split(' ')[0];
    String todayDate = today.toString().split(' ')[0];
    setSortDateText(monthAgo, todayDate);
  }

  void setMon() => setState(() => _selections = [true, false]);

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
              setMon();
            },
            onSubmit: (p0) {
              String? selectSta;
              String? selectEnd;
              if (p0 == null) {
                Navigator.pop(context);
                setMon();
              } else {
                selectSta = p0.toString().split(' ')[1];
                selectEnd = p0.toString().split(' ')[4];
                if (selectEnd == 'null)'){
                  selectSta = p0.toString().split(' ')[1];
                  setSortDateText(selectSta, selectSta);
                  Navigator.pop(context);
                }else {
                  selectSta = p0.toString().split(' ')[1];
                  selectEnd = p0.toString().split(' ')[4];
                  setSortDateText(selectSta, selectEnd);
                  Navigator.pop(context);
                }
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
                  // newDetails[loopInt]['point']
                  SizedBox(height: 4,),
                  Text(
                    details[loopInt]['date'].split(' ')[0], 
                    style: TextStyle(
                      color: Colors.grey, 
                      fontSize: 12
                    ),
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