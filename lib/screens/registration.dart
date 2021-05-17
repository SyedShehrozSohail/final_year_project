import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/screens/loginpage.dart';
import 'package:flutter/services.dart';


class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: _Registration(),
    );
  }
}
bool tuVal = true;

class _Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create account', style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(24),
                  ],
                  decoration: InputDecoration(
                    hintText: "Full Name ",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.black,
                      size: 48,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(32),
                  ],
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    icon: Icon(
                      Icons.mail_outline,
                      color: Colors.black,
                      size: 48,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Mobile Number",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    icon: Icon(
                      Icons.phone_iphone,
                      color: Colors.black,
                      size: 48,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(32),
                  ],
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Set Password",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    icon: Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                      size: 48,
                    ),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Checkbox(
                      value: tuVal,
                      onChanged: (bool value) {
                        setState(() {
                          tuVal = value;
                        });
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,8,16,0),
                      child: Text("I read and agree to Terms & Conditions",style: TextStyle(fontSize: 18.0),),
                    ),
                  ]
              ),

              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width:400,
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    color: Colors.red,
                    child: Text(
                        "CREATE ACCOUNT"
                    ),
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    textColor: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,8,0,8),
                    child: Text("Already have an account?",style: TextStyle(fontSize: 18.0),),
                  ),
                  InkWell(
                    onTap: (){
                      // Navigator.pushNamed(context,"");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Login",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void setState(Null Function() param0) {}
}