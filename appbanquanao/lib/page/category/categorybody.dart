import 'package:flutter/material.dart';
import '../../data/model/categorymodel.dart';
import '../../config/const.dart';
import '../../page/product/productwidget.dart';

Widget itemCateView(Category itemcate, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductWidget(
            objCat: itemcate,
          ),
        ),
      );
    },
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Ảnh nền
        Container(
          width: 200, // Chiều rộng ảnh
          height: 200, // Chiều cao ảnh
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), // Bo góc ảnh
          ),
          child: Image.asset(
            url_img +
                (itemcate.img ??
                    'default_image.png'), // Ảnh mặc định nếu img là null
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  );
}

Widget itemCateGrid(List<Category> categories, BuildContext context) {
  return GridView.builder(
    itemCount: categories.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, // 2 cột trong grid
      childAspectRatio: 1, // Tỷ lệ chiều rộng và chiều cao của mỗi mục
      crossAxisSpacing: 16, // Khoảng cách ngang giữa các mục
      mainAxisSpacing: 16, // Khoảng cách dọc giữa các mục
    ),
    itemBuilder: (context, index) {
      return itemCateView(
          categories[index], context); // Hiển thị từng mục trong lưới
    },
  );
}
