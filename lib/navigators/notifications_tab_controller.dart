import 'package:final_year_project/models/approved_booking_model.dart';
import 'package:final_year_project/models/approved_order_model.dart';
import 'package:flutter/material.dart';

class NotificationsTabbedPage extends StatefulWidget {
  const NotificationsTabbedPage({ Key key }) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<NotificationsTabbedPage> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'APPROVED BOOKINGS'),
    Tab(text: 'APPROVED ORDERS'),
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
            home: ApprovedBookingModel(),
          ),
          MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: ApprovedOrderModel(),
          ),
//          PendingScreen(),
        ],
      ),
    );
  }
}