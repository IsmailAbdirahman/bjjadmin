class HistoryModel {
  String? historyID;
  String? productName;
  double? pricePerItemToSell;
  int? quantity;
  double? totalPrice;
  String? dateSold;

  HistoryModel(
      {this.historyID,
      this.productName,
      this.pricePerItemToSell,
      this.quantity,
      this.dateSold,
      this.totalPrice});
}
