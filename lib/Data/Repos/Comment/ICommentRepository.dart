
import 'package:nike/Data/Models/Comment/Comment.dart';

abstract class ICommentRepository{
  Future<List<Comment>> FetchCommentByProductId(int productId);
}