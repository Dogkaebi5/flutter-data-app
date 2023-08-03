import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final List<String> bankList = ['국민은행', '하나은행', '신한은행', '우리은행', '농협은행', '기업은행', '산업은행', '제일은행', '카카오뱅크', '케이뱅크', '토스뱅크'];


class BankDataScreen extends StatefulWidget {
  const BankDataScreen({super.key});

  @override
  State<BankDataScreen> createState() => _BankDataScreenState();
}

class _BankDataScreenState extends State<BankDataScreen> {
  List<bool> isSelectBanks = List.filled(bankList.length, false);
  bool isHasAcc = false;
  List bankData = List.empty(growable: true);
  String? bank;
  String? acc;
  
  String? newBank;

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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
        shadowColor: Color.fromARGB(0, 0, 0, 0),
        title: Text("계좌등록",
          style: TextStyle(
          color: Colors.black87,
          ),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 20,),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(20)
              ),
              child: 
                isHasAcc?
                Text("현재 등록계좌 :\n${bankData[1]}  ${bankData[2]}")
                :Text("현재 등록계좌 :\n없음")
              ),
            
            OutlinedButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(double.infinity, 64)
              ),
              onPressed: () async {
                newBank = await bankListDialog();
                if(newBank != null){
                  setState(() => bank = newBank);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.account_balance),
                  SizedBox(width: 6,),
                  Text(bank ?? '은행선택', style: TextStyle(fontSize: 16)),
                  Spacer(),
                  Icon(Icons.arrow_drop_down_circle)
              ]),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => setState(() => acc = value.toString()),
              keyboardType: TextInputType.number,
              maxLength: 14,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                counterText: "",
                border: OutlineInputBorder(),
                hintText: "본인명의 계좌를 입력하세요",
                hintStyle: TextStyle(color: Colors.black54)
              ),
            ),
            Spacer(),
            ElevatedButton(
              style: btnStyle,
              onPressed: (bank != null && acc!= null)
                ?() {
                  setState(() => isHasAcc = true);
                  context.read<SettingProvider>().setBank(bank, acc);
                  Navigator.pop(context, [true, bank, acc]);
                }
                :null, 
              child: Text('계좌등록')),
            SizedBox(height: 40)
            // Text(
            //   style: TextStyle(color: Colors.red) , 
            //   '회원과 예금주 명의가 불일치합니다.'
            // ),
          ],
        ),
      )
    );
  }

  Future<String?> bankListDialog() async{
    await showDialog(context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return Dialog.fullscreen(
              backgroundColor: Color.fromARGB(255, 240, 240, 240),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        iconSize: 30,
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close)
                      ),
                      Text('은행선택', style: fontSmallTitle),
                      SizedBox(width: 48)
                  ]),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        direction: Axis.horizontal, 
                        alignment:  WrapAlignment.center,
                        children: [
                          for(var i = 0; i < bankList.length; i++)
                            InkWell(
                              child: SizedBox(
                                height: 60, width: MediaQuery.of(context).size.width/3 - 20,
                                child: Card(
                                  color: isSelectBanks[i] ?  Colors.deepPurple  : Colors.white,
                                  child: Center(
                                    child:Text(
                                      bankList[i],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: isSelectBanks[i] ? Colors.white : Colors.black),
                              ),),),),
                              onTap: (){
                                setState(() {
                                  for(int j = 0; j < isSelectBanks.length; j++){
                                    isSelectBanks[j] = false;
                                  }
                                  isSelectBanks[i] = !isSelectBanks[i];
                                  newBank = bankList[i];
                                });
                                Navigator.pop(context);
                              }
                            ),
                        ],
                      ),
                    ),
                  ),
                ]
              )
            );
      });}
    );
    return newBank;
  }
}