import 'package:meta/meta.dart';

class Store {
  String _id;
  String _name;
  String _iconUrl;
  String _address;
  List<String> _categories;

  Store(
      {@required id,
      @required name,
      @required iconUrl,
      @required address,
      @required categories})
      : this._id = id,
        this._name = name,
        this._iconUrl = iconUrl,
        this._address = address,
        this._categories = categories;

  get id => _id;
  get name => _name;
  get iconUrl => _iconUrl;
  get address => _address;
  List<String> get categories => _categories;

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        categories: json["categories"].cast<String>(),
        iconUrl: json["iconUrl"]);
  }

  @override
  String toString() {
    return 'name: ' +
        _name +
        '\n iconUrl: ' +
        _iconUrl +
        '\n address: ' +
        _address +
        '\n categories: ' +
        _categories.toString();
  }
}
