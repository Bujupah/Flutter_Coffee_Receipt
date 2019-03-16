class StockSQL {
    int productId;
    String productName;
    int productQuantity;

    StockSQL({
        this.productName,
        this.productQuantity,
    });

    int get id => productId;
    String get name => productName;
    int get quantity => productQuantity;


    StockSQL.fromMap(Map<String, dynamic> map){
        this.productId = map["id"];
        this.productName = map["name"];
        this.productQuantity = map["quantity"];
  }

    Map<String, dynamic> toMap(){
      var map = new Map<String, dynamic>();
        if (productId != null) {
          map['id'] = productId;
        }
        map["name"] = productName;
        map["quantity"] = productQuantity;

      return map;
    }
}