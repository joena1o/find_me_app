import 'dart:convert';
import 'package:find_me/Utils/utils.dart';
import 'package:http/http.dart' as http;

class Request{

  FetchSent(user) async{

    try{

      var res = await http.get(Uri.parse(conn+"/Request/fetch/${user}"), headers: {
        "content-type":"application/json"
      });

      if(res.statusCode==200)
        return json.decode(res.body);
      else
        return "failed";


    }catch(e){

      print(e.toString());

      return null;

    }


  }

}