
import 'package:nike/Data/Models/Comment/Comment.dart';
import 'package:nike/Data/Repos/Comment/ICommentRepository.dart';
import 'package:nike/Data/Source/Comment/ICommentDataSource.dart';

class CommentRepository implements ICommentRepository{
  final ICommentDataSource _remoteDataSource;
  CommentRepository(this._remoteDataSource);
  @override
  Future<List<Comment>> FetchCommentByProductId(int productId) => _remoteDataSource.FetchCommentByProductId(productId);

}