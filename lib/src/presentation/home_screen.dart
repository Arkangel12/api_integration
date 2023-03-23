import 'package:api_integration/src/data/album/model/album.dart';
import 'package:api_integration/src/presentation/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albums = ref.watch(fetchAlbumProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: albums == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: albums.length,
              itemBuilder: (_, i) {
                return AlbumItem(
                  album: albums[i],
                );
              },
            ),
    );
  }
}

class AlbumItem extends StatelessWidget {
  const AlbumItem({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('${album.id}'),
      ),
      title: Text(album.title),
      subtitle: Text('User ID: ${album.userId}'),
    );
  }
}
