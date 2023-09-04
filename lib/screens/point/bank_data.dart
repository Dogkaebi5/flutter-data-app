import 'package:data_project/firestoremodel/profile_controller.dart';
import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const List<String> bankList = ['국민은행', '하나은행', '신한은행', '우리은행', '농협은행', '기업은행', '산업은행', '제일은행', '카카오뱅크', '케이뱅크', '토스뱅크'];

class BankDataScreen extends StatefulWidget {
  const BankDataScreen({super.key});

  @override
  State<BankDataScreen> createState() => _BankDataScreenState();
}

class _BankDataScreenState extends State<BankDataScreen> {
  final UserDataController ctrl = Get.put(UserDataController());
  bool isHasAcc = false;
  List bankData = List.empty(growable: true);
  String? bank;
  String? acc;
  String? newBank;

  @override
  void initState() {
    super.initState();
    setState(() {
      bank = ctrl.myProfile().bankName;
      acc = ctrl.myProfile().bankAccount;
      isHasAcc = (acc != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        shadowColor: const Color.fromARGB(0, 0, 0, 0),
        title: const Text("계좌등록",
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
              margin: const EdgeInsets.symmetric(vertical: 20,),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(20)
              ),
              child: 
                isHasAcc?
                Text("현재 등록계좌 :\n$bank  $acc}")
                :const Text("현재 등록계좌 :\n없음")
              ),
            
            OutlinedButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white, minimumSize: Size(double.infinity, 64)),
              onPressed: () async {
                newBank = await bankListDialog();
                if(newBank != null){
                  setState(() => bank = newBank);
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.account_balance),
                  const SizedBox(width: 6,),
                  Text(bank ?? '은행선택', style: TextStyle(fontSize: 16)),
                  const Spacer(),
                  const Icon(Icons.arrow_drop_down_circle)
              ]),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => setState(() => acc = value.toString()),
              keyboardType: TextInputType.number,
              maxLength: 14,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                counterText: "",
                border: OutlineInputBorder(),
                hintText: "본인명의 계좌를 입력하세요",
                hintStyle: TextStyle(color: Colors.black54)
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: btnStyle,
              onPressed: (bank != null && acc!= null)
                ?() {
                  setState(() => isHasAcc = true);
                  ctrl.setBank(bank!, acc!);
                  Navigator.pop(context, [bank, acc]);
                }
                :null, 
              child: const Text('계좌등록')),
            const SizedBox(height: 40)
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
    List<bool> isSelectBanks = List.filled(bankList.length, false);
    await showDialog(context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return Dialog.fullscreen(
              backgroundColor: const Color.fromARGB(255, 240, 240, 240),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: const Icon(Icons.close),
                        iconSize: 30,
                        onPressed: () => Navigator.pop(context)),
                      const Text('은행선택', style: fontSmallTitle),
                      const SizedBox(width: 48, height: 60)]),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          for(var i = 0; i < bankList.length; i++)
                            InkWell(
                              onTap: (){
                                setState(() {
                                  for(int j = 0; j < isSelectBanks.length; j++){
                                    isSelectBanks[j] = false;
                                  }
                                  isSelectBanks[i] = !isSelectBanks[i];
                                  newBank = bankList[i];
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/3 - 20,
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: isSelectBanks[i] ?  Colors.deepPurple  : Colors.white,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Text(bankList[i],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: isSelectBanks[i] ? Colors.white : Colors.black),
                            ))),
                  ]))),
              ])
      );});}
    );
    return newBank;
  }
}