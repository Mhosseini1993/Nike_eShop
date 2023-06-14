
import 'package:nike/Data/Models/Comment/Comment.dart';

abstract class ICommentDataSource{
  Future<List<Comment>> FetchCommentByProductId(int productId);
}