import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/screens/home/detail_dialog.dart';
import 'package:data_project/screens/start/auth_router.dart';
import 'package:data_project/widgets/detail_card.dart';
import 'package:data_project/widgets/nav_bar.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:get/get.dart';
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
  final UserDataController controller = Get.put(UserDataController());

  int navBarSelectedIndex = 0;
  bool hasNewNotice = false;
  List<bool> sortSelections = [true, false];
  DateTime signUpDate = DateTime(2023, 1, 1);
  DateTime today = DateTime.now();
  DateTime? sortStartDate;
  DateTime? sortEndDate;

  void setSortDate(DateTime selectStartDate, DateTime selectEndDate){
    setState((){
      sortStartDate = selectStartDate.subtract(Duration(days: 1));
      sortEndDate = selectEndDate.add(Duration(days: 1));
    });
  }
  void setOneMonth(){
    DateTime monthAgo = today.subtract(Duration(days:31));
    setState((){
      sortSelections = [true, false];
      (signUpDate.isAfter(monthAgo))
        ?sortStartDate = monthAgo
        :sortStartDate = signUpDate;
      sortEndDate = today.add(Duration(days: 1));
    });
  }
  void setSortDetails(){
    List details = controller.details;
    List sortDetails = [];
    setState(() {
      for (int i = 0; i < details.length; i++){
        if(details[i]['date'].toDate().isAfter(sortStartDate) &&
        details[i]['date'].toDate().isBefore(sortEndDate)){
          sortDetails.add(details[i]);
        }
      }
    });
    controller.setSortDetails(sortDetails);
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      signUpDate = controller.myProfile().createdTime!;
      setOneMonth();
      hasNewNotice = controller.hasNewNotice;
      setSortDetails();
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(126, 87, 194, 1),
      bottomSheet: NavBar(),
      body:  WillPopScope(
        onWillPop: () => Future(() => false),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: 20, horizontal:24),
                child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("My Point",  style: TextStyle(color: Colors.white, fontSize: 18)),
                            const SizedBox(height: 4,),
                            Row(children: [
                              const Icon(Icons.account_balance_wallet, color: Colors.white, size: 32),
                              const SizedBox(width: 12),
                              Obx(() => Text("${controller.myProfile().point ?? 0} P", 
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)))
                            ])
                        ]),
                        Container(height: 40, width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromRGBO(255, 255, 255, 1),),
                            child: const Icon(Icons.analytics, color: Colors.deepPurple, size: 28))
                    ]),
                    const SizedBox(height: 8),
                    ElevatedButton( 
                      onPressed: () async{
                        await navPush(context, WithdrawScreen());
                        setState(() => setSortDetails());
                      },
                      child: const SizedBox(width: 120, height: 44,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Icon(Icons.toll,), SizedBox(width: 4),
                            Text("출금신청"), SizedBox(width: 8),
                        ])
                    )),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 220),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                  color: const Color.fromARGB(255, 245, 245, 245),
                  boxShadow: [BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(.6),
                    blurRadius: 6,
                    spreadRadius: 1)]
                ),
                child: Column(children: [
                  const SizedBox(height: 28),
                  ToggleButtons(
                    isSelected: sortSelections,
                    onPressed: (index){
                      setState((){
                        sortSelections = [false, false];
                        sortSelections[index] = !sortSelections[index];
                      });
                      if (index == 1) {
                        showDatePickerDialog();
                      }else{
                        setOneMonth();
                        setSortDetails();
                      }
                    },
                    children: const [
                      SizedBox(width: 120, child: Text("1개월", textAlign: TextAlign.center)),
                      SizedBox(width: 120, child: Text("직접입력", textAlign: TextAlign.center)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  if(sortSelections[1])
                    Text(
                      '검색기간 : ${sortStartDate.toString().split(' ')[0]} ~ ${sortEndDate.toString().split(' ')[0]}', 
                      style: fontSmallGrey),
                  const SizedBox(height: 12),
                  if(controller.sortDetails.isEmpty)
                    Row(children: const[
                      SizedBox(height:30, width:24),
                      Text("기록이 없습니다."),
                    ])
                  else 
                    for(int i = controller.sortDetails.length-1; i > -1; i--)
                      DetailCard(
                        title: controller.sortDetails[i]['title'], 
                        date: controller.sortDetails[i]['date'].toDate(),
                        point: controller.sortDetails[i]['point'],
                        onTap: (){detailDialog(context, controller.sortDetails[i]);}
                      ),
                  /////////////////test btns
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: (){
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  AuthRouter()), ModalRoute.withName('/'));
                          FirebaseAuth.instance.signOut();
                        },
                        child: const Text("/test\nlogout",style: testBtnStyle)),
                      TextButton(
                        onPressed: () async{
                          controller.pointCtrl(10000);
                          await controller.testCreateDetail();
                          setSortDetails();
                        },
                        child: const Text("/test\n+point",style: testBtnStyle)),
                      TextButton(
                        onPressed: (){
                          controller.reset();
                          setState((){});
                        },
                        child: const Text("/test\nreset",style: testBtnStyle)),
                  ]),
                  const SizedBox(height: 80),
                ]),
              ),
            ]),
          ),
        )
      ),
    );
  }

  showDatePickerDialog() =>
    showDialog(
      context: context, 
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Dialog(
          child: SfDateRangePicker(
            selectionMode: DateRangePickerSelectionMode.range,
            showActionButtons: true,
            maxDate: DateTime.now(),
            minDate: signUpDate,
            onCancel: (){
              setOneMonth();
              Navigator.pop(context);
            },
            onSelectionChanged: (args) {
              if(args.value.startDate != null && args.value.endDate != null){
                setSortDate(args.value.startDate, args.value.endDate);
              }else if(args.value.endDate == null){
                setSortDate(args.value.startDate, args.value.startDate);
              }else {
                setOneMonth();
              }
            },
            onSubmit: (args) {
              Navigator.pop(context);
              setState(()=> setSortDetails());
            }
          ),
        )
      )
    );
}