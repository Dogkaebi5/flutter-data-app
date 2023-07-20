import 'package:data_project/provider/setting_provider.dart';
import 'package:data_project/screens/point/withdraw.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final List<String> bankList = ['국민은행', '하나은행', '신한은행', '우리은행', '농협은행', '기업은행', '산업은행', '제일은행', '카카오뱅크', '케이뱅크', '토스뱅크'];


class Bank extends StatefulWidget {
  const Bank({super.key});

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  List<bool> isSelectBanks = List.filled(bankList.length, false);
  bool isHasAcc = false;
  List bankData = List.empty(growable: true);
  String? bank;
  String? acc;
  
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
      appBar: AppBar(
        title: Text('계좌등록'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top:30, left:20, right:20,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(12),
              color: Color.fromARGB(255, 242, 224, 255) ,
              child: 
                isHasAcc?
                Text("등록계좌 : ${bankData[0]??''}\n${bankData[1]}  ${bankData[2]}")
                :Text("등록계좌 :\n없음")
              ),
            SizedBox(height: 20,),
            Text('계좌번호',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8,),
            SizedBox(
              height: 44,
              child: TextField(
                onChanged: (value) => setState(() => acc = value.toString()),
                keyboardType: TextInputType.number,
                maxLength: 14,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: ()=> showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState){
                          return Dialog.fullscreen(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      iconSize: 30,
                                      onPressed: (){
                                        Navigator.pop(context);
                                      }, 
                                      icon: Icon(Icons.close)
                                    ),
                                    Text('은행선택', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                    SizedBox(width: 30,),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical, 
                                    children: [
                                      Wrap(
                                        direction: Axis.horizontal, 
                                        children: [
                                          for(var i = 0; i < bankList.length; i++)
                                            InkWell(
                                              child: Container(
                                                margin: EdgeInsets.all(2),
                                                height: 60,
                                                width: 110,
                                                child: 
                                                Card(
                                                  color: isSelectBanks[i] ?  Color.fromARGB(255, 142, 57, 246)  : Colors.white,
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
                                                  setBank(bankList[i]);
                                                });
                                              }
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]
                            )
                          );
                    });}
                  ),
                  child: Text('은행선택')
                ),
                Text(bank ?? ""),
              ],
            ),
            SizedBox(height: 20,),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (bank != null && acc!= null)
                  ?() {
                    setState(() => isHasAcc = true);
                    context.read<SettingProvider>().setBank(bank, acc);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Withdraw(40000))
                    );
                  }
                  :null, 
                child: Text('계좌등록'))
            ),
            // Text(
            //   style: TextStyle(color: Colors.red) , 
            //   '회원과 예금주 명의가 불일치합니다.'
            // ),
          ],
        )
      )
    );
  }
  setBank(newBank){
    setState(() {
      bank = newBank;
    }); 
  }
}