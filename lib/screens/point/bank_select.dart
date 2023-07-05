import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List<String> _bankList = ['국민은행', '하나은행', '신한은행', '우리은행', '농협은행', '기업은행', '산업은행', '제일은행', '카카오뱅크', '케이뱅크', '토스뱅크'];


class Bank extends StatefulWidget {
  const Bank(this.bank, {super.key});
  final Map bank;

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  var _choice;
  List<bool> _isChecked = List.filled(11, false);


  @override
  Widget build(BuildContext context) {
    Map bank = widget.bank;
    return Scaffold(
      appBar: AppBar(title: Text('계좌등록')),
      body: Container(
        margin: EdgeInsets.only(top:30, left:20, right:20,),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(20),
              color: Color.fromARGB(255, 218, 241, 252) ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("현재계좌 : ${bank['username']}"),
                  Text(bank['bank'] + " " + bank['accountNum']),
                ]
              ),
            ),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('계좌번호'),
              ],
            ),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 14,
              decoration: InputDecoration(
                counterText: "",
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
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
                                          for(var i = 0; i < _bankList.length; i++)
                                            InkWell(
                                              child: Container(
                                                margin: EdgeInsets.all(2),
                                                height: 60,
                                                width: 110,
                                                child: 
                                                Card(
                                                  color: _isChecked[i] ?  Colors.cyan : Colors.white,
                                                  child: Center(
                                                    child:Text(
                                                      _bankList[i],
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(color: _isChecked[i] ? Colors.white : Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: (){
                                                setState(() {
                                                  for(var i = 0; i < _isChecked.length; i++){
                                                    _isChecked[i] = false;
                                                  }
                                                  _isChecked[i] = !_isChecked[i];
                                                  setChoice(i);
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
                Text(_choice ?? ""),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){}, child: Text('계좌등록')),
            // Text(
            //   style: TextStyle(color: Colors.red) , 
            //   '회원과 예금주 명의가 불일치합니다.'
            // ),
          ],
        )
      )
    );
  }
  
  void setChoice(int i) {
    setState(() {
      _choice = _bankList[i];
    });
  }
}