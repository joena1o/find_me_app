import 'package:find_me/Utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DashAct{

  fetchDash(user) async{

    try{
      var res = await http.get(Uri.parse(conn+"/Dash/fetch/${user}"),
          headers: {"content-type":"application/json"});

      if(res.statusCode == 200)
        return json.decode(res.body);
      else
        return "failed";
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  AcceptRequest(rec, user) async{

    try{
      var res = await http.get(Uri.parse(conn+"/Dash/accept/${rec}/${user}"), headers: {"content-type":"application/json"});

      if(res.statusCode==200)
        return res.body;
      else
        return "failed";

    }catch(e){
      print(e.toString());
    }

  }


}