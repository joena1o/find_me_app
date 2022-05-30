import 'package:find_me/Utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Tracking {
  fetchTracking(user) async {
    try {
      var res = await http.get(Uri.parse(conn + "/Tracking/fetch/${user}"),
          headers: {"content-type": "application/json"});

      if (res.statusCode == 200) {
        if (res.body != "null")
          return json.decode(res.body);
        else
          return res.body;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  endTracking(user) async {
    try {
      var res = await http.get(
          Uri.parse(conn + "/Tracking/fetchEnded/${user}"),
          headers: {"content-type": "application/json"});

      if (res.statusCode == 200)
        return res.body;
      else
        return "null";
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
}
