import 'package:e_tmsc_app/data/models/blog_model.dart';
import 'package:e_tmsc_app/services/models/api_blog.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';
import 'package:e_tmsc_app/services/networking/api_service.dart';
import 'package:e_tmsc_app/services/networking/api_url.dart';

abstract class BaseBlogService {
  Future<GetListBlogResponse> getAllBlog();

  Future<GetBlogResponse> getBlogDetail(int id);
}

class BlogService implements BaseBlogService {
  final _apiService = ApiService();
  BlogService._();
  static final BlogService _instance = BlogService._();
  factory BlogService() => _instance;

  @override
  Future<GetListBlogResponse> getAllBlog() async {
    final response = await _apiService.get(endpoint: ApiUrl.getAllBlog);
    return GetListBlogResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<BlogModel>.from(
                response.data['data'].map((e) => BlogModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<GetBlogResponse> getBlogDetail(int id) async {
    final response =
        await _apiService.get(endpoint: '${ApiUrl.getBlogDetail}/$id');
    return GetBlogResponse(
      status: ApiResponseStatus.fromMap(response.data),
      data: BlogModel.fromMap(response.data['data']),
    );
  }
}
