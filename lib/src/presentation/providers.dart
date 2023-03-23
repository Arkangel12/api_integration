import 'package:api_integration/src/data/album/repository/album_repository.dart';
import 'package:api_integration/src/data/album/service/album_service.dart';
import 'package:api_integration/src/domain/album/use_case/fetch_albums_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final albumServiceProvider = Provider<AlbumService>((ref) => AlbumService());

final albumRepositoryProvider = Provider<AlbumRepository>((ref) {
  final albumService = ref.watch(albumServiceProvider);
  return AlbumRepositoryImpl(albumService);
});

final fetchAlbumProvider = FutureProvider((ref) async {
  final albumRepository = ref.watch(albumRepositoryProvider);
  final albums = await FetchAlbumsUseCase(albumRepository).call();
  return albums;
});
