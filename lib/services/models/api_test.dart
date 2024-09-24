import 'package:e_tmsc_app/data/models/test_model.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';

class GetEmployeeTestsResponse extends ApiResponse<List<TestModel>> {
  GetEmployeeTestsResponse({required super.status, required super.data});
}

class SaveEmployeeTestResponse extends ApiResponse<bool> {
  SaveEmployeeTestResponse({required super.status, super.data = true});
}

class BeginTestResponse extends ApiResponse<bool> {
  BeginTestResponse({required super.status, super.data = true});
}

class GetTestDetailResponse extends ApiResponse<TestModel> {
  GetTestDetailResponse({required super.status, required super.data});
}
