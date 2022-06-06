import 'package:find_me/Utils/utils.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class contactClass {
  SearchContact(key) async {
    try {
      var res = await http.get(
          Uri.parse(conn + "/Contacts/searchContact/${key}"),
          headers: {"content-type": "application/json"});

      if (res.statusCode == 200) {
        print(res.body);
        return json.decode(res.body);
      } else {
        return "failed";
      }
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  SendRequest(user, receiver) async {
    try {
      var res = await http.post(Uri.parse(conn + "/Contacts/findMeRequest"),
          body: jsonEncode({
            "user": user,
            "receiver": receiver,
          }),
          headers: {"content-type": "application/json"});

      if (res.statusCode == 200) {
        var response = res.body;
        return response;
      } else {
        return "failed";
      }
    } catch (e) {
      print(e.toString());

      return null;
    }
  }



}
