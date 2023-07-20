import 'package:data_project/password_dialog.dart';
import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/point/bank_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class Withdraw extends StatefulWidget {
  const Withdraw(this.point, {super.key});
  final int point;
  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  int inputPoint = 0;
  TextEditingController _controller = TextEditingController();
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
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        shadowColor: Color.fromARGB(0, 0, 0, 0),
        title: Text("출금신청",
          style: TextStyle(
          color: Colors.black87,
          ),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
          color: Colors.black87
        ),]
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Bank())
              );
            },
            child: 
            Container(
              width: 280,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (isHasAcc)?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("출금계좌 : ",
                          style: TextStyle(color: Colors.black87),
                        ),
                        Text("${bankData[1]}  ${bankData[2]}",
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                    : Text("출금계좌 등록하기",  style: TextStyle(color: Colors.black87)),
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
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            showCursor: false,
            style: TextStyle(fontSize: 40,),
            decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              hintText: "0",
              hintStyle: TextStyle(
                fontSize: 40,
                color: Colors.black,
              ),
            ),
            maxLength: point.toString().length + 1,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              FilteringTextInputFormatter.deny(RegExp(r'^0+'),),],
            scribbleEnabled : false,
            controller: _controller,
            onTap: () => _controller.selection = TextSelection.collapsed(offset: _controller.text.length),
            onChanged: (value) {
              if (value == "") {
                _controller.clear();
              }else if (int.parse(value) > point) {
                setState((){
                  _controller.setText(point.toString());
                  inputPoint = int.parse(point.toString());
                });
              }else {
                setState(() => inputPoint = int.parse(value));
              }
            },
          ),
          Text("포인트를 입력하세요",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 4,),
          Text('보유포인트 : ${point.toString()} P',),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: 
                  (int.parse(transferAmount()) > 0)
                  ? () => passwordDialog(context, withdraw)
                  : null, 
                child: Text('출금신청'),
              ),
            ),
          ),
          SizedBox(height:40),
        ]
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