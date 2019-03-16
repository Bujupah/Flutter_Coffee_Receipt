class sale {
  String _name;
  int _price;
  String _image_url;

   sale(this._name, this._price, this._image_url);

  String get image_url => _image_url;

  set image_url(String value) {
    _image_url = value;
  }

  int get price => _price;

  set price(int value) {
    _price = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}
