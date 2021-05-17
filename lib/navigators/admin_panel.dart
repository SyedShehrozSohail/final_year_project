import 'package:final_year_project/auth/authentication.dart';
import 'package:final_year_project/auth/homepage.dart';
import 'package:final_year_project/models/view_booking_requests_model.dart';
import 'package:final_year_project/models/view_order_requests_model.dart';
import 'package:final_year_project/navigators/register_tab_controller.dart';
import 'package:final_year_project/navigators/tab_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/screens/loginpage.dart';
class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        '/login': (context) => Login(),
      },
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new AdminPanel(),
    );
  }
}
class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class AdminPanel extends StatefulWidget {
  AdminPanel({
    this.auth,
    this.onSignedOut,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedOut;
  final drawerItems = [
    new DrawerItem("Admin Panel", Icons.account_circle),
    new DrawerItem("View Orders", Icons.filter_frames),
    new DrawerItem("View Bookings", Icons.perm_contact_calendar),
    new DrawerItem("Register Staff", Icons.group_add),
    new DrawerItem("Logout", Icons.exit_to_app),
  ];

  @override
  State<StatefulWidget> createState() {
    return new AdminPanelState();
  }
}

class AdminPanelState extends State<AdminPanel> {
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
      case 0:
        return new MyTabbedPage();
      case 1:
        return new OrderRequestModel();
      case 2:
        return new BookingRequestModel();
      case 3:
        return new RegisterTabbedPage();
      case 4:
        _logOutUser();
        return new StartApp();
      default:
        return new Text("Error");
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
          elevation: 0.0,
          title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        ),
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
                accountEmail: new Text("${user?.email}"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/a.png"),
                  backgroundColor: Colors.white,
                ),
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

