import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ShopRegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopRegisterFormState();
  }
}


class _ShopRegisterFormState extends State<ShopRegisterForm> {
  Future<void> _actCopy(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('REGISTERED SUCCESSFULLY',style: TextStyle(fontSize: 22),),
          content: Text(displayMessage),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _reset();
              },
            ),
          ],
        );
      },
    );
  }
  String enterYourAdd='Please enter your address';
  var _formKey = GlobalKey<FormState>();

  final double _minimumPadding = 5.0;

  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
  }

  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool requestStatus= false;
  var displayMessage = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding,
                        bottom: _minimumPadding
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(16),
                      ],
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      validator: (String value) {if (value.isEmpty) {return enterYourAdd;}},
                      decoration: InputDecoration(
                          labelStyle: textStyle,
                          labelText: 'Shop Name',
                          hintText: 'Please enter the shop name',
                          errorStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
                    )),

                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding,
                        bottom: _minimumPadding
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      keyboardType: TextInputType.phone,
                      controller: mobileController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter mobile number';
                        }
//                        else
//                          return '';
                      },
                      decoration: InputDecoration(
                          labelText: 'Shop Phone',
                          hintText: '(0423#######)',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    )),

                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding,
                        bottom: _minimumPadding
                    ),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(48),
                      ],
                      keyboardType: TextInputType.text,
                      controller: addressController,
                      validator: (String value) {if (value.isEmpty) {return enterYourAdd;}},

                      decoration: InputDecoration(
                          labelStyle: textStyle,
                          labelText: 'Shop Address',
                          hintText: 'Please enter the shop address',
                          errorStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0))),
                    )),

                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding,
                        top: _minimumPadding
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Colors.red,
                            child: Text(
                              'Register',
                              textScaleFactor: 1.5,
                            ),
                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                            textColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                if (_formKey.currentState.validate()) {
                                  this.displayMessage = displayMessageOnPopUp();
                                  Firestore.instance
                                      .collection('shops_tbl')
                                      .document(_formKey.toString())
                                      .setData({
                                    "mobile": mobileController.text,
                                    "timestamp": FieldValue.serverTimestamp(),
                                    "address": addressController.text,
                                    "name": nameController.text,
                                  });

                                  _actCopy(context);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    )
                ),


              ],
            )
        ),
      ),
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
      margin: EdgeInsets.all(_minimumPadding),
    );
  }

  String displayMessageOnPopUp() {
    String result =
        'The shop has been registered successfully.';
    return result;
  }

  void _reset() {
    addressController.text = '';
    mobileController.text = '';
    nameController.text = '';
    displayMessage = '';
  }
}


