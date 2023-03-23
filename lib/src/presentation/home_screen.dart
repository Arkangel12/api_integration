import 'package:api_integration/src/data/album/model/album.dart';
import 'package:api_integration/src/data/album/repository/album_repository.dart';
import 'package:api_integration/src/data/album/service/album_service.dart';
import 'package:api_integration/src/domain/album/use_case/fetch_albums_use_case.dart';
import 'package:flutter/material.dart';

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
  late final FetchAlbumsUseCase fetchAlbumsUseCase;
  late final AlbumRepository albumRepository;
  late final AlbumService albumService;

  @override
  void initState() {
    super.initState();
    albumService = AlbumService();
    albumRepository = AlbumRepositoryImpl(albumService);
    fetchAlbumsUseCase = FetchAlbumsUseCase(albumRepository);
    albums = fetchAlbumsUseCase.call();
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
                return AlbumItem(
                  album: snapshot.data![i],
                );
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
