import 'package:appbanquanao/mainpage.dart';
import 'package:appbanquanao/page/product/productcart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appbanquanao/data/model/product_viewmodel.dart';
import 'package:appbanquanao/page/product/productbody.dart'; // Thêm trang sản phẩm

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Đăng ký ProductsVM provider
        ChangeNotifierProvider(
          create: (context) => ProductsVM(),
        ),
        // Đăng ký FavoriteProvider provider
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Mainpage(),
        routes: {
          '/cart': (context) =>
              ProductCart(), // Đường dẫn đến màn hình giỏ hàng
        },
      ),
    );
  }
}
