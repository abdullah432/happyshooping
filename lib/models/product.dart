import 'package:meta/meta.dart';
class Product {
  String _id;
  String _name;
  String _description;
  String _imageUrl;
  int _totalPrice;
  int _cashback;
  List<String> _categories;

  Product(
      {
      @required id,
      @required name,
      @required description,
      @required totalPrice,
      @required cashback,
      @required imageUrl,
      @required categories})
      : 
        this._id = id,
        this._name = name,
        this._description = description,
        this._totalPrice = totalPrice,
        this._cashback = cashback,
        this._imageUrl = imageUrl,
        this._categories = categories;

  get id => _id;
  get name => _name;
  get imageUrl => _imageUrl;
  get description => _description;
  get totalPrice => _totalPrice;
  get cashback => _cashback;
  List<String> get categories => _categories;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["_id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        categories: json["categories"].cast<String>(),
        description: json["description"],
        cashback: json["cashback"],
        totalPrice: json["price"]
        );
  }

  @override
  String toString() {
    return 'name: '+_name+'\n imageUrl: '+_imageUrl+'\n description: '+_description+'\n categories: '+_categories.toString();
  }
}