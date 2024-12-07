import 'package:appbanquanao/data/model/cartcounter.dart';
import 'package:appbanquanao/data/model/product_viewmodel.dart';
import 'package:appbanquanao/page/category/categorywidget.dart';

import 'package:flutter/material.dart';
import 'page/defaulwidget.dart';
import '../../page/carousel.dart';
import 'package:appbanquanao/page/product/productlist.dart';
import 'package:appbanquanao/page/product/productcart.dart';
import 'package:provider/provider.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _loadWidget(int index) {
    var nameWidgets = "Trang chủ";
    switch (index) {
      case 0:
        return MyCarousel();
      case 1:
        return CategoryWidget();

      case 2:
        return ProductCart();
        break;
      case 3:
        nameWidgets = "Tài khoản";
        break;
      default:
        nameWidgets = "None";
        break;
    }
    return DefaulWidget(title: nameWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.store, size: 30),
            SizedBox(width: 8),
            Text("Shop quần áo"),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              // chuyển về tab 2 - Product
              _onItemTapped(2);
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(Icons.shopping_bag, size: 30),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Consumer<ProductsVM>(
                      builder: (context, value, child) => CartCounter(
                        count: value.lst.length.toString(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: const Text('Trang chủ'),
      //         onTap: () {
      //           Navigator.pop(context);
      //           _selectedIndex = 0;
      //           setState(() {});
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.list_alt),
      //         title: const Text('Danh mục'),
      //         onTap: () {
      //           Navigator.pop(context);
      //           _selectedIndex = 1;
      //           setState(() {});
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.shopping_cart),
      //         title: const Text('Giỏ hàng'),
      //         onTap: () {
      //           Navigator.pop(context);
      //           _selectedIndex = 2;
      //           setState(() {});
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('Tài khoản'),
      //         onTap: () {
      //           Navigator.pop(context);
      //           _selectedIndex = 3;
      //           setState(() {});
      //         },
      //       ),
      //       const Divider(
      //         color: Colors.black,
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.exit_to_app),
      //         title: const Text('Logout'),
      //         onTap: () {
      //           Navigator.pop(context);
      //           _selectedIndex = 0;
      //           setState(() {});
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Danh mục',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _loadWidget(_selectedIndex),
    );
  }
}
