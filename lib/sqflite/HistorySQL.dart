class HistorySQL {
    int saleId;
    int saleDay;
    int saleMonth;
    int saleYear;
    int sumSales;

    HistorySQL({
        this.saleDay,
        this.saleMonth,
        this.saleYear,
        this.sumSales,
    });

    int get id => saleId;
    int get day => saleDay;
    int get month => saleMonth;
    int get year => saleYear;
    int get sum => sumSales;


    HistorySQL.fromMap(Map<String, dynamic> map){
        this.saleId = map["id"];
        this.saleDay = map["day"];
        this.saleMonth = map["month"];
        this.saleYear = map["year"];
        this.sumSales = map["sum"];
    }

    Map<String, dynamic> toMap() {
      var map = new Map<String, dynamic>();
        if (saleId != null) {
          map['id'] = saleId;
        }
        map["day"] =  saleDay;
        map["month"] = saleMonth;
        map["year"] = saleYear;
        map["sum"] =  sumSales;
    return map;
    }
    
}