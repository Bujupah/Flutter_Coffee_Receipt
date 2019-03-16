class SalesSQL {
    int saleId;
    String saleProduct;
    int saleQuantity;
    int saleSum;

    SalesSQL({
        this.saleProduct,
        this.saleQuantity,
        this.saleSum,
    });

    int get id => saleId;
    String get day => saleProduct;
    int get month => saleQuantity;
    int get year => saleSum;


    SalesSQL.fromMap(Map<String, dynamic> map){
        this.saleId = map["saleId"];
        this.saleProduct = map["saleP"];
        this.saleQuantity = map["saleQ"];
        this.saleSum = map["saleS"];
    }

    Map<String, dynamic> toMap() {
      var map = new Map<String, dynamic>();
        if (saleId != null) {
          map['saleId'] = saleId;
        }
        map["saleP"] = saleProduct;
        map["saleQ"] = saleQuantity;
        map["saleS"] =  saleSum;
    return map;
    }
    
}