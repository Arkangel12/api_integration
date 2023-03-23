import 'dart:convert';

import 'package:api_integration/src/model/album.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Album>> albums;

  @override
  void initState() {
    super.initState();
    albums = fetchAlbum();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Album>>(
        future: albums,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, i) {
                return Text(snapshot.data![i].title);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
