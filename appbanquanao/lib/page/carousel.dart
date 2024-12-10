import 'package:appbanquanao/config/const.dart';
import 'package:appbanquanao/data/data.dart';
import 'package:appbanquanao/data/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../data/data/productdata.dart';
import '../data/model/product_viewmodel.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({super.key});

  @override
  State<MyCarousel> createState() => _CombinedScreenState();
}

class _CombinedScreenState extends State<MyCarousel> {
  List<Product> lstProduct = [];
  late Future<List<Product>> futureProducts;
  List<int> favoriteProducts = [];

  @override
  void initState() {
    super.initState();
    lstProduct = createDataList(10);
    futureProducts = ReadData().loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel Slider
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: slide(lstProduct),
            ),
            // Grid View
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Lỗi: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Không có sản phẩm nào!"));
                  }

                  // Hiển thị danh sách sản phẩm
                  List<Product> products = snapshot.data!;
                  return GridView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // Tắt cuộn cho GridView
                    shrinkWrap: true, // Để GridView hoạt động trong Column
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      return itemGridView(
                          products[index], favoriteProducts, context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget slide(List<Product> listProduct) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: listProduct
          .map(
            (item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      url_img + item.img!,
                      fit: BoxFit.fitHeight,
                      width: 900.0,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget itemGridView(
      Product productModel, List<int> favoriteProducts, BuildContext context) {
    bool isFavorite = favoriteProducts
        .contains(productModel.id ?? -1); // Sử dụng toán tử ?? để thay thế null

    return Container(
      width: 150,
      height: 150,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                // Hình ảnh sản phẩm
                child: Image.asset(
                  url_product_img + (productModel.img ?? 'placeholder.png'),
                  fit: BoxFit.fill,
                  height: 150,
                  width: 150,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image),
                ),
              ),
              // Tên sản phẩm và giá
              Text(
                productModel.name ?? '',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                "Price: ${NumberFormat.currency(locale: 'vi_VN', symbol: 'VND').format(productModel.price)}",
                style: const TextStyle(fontSize: 14, color: Colors.red),
              )
            ],
          ),
          // Icon trái tim yêu thích ở góc trên bên phải
          Positioned(
            top: 2,
            right: 2,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  if (isFavorite) {
                    favoriteProducts.remove(
                        productModel.id ?? -1); // Đảm bảo không truyền null
                  } else {
                    favoriteProducts.add(
                        productModel.id ?? -1); // Đảm bảo không truyền null
                  }
                });
                showSnackBar(
                    isFavorite ? "Đã bỏ yêu thích" : "Đã thêm yêu thích",
                    context);
              },
            ),
          ),
          // Row chứa nút Thêm và Trừ
          Positioned(
            bottom: 2,
            left: 8,
            right: 8,
            child: Consumer<ProductsVM>(
              builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nút Trừ sản phẩm
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.red,
                        size: 18,
                      ),
                      label: const Text(''),
                      onPressed: () {
                        value.add(productModel); // Logic trừ sản phẩm
                        showSnackBar("Đã trừ sản phẩm khỏi giỏ hàng", context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.white, // Màu nền
                        foregroundColor: Colors.red, // Màu chữ
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Khoảng cách giữa nút
                  // Nút Thêm sản phẩm
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.orange,
                        size: 18,
                      ),
                      label: const Text(''),
                      onPressed: () {
                        value.del(0); // Logic thêm sản phẩm
                        showSnackBar("Thêm vào giỏ hàng thành công", context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm hiển thị snack bar
  void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
