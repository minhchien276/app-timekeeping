import 'package:e_tmsc_app/data/models/application_model.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';

class SubmitApplicationApiResponse extends ApiResponse<bool> {
  SubmitApplicationApiResponse({required super.status, super.data = true});
}

class GetListApplicationResponse extends ApiResponse<List<ApplicationModel>> {
  GetListApplicationResponse({required super.status, required super.data});
}

class GetApplicationResponse extends ApiResponse<ApplicationModel> {
  GetApplicationResponse({required super.status, required super.data});
}

class UpdateApplicationResponse extends ApiResponse<bool> {
  UpdateApplicationResponse({required super.status, super.data = true});
}
