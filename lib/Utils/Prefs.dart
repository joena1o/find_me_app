import 'package:shared_preferences/shared_preferences.dart';


class Prefs{

  LoadPref() async{
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    var user =  prefs.getString('user');
    return user;
  }

  LoadName() async{
    final prefs = await SharedPreferences.getInstance();
    var name =  prefs.getString('name');
    return name;

  }

  RemovePrefs() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  LoadPhone() async{

    final prefs = await SharedPreferences.getInstance();
    var phone = prefs.getString('phone');
    return phone;
  }

}