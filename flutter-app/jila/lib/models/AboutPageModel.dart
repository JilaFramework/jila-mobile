import 'dart:convert';

AboutPage aboutPageFromJson(String str) => AboutPage.fromJson(json.decode(str));

String aboutPageToJson(AboutPage data) => json.encode(data.toJson());

class AboutPage {
  AboutPage({
    this.id,
    this.aboutUs,
    this.contactUs,
    this.partners,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String aboutUs;
  String contactUs;
  String partners;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory AboutPage.fromJson(Map<String, dynamic> json) => AboutPage(
        id: json["id"],
        aboutUs: json["aboutUs"],
        contactUs: json["contactUs"],
        partners: json["partners"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "aboutUs": aboutUs,
        "contactUs": contactUs,
        "partners": partners,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
