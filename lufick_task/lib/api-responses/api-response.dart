// To parse this JSON data, do
//
//     final currencyListResponse = currencyListResponseFromJson(jsonString);

import 'dart:convert';

CurrencyListResponse currencyListResponseFromJson(String str) => CurrencyListResponse.fromJson(json.decode(str));

String currencyListResponseToJson(CurrencyListResponse data) => json.encode(data.toJson());

class CurrencyListResponse {
    CurrencyListResponse({
        this.rates,
        this.base,
        this.date,
    });

    Map<String, double> rates;
    String base;
    String date;

    factory CurrencyListResponse.fromJson(Map<String, dynamic> json) => CurrencyListResponse(
        rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v.toDouble())),
        base: json["base"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "base": base,
        "date": date,
    };
}
