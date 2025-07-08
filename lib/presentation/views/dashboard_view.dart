import 'package:flutter/material.dart';
import 'package:shop_me/presentation/views/account_view.dart';
import 'package:shop_me/presentation/views/order_history_view.dart';
import 'category_view.dart';
import 'home_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const HomeView(),
    const CategoryView(),
    const OrderHistoryView(),
    const AccountView(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomAppBar(
        height: 90,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.category_sharp),
                label: "Category",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart),
                label: "Order History",
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.account_circle),
                label: "Account",
              ),
            ],
            currentIndex: _selectedIndex,
            //New
            onTap: _onItemTapped,
            selectedItemColor: Colors.blue.shade900,
            unselectedItemColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
