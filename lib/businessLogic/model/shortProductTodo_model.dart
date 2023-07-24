// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

ShortProductTodo cartModelFromJson(String str) => ShortProductTodo.fromJson(json.decode(str));

String cartModelToJson(ShortProductTodo data) => json.encode(data.toJson());

class ShortProductTodo {
  String title;
  double qty;
  double price;
  double totalPrice;
    
    

    ShortProductTodo({
        required this.title,
        required this.qty,
        required this.price,
        required this.totalPrice,
        
        
      
    });

    factory ShortProductTodo.fromJson(Map<String, dynamic> json) => ShortProductTodo(
        
        title: json["title"],
        qty: json["qty"],
        price: json["price"],
        totalPrice:json["totalPrice"],
        
      
    );

    Map<String, dynamic> toJson() => {
       
        "title": title,
        "qty": qty,
        "price": price,
        "totalPrice" : totalPrice
        
       
    };
}