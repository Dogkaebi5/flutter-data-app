import 'package:data_project/screens/setting/additional_info.dart';
import 'package:data_project/screens/setting/data_setting.dart';
import 'package:flutter/material.dart';

class Interest extends StatefulWidget {
  final bool isNewUser;
  const Interest({super.key, required this.isNewUser});

  @override
  State<Interest> createState() => _InterestState();
}

List<String> _list = ["보험설계", "대출", "예금/적금", "부동산", "주식", "가상자산", "골프", "테니스", "피트니스", "요가", "건강식품", "교육", "육아용품", "자동차", "국내여행", "해외여행", "캠핑", "낚시", "반려동물"];

class _InterestState extends State<Interest> {
  bool newbool = false;
  var _choice = List.empty(growable: true);
  int _choiceCount = 0;
  List<bool> _isChecked = List.filled(19, false);
  bool isFirstLogin = false;

  @override
  void initState(){
    super.initState();
    setState(() {
      isFirstLogin = widget.isNewUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('관심사'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left:20, right:20,),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('관심사를 최대 3개 선택하세요.'),
              Text('선택된 정보는 3개월간 수정 불가합니다.'),
              SizedBox(
                height: 88,
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
                            createInterstCard(i)
                        ],
                      ),
                    ],
                  ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: (){
                    saveInterestData();
                    if(isFirstLogin){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddInfo()),
                      );
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DataPage()),
                      );
                    }
                  }, 
                  child: Text('확인 저장')
                ),
              ),
              Spacer(),
            ],
          )
        ),
      ),
    );
  }

  saveInterestData(){}
  createInterstLiskText(){
    if(_choiceCount>0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for(var i = 0; i < _choice.length; i++)
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(_choice[i]),
              ),
              Spacer(),
              Text('저장 유지기간 : ~ 2023.03.31'),
            ],),
        ],
      );
    }
  }
  createInterstCard(i){
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(2),
        height: 60,
        width: 110,
        child: 
        Card(
          color: _isChecked[i]? Color.fromARGB(255, 142, 57, 246) : Colors.white,
          child: Center(
            child:
              _isChecked[i] ? 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text((_list[i]), style: TextStyle(color: Colors.white,),),
                    Icon(Icons.close, color: Colors.white, size: 16,),
                  ]),
              )
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
    );
  }
}