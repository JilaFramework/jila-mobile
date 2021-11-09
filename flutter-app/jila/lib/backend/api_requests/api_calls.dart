import 'package:jila/models/AboutPageModel.dart';
import 'package:jila/models/EntriesModel.dart';

import 'api_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<EntriesModel> fetchEntries(bool fetchCommonPhrases) async {
  String url = 'http://localhost:5000/api/entries';

  if (fetchCommonPhrases) {
    url += "?category=common_phrases";
  }

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return entriesModelFromJson(response.body);
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<EntriesModel> fetchEntriesByWord(String searchWord) async {
  if (searchWord.isEmpty || searchWord == null) {
    throw Exception('Search word not provided.');
  }

  String url = 'http://localhost:5000/api/entries';
  url += "/searchword?word=${searchWord}";

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return entriesModelFromJson(response.body);
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<AboutPage> fetchAboutPage() async {
  String url = 'http://localhost:5000/api/aboutpage';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return aboutPageFromJson(response.body);
  } else {
    throw Exception('Unexpected error occured!');
  }
}
