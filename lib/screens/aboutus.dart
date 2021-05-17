import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ContactUsPage(),
    );
  }
}

class ContactUsPage extends StatefulWidget {
  @override
  _AboutUs createState() => _AboutUs();
}


class _AboutUs extends State<ContactUsPage> {
  Future<void> _launched;
  String toLaunch = 'whatsapp://send?phone=+923234358258';

  String _phone = '+923234358258';
  Future<void> openWhatsApp(String whatsAppUrl) async {
    if(await canLaunch(whatsAppUrl)) {
      await canLaunch(whatsAppUrl)? launch(whatsAppUrl): print(" ");
    }
    throw 'Could not launch $whatsAppUrl';
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.phone_android,
                          color: Colors.black,
                          size: 36,
                        ),
                        onPressed: () => setState(() {
                          _launched = _makePhoneCall('tel:$_phone').catchError((e) {print(e);});
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("Call us",style: TextStyle(fontSize: 18.0),),
                      ),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.chat,
                          color: Colors.black,
                          size: 36,
                        ),
                        onPressed: () => setState(() {
                          _launched = openWhatsApp(toLaunch).catchError((e) {print(e);});
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("Chat with us on WhatsApp",style: TextStyle(fontSize: 18.0),),
                      ),
                    ]
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.help_outline,
                          color: Colors.black,
                          size: 36,
                        ), onPressed: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("About us",style: TextStyle(fontSize: 18.0),),
                      ),
                    ]
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.insert_drive_file,
                          color: Colors.black,
                          size: 36,
                        ), onPressed: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("Terms and Privacy Policy",style: TextStyle(fontSize: 18.0),),
                      ),
                    ]
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.info,
                          color: Colors.black,
                          size: 36,
                        ), onPressed: () {},
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("App info",style: TextStyle(fontSize: 18.0),),
                      ),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child :Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.share),
                      iconSize: 36,
                      onPressed: () {
                        ClipboardManager.copyToClipBoard("https://play.google.com/store/app/details?id=com.qasaiwala").then((result) {
                          final snackBar = SnackBar(
                            content: Text('Link copied to Clipboard', style: TextStyle(color: Colors.white),),
                            backgroundColor: Colors.black,

                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text("Share app with my friends",style: TextStyle(fontSize: 18.0),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}