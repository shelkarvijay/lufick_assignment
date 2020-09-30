// To parse this JSON data, do
//
//     final currencyModalClass = currencyModalClassFromJson(jsonString);

import 'dart:convert';

CurrencyModalClass currencyModalClassFromJson(String str) =>
    CurrencyModalClass.fromJson(json.decode(str));

String currencyModalClassToJson(CurrencyModalClass data) =>
    json.encode(data.toJson());

CurrencyModalClass clientFromJson(String str) {
  final jsonData = json.decode(str);
  return CurrencyModalClass.fromMap(jsonData);
}

String clientToJson(CurrencyModalClass data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class CurrencyModalClass {
  CurrencyModalClass({
    this.currencyName,
    this.currencyValue,
  });

  String currencyName;
  String currencyValue;

  factory CurrencyModalClass.fromJson(Map<String, dynamic> json) =>
      CurrencyModalClass(
        currencyName: json["currency_name"],
        currencyValue: json["currency_value"],
      );

  Map<String, dynamic> toJson() => {
        "currency_name": currencyName,
        "currency_value": currencyValue,
      };

  factory CurrencyModalClass.fromMap(Map<String, dynamic> json) =>
      new CurrencyModalClass(
        currencyName: json["currency_name"],
        currencyValue: json["currency_value"],
      );

  Map<String, dynamic> toMap() => {
        "currency_name": currencyName,
        "currency_value": currencyValue,
      };
}
