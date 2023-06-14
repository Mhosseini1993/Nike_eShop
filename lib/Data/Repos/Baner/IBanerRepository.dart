import 'package:nike/Data/Models/Baner/Baner.dart';

abstract class IBanerRepository{
  Future<List<Baner>> getAll();
}