import 'package:dio/dio.dart';
import 'package:nike/Data/Common/HttpResponseValidator.dart';
import 'package:nike/Data/Models/Comment/Comment.dart';
import 'package:nike/Data/Source/Comment/ICommentDataSource.dart';

class RemoteCommentDataSource
    with HttpResponseValidator
    implements ICommentDataSource {
  final Dio _httpcontext;

  RemoteCommentDataSource(this._httpcontext);

  @override
  Future<List<Comment>> FetchCommentByProductId(int productId) async {
    Response response =
        await _httpcontext.get('/comment/list?product_id=$productId');
    validateResponse(response);
    List<Comment> commets = [];
    if (response.data is List<dynamic>) {
      for (var element in (response.data as List<dynamic>)) {
        commets.add(Comment.fromJson(element));
      }
    }
    return commets;
  }
}
