class JumloHistoryModel {
  String? nameOfPerson;
  String? historyID;
  String? productName;
  double? priceGroupItems;
  int? quantity;
  double? totalPrice;
  String? dateTold;
  bool? isLoan;

  JumloHistoryModel(
      {this.nameOfPerson,
        this.historyID,
        this.isLoan,
        this.productName,
        this.priceGroupItems,
        this.quantity,
        this.dateTold,
        this.totalPrice});
}
