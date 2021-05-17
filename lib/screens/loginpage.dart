import 'package:flutter/material.dart';
import 'package:final_year_project/navigators/side_nav_bar.dart';
import 'package:flutter/services.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: _Login(),
    );
  }
}
bool tuVal = true;

class _Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login to my account', style: TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
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
                    LengthLimitingTextInputFormatter(32),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: "Email ",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.black,
                      size: 48,
                    ),
                  ),
                  validator: (value) {
                    return value.isEmpty ? 'please provide email' : null;
                  },
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
                    hintText: "Password",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    icon: Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                      size: 48,
                    ),
                  ),
                  validator: (value) {
                    return value.isEmpty ? 'please provide password' : null;
                  },
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                      child: Text("Remember me",style: TextStyle(fontSize: 18.0),),
                    ),
                  ]
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width:400,
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserHome()));
                    },
                    color: Colors.red,
                    child: Text(
                        "LOGIN"
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
                    child: Text("Don't have an account?",style: TextStyle(fontSize: 18.0),),
                  ),
                  InkWell(
                    onTap: (){
                      // Navigator.pushNamed(context,"");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Sign Up",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),
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