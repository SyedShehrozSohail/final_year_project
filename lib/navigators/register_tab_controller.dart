import 'package:final_year_project/user_home/register_butchers.dart';
import 'package:final_year_project/user_home/register_shop.dart';
import 'package:flutter/material.dart';

class RegisterTabbedPage extends StatefulWidget {
  const RegisterTabbedPage({ Key key }) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<RegisterTabbedPage> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'BUTCHERS'),
    Tab(text: 'SHOPS'),
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
          MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: ButcherRegisterForm(),
          ),
          MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: ShopRegisterForm(),
          ),

        ],
      ),
    );
  }
}