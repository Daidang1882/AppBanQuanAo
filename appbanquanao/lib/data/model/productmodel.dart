class Product {
  int? id;
  String? name;
  int? price;
  String? img;
  String? des;
  int? catId;

  Product({this.id, this.name, this.price, this.img, this.des, this.catId});

  // Ánh xạ từ JSON sang đối tượng Product
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    des = json['des'];
    catId = json['catId'];
  }

  // Chuyển đối tượng Product thành JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['img'] = img;
    data['des'] = des;
    data['catId'] = catId;
    return data;
  }
}
