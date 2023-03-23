import 'package:api_integration/src/data/album/model/album.dart';
import 'package:api_integration/src/data/album/service/album_service.dart';

abstract class AlbumRepository {
  Future<List<Album>> fetchAlbum();
}

class AlbumRepositoryImpl extends AlbumRepository {
  final AlbumService _albumService;

  AlbumRepositoryImpl(this._albumService);

  @override
  Future<List<Album>> fetchAlbum() async {
    return await _albumService.fetchAlbum();
  }
}