import 'package:data_project/password_dialog.dart';
import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/point/bank_data.dart';
import 'package:data_project/screens/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});
  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  int point = 0;
  int inputPoint = 0;
  int fee = 1000;
  int tax = 0;
  int amount = 0;
  final TextEditingController _controller = TextEditingController();

  bool isHasAcc = false;
  String? bank;
  String? account;

  @override
  void initState() {
    super.initState();
    setState(() {
      point = context.read<SettingProvider>().point;
      isHasAcc = context.read<SettingProvider>().isHasAcc;
      bank = context.read<SettingProvider>().bankData[1];
      account = context.read<SettingProvider>().bankData[2];
    });
  }
  feeCalculate(){
    setState((){
      (inputPoint < 10000) ? fee = 1000 : fee = 0;
    });
  }
  taxCalculate(){
    setState((){
      tax = (inputPoint * 0.033).floor();
    });
  }
  amountCalculate() {
    setState(() {
      amount = inputPoint - fee - tax;
    }); 
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        shadowColor: Color.fromARGB(0, 0, 0, 0),
        title: Text("출금신청", style: TextStyle(color: Colors.black87,),),
        centerTitle: true,
      ), 
      body: Column(
        children: [
          SizedBox(height: 30,),
          InkWell(
            onTap: () async{
              final List? data = await navPush(context, BankDataScreen());
              if (data != null) {
                setState((){
                  isHasAcc = data[0];
                  bank = data[1];
                  account = data[2];
                });
              }
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
                        Text("$bank  $account",
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
              feeCalculate();
              taxCalculate();
              amountCalculate();
            },
          ),
          Text("포인트를 입력하세요", style: fontSmallGrey),
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
                  Text('${fee.toString()} P'),
                  ],
                ),
                Text("10,000P 이상 신청 시 무료",style: fontSmallGrey),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('사업소득세(3.3%)'),
                  Text('${tax.toString()} P'),
                  ],
                ),
                Divider(color: Colors.black, thickness: 1,),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('최종 이체 금액',style: fontSmallTitle),
                  Text((amount > 0) ? '${amount.toString()} 원' : "0 원", 
                    style: fontSmallTitle),
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
            child: ElevatedButton(
              style: btnStyle,
              onPressed: 
                (amount > 0 && isHasAcc)
                ? () => passwordDialog(context, withdraw)
                : null, 
              child: Text('출금신청'),
            ),
          ),
          SizedBox(height:40),
        ]
      ),
    );
  }
  withdraw(){
    context.read<SettingProvider>().pointTest([-inputPoint, fee, tax, amount]);
    Navigator.pop(context);
  }
}