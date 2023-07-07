import 'package:data_project/data/detail_setter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Service{
  static const String detailUrl = "/data_storage.json";

  static getInfo() async{
    try{
      final res = await http.get(Uri.parse(detailUrl));
      var details = detailsFromJson(res.body);
      return details;
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
      return <Details>[];
    }
  }
}