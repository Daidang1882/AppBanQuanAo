class Product {
  int? id;
  String? name;
  int? price;
  String? img;
  String? des;
  int? catId;
  int quantity; // Thêm thuộc tính quantity để theo dõi số lượng

  // Constructor
  Product({
    this.id,
    this.name,
    this.price,
    this.img,
    this.des,
    this.catId,
    this.quantity = 1, // Khởi tạo số lượng mặc định là 1
  });

  // Ánh xạ từ JSON sang đối tượng Product
  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        img = json['img'],
        des = json['des'],
        catId = json['catId'],
        quantity = json['quantity'] ?? 1; // Nếu không có 'quantity' trong JSON, gán mặc định là 1

  // Chuyển đối tượng Product thành JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['img'] = img;
    data['des'] = des;
    data['catId'] = catId;
    data['quantity'] = quantity; // Thêm quantity vào JSON
    return data;
  }
}
