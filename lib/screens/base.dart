import 'package:budget_tracker/screens/charts_page.dart';
import 'package:budget_tracker/screens/home_page.dart';

import 'package:flutter/material.dart';

import '../widgets/colors.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  late PageController pageController;

  // bool _isLoading = false;

  // QuerySnapshot? data;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    pageController = new PageController();
  }

  // fetching() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (FirebaseAuth.instance.currentUser!.email != null) {
  //     await Database()
  //         .fetchUserDetails(FirebaseAuth.instance.currentUser!.email)
  //         .then((value) {
  //       if (value != null) {
  //         setState(() {
  //           _isLoading = false;
  //           data = value;

  //           print(data);
  //         });
  //       } else {
  //         _isLoading = false;
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text("Error occured")));
  //       }
  //     });
  //   } else {
  //     await Database()
  //         .fetchUserDetailsUser(FirebaseAuth.instance.currentUser!.displayName)
  //         .then((value) {
  //       if (value != null) {
  //         setState(() {
  //           _isLoading = false;
  //           data = value;

  //           print(data);
  //         });
  //       } else {
  //         _isLoading = false;
  //         ScaffoldMessenger.of(context)
  //             .showSnackBar(SnackBar(content: Text("Error occured")));
  //       }
  //     });
  //   }
  // }

  List<Widget> _pages = <Widget>[HomePage(), ChartPage()];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColors.secondaryColor,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: (val) {
            setState(() {
              _selectedIndex = val;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 20,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 20),
              label: "Charts",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box, size: 20),
              label: "Goals",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month, size: 20),
              label: "Bills",
            ),
          ]),
      body: _pages.elementAt(_selectedIndex),
    );
  }
}
