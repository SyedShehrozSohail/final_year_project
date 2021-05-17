
import 'package:final_year_project/auth/authentication.dart';
import 'package:final_year_project/auth/dialogbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage({
    this.auth,
    this.onSignedIn,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedIn;
  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

enum FormType { login, register }

class _LoginRegisterState extends State<LoginRegisterPage> {
  DialogBox dialogBox = DialogBox();

  final formKey = GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _username = '';
  String _mobile = '';
  String _email = '';
  String _password = '';
  String appBarTitle='Welcome to Qasai Wala';


  //methods
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.signIn(_email, _password);
          dialogBox.information(
              context, 'Congratulations!', 'You logged in successfully');
          print('Login user id =' + userId);
        } else {
          String userId = await widget.auth.signUp(_username,_email, _mobile, _password);
          dialogBox.information(context, 'Congratulations!',
              'Your account has been created successfully');
          print('Register user id =' + userId);
        }
        widget.onSignedIn();
      } catch (e) {
        dialogBox.information(context, 'Error: ', e.toString());
        print('Error: ' + e.toString());
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  //Design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Colors.black,
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
            child: ListView(
              children: <Widget>[
              getImageAsset(),
              Padding(
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                ),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: createInputs() + createButtons(),
          ),
        ),
        ],
          ),
    ),),
    );
  }
  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('assets/images/a.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.all(5),
    );
  }
  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(32),
        ],
        decoration: InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
          icon: Icon(
            Icons.person_outline,
            color: Colors.black,
            size: 48,
          ),),
        validator: (value) {
          return value.isEmpty ? 'please provide email' : null;
        },
        onSaved: (value) {
          return _email = value;
        },
      ),
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(16),
        ],
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
          icon: Icon(
            Icons.lock_outline,
            color: Colors.black,
            size: 48,
          ),
        ),
        obscureText: true,
        validator: (value) {
          return value.isEmpty ? 'password is required!' : null;
        },
        onSaved: (value) {
          return _password = value;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  List<Widget> createButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20.0),
          ),
          textColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(32.0)),
          color: Colors.black,
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text(
            'No account? Register Here!',
            style: TextStyle(fontSize: 14.0),
          ),
          textColor: Colors.red,
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        RaisedButton(
          child: Text(
            'Create Account',
            style: TextStyle(fontSize: 20.0),
          ),
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(32.0)),
          textColor: Colors.white,
          color: Colors.black,
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child: Text(
            'Already have an account? Login!',
            style: TextStyle(fontSize: 14.0),
          ),
          textColor: Colors.red,
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}