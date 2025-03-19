import 'package:flutter/material.dart';
import 'package:rental_management_app/features/auth/presentation/pages/login_page.dart';
import 'package:rental_management_app/features/home/presentation/pages/notifications_page.dart';
import 'package:rental_management_app/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:rental_management_app/features/home/presentation/widgets/chat.dart';
import 'package:rental_management_app/features/home/presentation/widgets/custom_drawer.dart';
import 'package:rental_management_app/features/home/presentation/widgets/custom_gridview.dart';
import 'package:rental_management_app/features/home/presentation/widgets/slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  /* final List<Widget> _pages = [
    Center(child: Text("Home Page")),
    Center(child: Text("Search Page")),
    Center(child: Text("Profile Page")),
  ]; */

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onLogout()
  {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => LoginPage())
    );
  }

  Offset position = const Offset(415, 100);
  Offset initialPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        userName: 'hongtong@gmail.com', 
        userEmail: 'Tong Xuan Hoang', 
        onLogout: onLogout
      ),
      body: Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height: 57,
                margin: EdgeInsets.only(top: 28, left: 28, right: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (context) => GestureDetector(
                        onTap: () => Scaffold.of(context).openDrawer(),
                        child: Container(
                          height: 57,
                          width: 57,
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Color.fromARGB(8, 10, 9, 40),
                          ),
                          child: Icon(Icons.menu),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => NotificationPage2()),
                        );
                      },
                      child: Container(
                        height: 57,
                        width: 57,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Color.fromARGB(8, 10, 9, 40),
                        ),
                        child: Icon(Icons.notifications),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 28, left: 28, right: 28),
                child: Text(
                  'Your Branch Name',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              DefaultTabController(
                length: 2, 
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      margin: EdgeInsets.only(top: 28, left: 28, right: 28),
                      child: TabBar(
                        labelPadding: EdgeInsets.only(left: 14, right: 14),
                        indicatorPadding: EdgeInsets.only(left: 14, right: 14),
                        isScrollable: true,
                        labelColor: Color.fromARGB(255, 0, 0, 0),
                        unselectedLabelColor: Color.fromARGB(137, 168, 168, 143),
                        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        unselectedLabelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 2.4),
                          insets: EdgeInsets.symmetric(horizontal: 28),
                        ),
                        tabs: [
                          Tab(
                            child: Text('Sơ đồ'),
                          ),
                          Tab(
                            child: Text('Vị trí'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 330,
                      margin: EdgeInsets.only(top: 10),
                      child: TabBarView(
                        children: [
                          BranchMapSlider(),
                          BranchMapSlider(),
                        ],
                      )
                    ),
                  ],
                )   
              ),
              Padding(
                padding: EdgeInsets.only(top: 28, left: 28, right: 28, bottom: 20),
                child: Text(
                  'Tiện ích',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              UtilitiesGrid(),
            ],
          ),
          
          ChatMiniWidget(),
        ]
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
