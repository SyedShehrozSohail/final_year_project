import 'package:final_year_project/user_home/updated_makeBooking.dart';
import 'package:final_year_project/user_home/updated_makeOrder.dart';
import 'package:final_year_project/user_home/pending_request.dart';
import 'package:flutter/material.dart';

class UserTabbedPage extends StatefulWidget {
  const UserTabbedPage({ Key key }) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<UserTabbedPage> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'ORDERS'),
    Tab(text: 'BOOKINGS'),
//    Tab(text: 'PENDING',),
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
            backgroundColor: Colors.black,
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
//          MakeOrder(),
          MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: OrderForm(),
          ),
          MaterialApp(
            home: BookingForm(),
            theme: ThemeData.light().copyWith(
              primaryColor: Colors.red,
              accentColor: Colors.red,
              inputDecorationTheme:
              InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    const Radius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
//          PendingScreen(),
        ],
      ),
    );
  }
}