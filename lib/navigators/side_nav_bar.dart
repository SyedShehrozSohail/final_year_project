import 'package:final_year_project/auth/authentication.dart';
import 'package:final_year_project/auth/homepage.dart';
import 'package:final_year_project/location/map_page.dart';
import 'package:final_year_project/models/updated_booking_history_model.dart';
import 'package:final_year_project/models/updated_order_history_model.dart';
import 'package:final_year_project/navigators/notifications_tab_controller.dart';
//import 'package:final_year_project/auth/login_register_page.dart';
//import 'package:final_year_project/auth/mapping.dart';
import 'package:final_year_project/static_screens/notification.dart';
import 'package:final_year_project/static_screens/order_history.dart';
import 'package:final_year_project/navigators/tab_controller.dart';
import 'package:final_year_project/navigators/usertab_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/screens/aboutus.dart';
import 'package:final_year_project/screens/loginpage.dart';
import 'package:final_year_project/static_screens/userprofile.dart';
import 'package:url_launcher/url_launcher.dart';
class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        '/login': (context) => Login(),
      },
//      theme: new ThemeData(
//        primarySwatch: Colors.red,
//      ),
      home: new UserHome(),
    );
  }
}
class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class UserHome extends StatefulWidget {
  UserHome({
    this.auth,
    this.onSignedOut,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedOut;
  final drawerItems = [
//    new DrawerItem("Admin", Icons.account_circle),
    new DrawerItem("Home", Icons.home),
    new DrawerItem("My Orders", Icons.filter_frames),
    new DrawerItem("My Bookings", Icons.perm_contact_calendar),
//    new DrawerItem("Profile Settings", Icons.settings),
    new DrawerItem("Notifications", Icons.notifications),
    new DrawerItem("Like Our Page", Icons.thumb_up),
    new DrawerItem("Contact Us", Icons.contact_phone),
    new DrawerItem("Location", Icons.location_on),
    new DrawerItem("Logout", Icons.exit_to_app),
  ];

  @override
  State<StatefulWidget> createState() {
    return new UserHomeState();
  }
}

class UserHomeState extends State<UserHome> {
  void _logOutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  int _selectedDrawerIndex = 0;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
//      case 0:
//        return new MyTabbedPage();
      case 0:
        return new UserTabbedPage();
      case 1:
        return new OrderHistoryModel();
      case 2:
        return new BookingHistoryModel();
//      case 3:
//        return new MyAccountSetting();
      case 3:
        return new NotificationsTabbedPage();
      case 4:
//        _launchURL();
        _launchInWebViewOrVC('https://www.facebook.com/Qasai-Wala-100265748396183');
        return new Text("Please support us by liking our official facebook page",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.red),

        );
      case 5:
        return new AboutUs();
      case 6:
        return new GoogleMapsClass();
      case 7:
        _logOutUser();
        return new StartApp();
      default:
        return new Text("Error");
    }
  }
  _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL() async {
    const url = 'https://www.facebook.com/Qasai-Wala-100265748396183';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }
  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }
    if(_selectedDrawerIndex==7) {
      return new Scaffold(
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      );
    }

    else{
      return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        ),
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
//                  image: DecorationImage(
//                    image: NetworkImage(),
//                  ),
                ),
//                accountName: new Text("Syed Shehroz Sohail"),
                accountEmail: new Text("${user?.email}"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/a.png"),
                  backgroundColor: Colors.white,
                ),
                // currentAccountPicture: Image.asset('assets/images/qasai.png'),
              ),
              new Column(children: drawerOptions)
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      );
    }
  }
}

