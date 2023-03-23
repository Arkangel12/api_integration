import 'dart:convert';


import 'package:api_integration/src/data/album/model/album.dart';
import 'package:http/http.dart' as http;

class AlbumService {
  Future<List<Album>> fetchAlbum() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    );

    if (response.statusCode == 200) {
      final list = json.decode(response.body) as List;
      return list.map((data) => Album.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
