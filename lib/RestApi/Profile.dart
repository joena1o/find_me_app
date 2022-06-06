import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Utils/utils.dart';

class ProfileClass{


  FetchDetails(user) async{

    try{

      var res = await http.get(Uri.parse(conn+"/Profile/fetch/${user}"),
      headers: {"content-type":"application/json"}
      );

      if(res.statusCode == 200){
        return json.decode(res.body);
      }else
         return "failed";


    }catch(e){
      print(e.toString());
      return null;
    }

  }



}