import 'package:data_project/password_dialog.dart';
import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/point/bank_data.dart';
import 'package:data_project/widgets/widget_style.dart';
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
  int? inputPoint = 0;
  int fee = 1000;
  int tax = 0;
  int amount = 0;
  final TextEditingController _controller = TextEditingController();

  bool isHasAcc = false;
  String? bank;
  String? account;
  int point = 0;

  int calculateFee(int? point) => (point != null && point < 10000 ) ? 1000 : 0;
  int calculateTax(int? point) => (point != null) ? (point * 0.033).floor() : 0;
  int calculateAmount(int? point) {
    int val = 0;
    val = (point != null) ? point - fee - tax : 0;
    return (val > 0) ? val : 0; 
  }
  void withdraw(){
    context.read<SettingProvider>().pointTest([-inputPoint!, fee, tax, amount]);
    Navigator.pop(context);
  }



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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
        title: const Text("출금신청", style: TextStyle(color: Colors.black87,),),
        centerTitle: true,
      ), 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          children: [
            const SizedBox(height: 30),
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
              child: Container(
                width: 280,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [greyShadow]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (isHasAcc)?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("출금계좌 : "),
                          Text("$bank  $account",
                            style: const TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold,
                          )),
                        ],
                      )
                      : const Text("출금계좌 등록하기"),
                    const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ]
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              showCursor: false,
              style: const TextStyle(fontSize: 40,),
              decoration: const InputDecoration(
                counterText: "",
                border: InputBorder.none,
                hintText: "0",
                hintStyle: TextStyle(fontSize: 40, color: Colors.black),
              ),
              maxLength: point.toString().length + 1,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                FilteringTextInputFormatter.deny(RegExp(r'^0+'),),],
              scribbleEnabled : false,
              controller: _controller,
              onTap: () => _controller.selection = TextSelection.collapsed(offset: _controller.text.length),
              onChanged: (value) {
                setState(() {
                  if (value == ""){
                    inputPoint = 0;
                    _controller.clear();
                  }else {
                    inputPoint = int.parse(value);
                    if (inputPoint! > point){
                      _controller.setText(point.toString());
                      inputPoint = point;
                    }
                  }
                  fee = calculateFee(inputPoint);
                  tax = calculateTax(inputPoint);
                  amount = calculateAmount(inputPoint);
                });
              },
            ),
            const Text("포인트를 입력하세요", style: fontSmallGrey),
            const SizedBox(height: 4),
            Text('보유포인트 : ${point.toString()} P',),
            const SizedBox(height: 48),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('출금 수수료'), 
                    Text('${fee.toString()} P')],
                ),
                const Text("10,000P 이상 신청 시 무료",style: fontSmallGrey),
                const SizedBox(height: 4,),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('사업소득세(3.3%)'),
                    Text('${tax.toString()} P')],
                ),
                const Divider(color: Colors.black, thickness: 1,),
                const SizedBox(height: 4),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const Text('최종 이체 금액',style: fontSmallTitle),
                  Text('${amount.toString()} 원', style: fontSmallTitle),
                  ],
                ),
                const SizedBox(height: 5,),
                const Divider(color: Colors.black, thickness: 1,),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              style: btnStyle,
              onPressed: (amount > 0 && isHasAcc) ? () => passwordDialog(context, withdraw) : null, 
              child: const Text('출금신청'),
            ),
            const SizedBox(height:40),
          ]
        ),
      ),
    );
  }
}