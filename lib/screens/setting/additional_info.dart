import 'package:data_project/data/new_user_storage.dart';
import 'package:data_project/screens/home/home.dart';
import 'package:data_project/screens/setting/data_setting.dart';
import 'package:flutter/material.dart';

class AddInfo extends StatefulWidget {
  const AddInfo(this.isNewUser, {super.key});
  final bool isNewUser;

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  List<bool> _selections = [true, false, false];
  List _Interest = ["보험설계", '대출', '예금/적금', ];
  final _haveChild = ['없음', '있음'];
  String? _selected2;
  bool isFirstLogin = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isFirstLogin = widget.isNewUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('추가정보'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: 
      SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top:20, left:20, right:20,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('정보가 많을 수록 판매될 확률이 높아집니다.'),
              Text('입력된 정보는 3개월간 수정 불가합니다.'),
              Text('2023.01.01 ~ 2023. 03. 01'),
              SizedBox(height: 20,),

              Center(
                child: ToggleButtons(
                  onPressed: (index) {
                    setState(() {
                      _selections = [false, false, false];
                      _selections[index] = !_selections[index];
                    });
                  },
                  isSelected: _selections,
                  children: [
                    for (var i = 0; i < _Interest.length; i++)
                      Container(
                        width: 100,
                        padding: EdgeInsets.all(2),
                        child: Text(_Interest[i], textAlign: TextAlign.center,),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20,),

              Container(margin: EdgeInsets.only(top:20), child: Text('자녀유무')),
                SizedBox(
                  width: double.maxFinite,
                  child: DropdownButton(
                    isExpanded: true,
                    value: _selected2,
                    items: _haveChild.map(
                      (e){
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(), 
                    onChanged: (value){
                      setState(() {
                        _selected2 = value.toString();
                      });
                    }),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: (){
                      if (_selections[2] && isFirstLogin){
                        NewUserStorage().write("false");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }else if (_selections[2]) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DataPage()),
                        );
                      }else if (_selections[1]) {
                        setState(() {
                          _selections = [false, false, true];
                        });
                      }else {
                        setState(() {
                          _selections = [false, true, false];
                        });
                      }
                    }, 
                    child: Text('확인 저장')
                  ),
                ),
            ],
          ),
        )
      )
    );
  }
}