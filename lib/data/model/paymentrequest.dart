// To parse this JSON data, do
//
//     final itemOrder = itemOrderFromJson(jsonString);

import 'dart:convert';

ItemOrder itemOrderFromJson(String str) => ItemOrder.fromJson(json.decode(str));

String itemOrderToJson(ItemOrder data) => json.encode(data.toJson());

// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

Transaction transactionFromJson(String str) =>
    Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  Transaction({
    this.bank,
    this.orderId,
    this.grossAmount,
    this.customerEmail,
    this.customerName,
    this.customerPhone,
    this.expired,
  });

  String bank;
  String orderId;
  int grossAmount;
  String customerEmail;
  String customerName;
  String customerPhone;
  int expired;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        bank: json["bank"],
        orderId: json["order_id"],
        grossAmount: json["gross_amount"],
        customerEmail: json["customer_email"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        expired: json["expired"],
      );

  Map<String, dynamic> toJson() => {
        "bank": bank,
        "order_id": orderId,
        "gross_amount": grossAmount,
        "customer_email": customerEmail,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "expired": expired,
      };
}

class ItemOrder {
  ItemOrder({
    this.price,
    this.quantity,
    this.name,
  });

  int price;
  int quantity;
  String name;

  factory ItemOrder.fromJson(Map<String, dynamic> json) => ItemOrder(
        price: json["price"],
        quantity: json["quantity"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "quantity": quantity,
        "name": name,
      };
}
