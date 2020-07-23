import 'package:meta/meta.dart';
class Product {
  String _id;
  String _name;
  String _description;
  String _imageUrl;
  int _totalPrice;
  int _cashback;
  List<String> _categories;

  Product.init(
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

  @override
  String toString() {
    return 'name: '+_name+'\n imageUrl: '+_imageUrl+'\n description: '+_description+'\n categories: '+_categories.toString();
  }
}