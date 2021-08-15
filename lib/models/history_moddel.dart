class HistoryModel {
  String? historyID;
  String? productName;
  double? pricePerItemToSell;
  int? quantity;
  double? totalPrice;

  HistoryModel(
      {this.historyID,
        this.productName,
        this.pricePerItemToSell,
        this.quantity,
        this.totalPrice});
}