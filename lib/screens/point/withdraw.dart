import 'package:data_project/password_dialog.dart';
import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/point/bank_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Withdraw extends StatefulWidget {
  const Withdraw(this.point, {super.key});
  final int point;
  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  int inputPoint = 0;
  String fee(){
    if(inputPoint < 10000) {
      return "1000";
    } return "0";
  }
  String tax() => ((inputPoint * 0.033).floor()).toString();
  String transferAmount() => inputPoint < 1034 ? "0" : (inputPoint - int.parse(fee()) - int.parse(tax())).toString();

  bool isHasAcc = false;
  List bankData = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    setState(() {
      isHasAcc = context.read<SettingProvider>().isHasAcc;
      bankData = context.read<SettingProvider>().bankData;
    });
  }

  @override
  Widget build(BuildContext context) {
    int point = widget.point;

    return Scaffold(
      appBar: AppBar(
        title: Text("출금신청"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Bank())
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (isHasAcc)?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("등록계좌 : ",
                                style: TextStyle(color: Colors.black87),
                              ),
                              Text("${bankData[0]??''}", 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2,),
                          Text("${bankData[1]}  ${bankData[2]}",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                      :Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("등록계좌 :", 
                            style: TextStyle(color: Colors.black87),
                          ),
                          SizedBox(height: 2,),
                          Text("없음",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    Icon(Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ]
                ),
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              textAlign: TextAlign.end,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '출금신청 포인트',
                counterText: "",
                border: OutlineInputBorder(),
              ),
              maxLength: point.toString().length + 1,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
              scribbleEnabled : false,
              controller: point==inputPoint ? TextEditingController(text: inputPoint.toString()) : null,
              onChanged: (value) {
                if (value == "") {
                  return;
                }else if (int.parse(value) > point) {
                  setState((){
                    value = point.toString();
                    inputPoint = int.parse(value);
                  });
                }else {
                  setState(() => inputPoint = int.parse(value));
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('보유포인트 : ${point.toString()} P',),
              ],
            ),
            SizedBox(height: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [Text("출금 정보", style: TextStyle(fontSize: 16, fontWeight:FontWeight.bold),),]
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('신청사용 포인트'),
                  Text('${inputPoint.toString()} P'),
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('출금 수수료'),
                  Text('${fee()} P'),
                  ],
                ),
                Text("10,000P 이상 신청 시 무료",style: TextStyle(fontSize: 12, color: Colors.grey),),
                SizedBox(height: 4,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('사업소득세(3.3%)'),
                  Text('${tax()} P'),
                  ],
                ),
                Divider(color: Colors.black, thickness: 1,),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('최종 이체 금액',style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('${transferAmount()} 원', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(height: 5,),
                Divider(color: Colors.black, thickness: 1,),
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: 
                  (int.parse(transferAmount()) > 0)
                  ? () => passwordDialog(context, withdraw)
                  : null, 
                style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 58, vertical: 12))),
                child: Text('출금신청'),
              ),
            ),
            SizedBox(height: 30,)
          ]
        ),
      ),
    );
  }
  
  withdraw(){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => HomePage()),
      ModalRoute.withName('/'),
    );
  }
}