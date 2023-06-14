
import 'package:nike/Data/Models/Baner/Baner.dart';

abstract class IBanerDataSource{
  Future<List<Baner>> getAll();
}