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
  final List<Widget> _pages = <Widget>[HomePage(), ChartPage()];
  late PageController pageController;

  // bool _isLoading = false;

  // QuerySnapshot? data;
  @override
  void initState() {
    // TODO: implement initState
    pageController = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppColors.secondaryColor,
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onTapped,
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
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: _pages,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
