import 'package:nike/Data/Models/Baner/Baner.dart';
import 'package:nike/Data/Repos/Baner/IBanerRepository.dart';
import 'package:nike/Data/Source/Baner/IBanerDataSource.dart';


class BanerRepository implements IBanerRepository {
  final IBanerDataSource _remoteDataSource;

  BanerRepository(this._remoteDataSource);

  @override
  Future<List<Baner>> getAll() => _remoteDataSource.getAll();
}
