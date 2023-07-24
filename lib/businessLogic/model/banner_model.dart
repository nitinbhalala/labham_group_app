// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(json.decode(str).map((x) => BannerModel.fromJson(x)));

String bannerModelToJson(List<BannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModel {
    BannerModel({
        required this.id,
        required this.bannerUrl,
    });

    int id;
    String bannerUrl;

    factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        bannerUrl: json["banner_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "banner_url": bannerUrl,
    };
}
