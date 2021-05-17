import 'package:final_year_project/screens/butchers_list.dart';
import 'package:final_year_project/screens/shops_list.dart';
import 'package:final_year_project/screens/updated_butchersList.dart';
import 'package:final_year_project/screens/updated_shopsList.dart';
import 'package:final_year_project/screens/updated_usersList.dart';
import 'package:final_year_project/screens/users_list.dart';
import 'package:flutter/material.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({ Key key }) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
//    Tab(text: 'USERS'),
    Tab(text: 'SHOPS'),
    Tab(text: 'BUTCHERS'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(64.0),
          child: AppBar(
            automaticallyImplyLeading: false, // hides leading widget
            bottom: TabBar(
              controller: _tabController,
              tabs: myTabs,
            ),
          )
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
//          UsersList(),
          ShopsList(),
          ButchersList(),
        ],
      ),
    );
  }
}