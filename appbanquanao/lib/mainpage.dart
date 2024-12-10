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

  // Danh sách các widget cần hiển thị cho các tab
  final List<Widget> _widgetOptions = [
    MyCarousel(), // Trang chủ
    CategoryWidget(), // Danh mục
    ProductCart(), // Giỏ hàng
    DefaulWidget(title: "Tài khoản"), // Tài khoản
  ];

  // Hàm chuyển tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cập nhật tab đã chọn
    });
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
              // Chuyển về tab 2 - Product Cart
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
                      builder: (context, value, child) {
                        // Tính tổng số lượng sản phẩm trong giỏ hàng
                        int totalCount = value.lst
                            .fold(0, (sum, item) => sum + (item.quantity ?? 0));

                        return CartCounter(count: totalCount.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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
      body: _widgetOptions[_selectedIndex], // Chuyển đến widget tương ứng
    );
  }
}
