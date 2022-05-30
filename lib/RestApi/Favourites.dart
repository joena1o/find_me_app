import 'package:find_me/Utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavouriteClass {
  AddContact(user, id) async {
    try {
      var res = await http.post(Uri.parse(conn + "/Favourite/addContact"),
          body: jsonEncode({
            "user": user,
            "id": id,
          }),
          headers: {"content-type": "application/json"});

      if (res.statusCode == 200) {
        return res.body;
      } else
        return "Failed";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  FetchContact(user) async{

    try{
      var res = await http.get(Uri.parse(conn+"/fetch/${user}"));

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
