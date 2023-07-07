import 'package:flutter/material.dart';

class Interest extends StatefulWidget {
  const Interest({super.key});

  @override
  State<Interest> createState() => _InterestState();
}

List<String> _list = ['보험설계', '대출', '예금/적금', '부동산', '주식', '가상자산'];

class _InterestState extends State<Interest> {
  
  var _choice = List.empty(growable: true);
  int _choiceCount = 0;
  List<bool> _isChecked = List.filled(6, false);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('관심사'),),
      body: 
          Container(
            margin: EdgeInsets.only(top: 20, left:20, right:20,),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('관심사를 최대 3개 선택하세요.'),
                  Text('선택된 정보는 3개월간 수정 불가합니다.'),
                  SizedBox(
                    height: 10,
                  ),SizedBox(
                    height: 80,
                    child: createInterstLiskText(),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical:10),
                    width: double.infinity,
                    child:
                      ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical, 
                        children: [
                          Wrap(
                            direction: Axis.horizontal, 
                            children: [
                              for(var i = 0; i < _list.length; i++)
                                InkWell(
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    height: 60,
                                    width: 110,
                                    child: 
                                    Card(
                                      color: _isChecked[i] ?  Colors.cyan : Colors.white,
                                      child: Center(
                                        child:
                                          _isChecked[i] ? 
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text((_list[i])),
                                              Icon(Icons.close),
                                            ])
                                          : Text(
                                          _list[i],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: (){
                                    setState(() {
                                      if(_choice.contains(_list[i])){
                                        _isChecked[i] = false;
                                        _choice.remove(_list[i]);
                                        _choiceCount --;
                                      }else if(_choiceCount < 3){
                                        _isChecked[i] = true;
                                        _choice.add(_list[i]);
                                        _choiceCount ++;
                                      }
                                    });
                                  }
                                ),
                            ],
                          ),
                        ],
                      ),
                  ),
                  Spacer(),
                  Center(child: ElevatedButton(
                    onPressed: (){}, 
                    child: Text('확인 저장')
                  )),
                  Spacer(),
                ],
                )
              ),
          ),
        // ),
    );
  }

  createInterstLiskText(){
    if(_choiceCount>0) {
      return Column(
        children: [
          for(var i = 0; i < _choice.length; i++)
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(_choice[i]),
              ),
              Spacer(),
              Text('2023.01.01 ~ 2023.03.31'),
            ],),
        ],
      );
    }
  }

}