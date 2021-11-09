import 'dart:convert';

EntriesModel entriesModelFromJson(String str) =>
    EntriesModel.fromJson(json.decode(str));

String entriesModelToJson(EntriesModel data) => json.encode(data.toJson());

class EntriesModel {
  EntriesModel({
    this.entriesModels,
    this.errorMessage,
  });

  List<EntriesModelElement> entriesModels;
  String errorMessage;

  factory EntriesModel.fromJson(Map<String, dynamic> json) => EntriesModel(
        entriesModels: List<EntriesModelElement>.from(
            json["entriesModels"].map((x) => EntriesModelElement.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "entriesModels":
            List<dynamic>.from(entriesModels.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class EntriesModelElement {
  EntriesModelElement({
    this.id,
    this.entryWord,
    this.wordType,
    this.translation,
    this.alternateTranslations,
    this.alternateSpellings,
    this.description,
    this.imageThumbnail,
    this.imageFull,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.audio,
  });

  int id;
  String entryWord;
  String wordType;
  String translation;
  dynamic alternateTranslations;
  dynamic alternateSpellings;
  String description;
  String imageThumbnail;
  String imageFull;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String category;
  dynamic audio;

  factory EntriesModelElement.fromJson(Map<String, dynamic> json) =>
      EntriesModelElement(
        id: json["id"],
        entryWord: json["entry_word"],
        wordType: json["word_type"],
        translation: json["translation"],
        alternateTranslations: json["alternate_translations"],
        alternateSpellings: json["alternate_spellings"],
        description: json["description"] == null ? null : json["description"],
        imageThumbnail: json["image_thumbnail"],
        imageFull: json["image_full"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: json["category"],
        audio: json["audio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entry_word": entryWord,
        "word_type": wordType,
        "translation": translation,
        "alternate_translations": alternateTranslations,
        "alternate_spellings": alternateSpellings,
        "description": description == null ? null : description,
        "image_thumbnail": imageThumbnail,
        "image_full": imageFull,
        "published_at": publishedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category,
        "audio": audio,
      };
}
