import 'package:api_integration/src/data/album/model/album.dart';
import 'package:api_integration/src/data/album/repository/album_repository.dart';

class FetchAlbumsUseCase {
  final AlbumRepository _albumRepository;

  FetchAlbumsUseCase(this._albumRepository);

  Future<List<Album>> call() async => await _albumRepository.fetchAlbum();
}