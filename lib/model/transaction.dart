class Transactions {
  String type;
  String category;
  String detail;
  String amount;
  String date;
  String icon;

  Transactions(
    this.type ,
    this.category ,
    this.detail ,
    this.amount ,
    this.date ,
  );

  Transactions.forDemo(
    this.type ,
    this.category ,
    this.detail ,
    this.amount ,
    this.date ,
    this.icon
  );

  factory Transactions.fromMap(Map<String, dynamic> data) {
    return Transactions(
      data['type'],
      data['category'],
      data['detail'],
      data['amount'],
      data['date'],
    );
  }
}