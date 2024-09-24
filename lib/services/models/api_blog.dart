import 'package:e_tmsc_app/data/models/blog_model.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';

class GetListBlogResponse extends ApiResponse<List<BlogModel>> {
  GetListBlogResponse({required super.status, required super.data});
}

class GetBlogResponse extends ApiResponse<BlogModel> {
  GetBlogResponse({required super.status, required super.data});
}
