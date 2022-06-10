import 'package:find_me/Utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthClass {
  SignUp(name, surname, phone, email, password) async {
    try {
      var res = await http.post(Uri.parse(conn + "/Auth/signUp"),
          body: jsonEncode({
            "user": name,
            "surname": surname,
            "phone": phone,
            "email": email,
            "password": password
          }),
          headers: {"content-type": "application/json"});

      if (res.statusCode == 200) {
        var response = res.body;

        return response;
      } else {
        return "failed";
      }
    } catch (e) {
      return e.toString();
    }
  }

  SignIn(user, password) async {

    try{

      var res = await http.post(Uri.parse(conn + "/Auth/signIn"),
          body: jsonEncode({"user": user, "password": password}),
          headers: {"content-type": "application/json"});

      if (res.statusCode == 200) {

        if(res.body != "null")
          return json.decode(res.body);
        else
          return res.body;
      } else {
        return "failed";
      }

    }catch(e){
      print(e.toString());
    }

  }


}
