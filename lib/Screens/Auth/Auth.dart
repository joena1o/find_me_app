import 'package:find_me/RestApi/AuthClass.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends StatefulWidget {

  Auth({Key? key, required this.callback}):super(key: key);

  final Function callback;

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  bool SignUp = false;

  List data = [];

  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  AuthClass _authClass = AuthClass();

  SetPrefs(user,phone,name) async{

    final prefs = await SharedPreferences.getInstance();

    prefs.setString('user', user);

    prefs.setString("phone", phone);

    prefs.setString("name", name);

    widget.callback(3);


  }


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(body:Container(

      width: size.width,
      height: size.height,

      color: Colors.green,

      child: ListView(

        children:[

          Center(
            child: Container(
                margin: EdgeInsets.only(top: 30, bottom: 10),
                child:Text("Find Me", style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),)),
          ),

          Form(
            child: Container(

              color: Colors.white,

              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),

            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),

            child: (SignUp)?Column(
              children: [

                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      hintTextDirection: TextDirection.rtl,

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: TextFormField(
                    controller: lastname,
                    decoration: InputDecoration(
                      hintText: "Surname",
                      //hintTextDirection: TextDirection.rtl,

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      hintTextDirection: TextDirection.rtl,

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      //hintTextDirection: TextDirection.rtl,

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      hintTextDirection: TextDirection.rtl,

                    ),
                  ),
                ),


                Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  child: TextFormField(
                    controller: cpassword,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      //hintTextDirection: TextDirection.rtl,

                    ),
                  ),
                ),


                Container(

                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color:Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(5)

                    ),
                    margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: FlatButton(
                      onPressed: (){

                        showDialog(
                          context:context,
                          builder: (_)=>Center(
                            child: CircularProgressIndicator(color: Colors.green,),
                          )
                        );

                        _authClass.SignUp(name.text.toString(), lastname.text.toString(), phone.text.toString(), email.text.toString(), password.text.toString())
                        .then((value){

                          print(value);

                          if(value=="Created"){

                            Navigator.of(context).pop();

                            setState((){

                              SignUp = !SignUp;

                            });


                          }else{



                          }

                        });


                      },
                      child: Text("Sign Up", style: TextStyle(color:Colors.green, fontWeight: FontWeight.bold),),
                    )
                ),

                Container(
                  child:
                     Text("Already have an account?"),

                ),

                Container(
                  padding: EdgeInsets.only(top: 10),
                  child:
                  FlatButton(
                      onPressed: (){

                        setState(() {

                          SignUp = !SignUp;

                        });

                      },
                      child:Text("Sign In", style: TextStyle(color:Colors.green),),

                ))



              ],
            ):SignIn(),


          )),






        ]

      )


    ));
  }

  Widget SignIn(){

    return Column(

      children: [


        Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          child: TextFormField(
            controller: email,
            decoration: InputDecoration(
              hintText: "Email Address",
              hintTextDirection: TextDirection.rtl,

            ),
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          child: TextFormField(
            controller: password,
            decoration: InputDecoration(
              hintText: "Password",
              //hintTextDirection: TextDirection.rtl,

            ),
          ),
        ),

        Container(

            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color:Colors.green, width: 2),
                borderRadius: BorderRadius.circular(5)

            ),
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: FlatButton(
              onPressed: (){

                showDialog(
                    context:context,
                    builder: (_)=>Center(
                      child: CircularProgressIndicator(color: Colors.green,),
                    )
                );

                _authClass.SignIn(email.text.toString(), password.text.toString()).then((value){

                  if(value is List)
                    SetPrefs(email.text.toString(), "${value[0]['phone']}" ,"${value[0]['first_name']} ${value[0]['last_name']}" );
                  else
                    Navigator.of(context).pop();


                });



              },
              child: Text("Sign In", style: TextStyle(color:Colors.green, fontWeight: FontWeight.bold),),
            )
        ),

        Container(
          child:
          Text("Dont have an account?"),

        ),

        Container(
            padding: EdgeInsets.only(top: 10),
            child:
            FlatButton(
              onPressed: (){

                setState(() {

                  SignUp = !SignUp;

                });

              },
              child:Text("Sign Up", style: TextStyle(color:Colors.green),),

            ))



      ],

    );

  }

}
