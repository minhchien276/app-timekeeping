import 'package:e_tmsc_app/data/models/test_model.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';
import 'package:e_tmsc_app/services/models/api_test.dart';
import 'package:e_tmsc_app/services/networking/api_service.dart';
import 'package:e_tmsc_app/services/networking/api_url.dart';
import 'package:e_tmsc_app/shared/typedef.dart';

abstract class BaseTestService {
  Future<GetEmployeeTestsResponse> getEmployeeTests();

  Future<GetEmployeeTestsResponse> getAdminTests();

  Future<SaveEmployeeTestResponse> saveEmployeeTest(JSON data);

  Future<GetEmployeeTestsResponse> getTestsScore(int testId);

  Future<BeginTestResponse> beginTest(int employeeTestId);

  Future<GetTestDetailResponse> getTestDetail(int employeeTestId);
}

class TestService extends BaseTestService {
  final _apiService = ApiService();
  TestService._();
  static final TestService _instance = TestService._();
  factory TestService() => _instance;

  @override
  Future<GetEmployeeTestsResponse> getEmployeeTests() async {
    final response = await _apiService.get(
      endpoint: ApiUrl.getEmployeeTests,
    );
    return GetEmployeeTestsResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<TestModel>.from(
                response.data['data'].map((e) => TestModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<GetEmployeeTestsResponse> getAdminTests() async {
    final response = await _apiService.get(
      endpoint: ApiUrl.getAllTests,
    );
    return GetEmployeeTestsResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<TestModel>.from(
                response.data['data'].map((e) => TestModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<SaveEmployeeTestResponse> saveEmployeeTest(JSON data) async {
    final response = await _apiService.post(
      endpoint: ApiUrl.saveEmployeeTest,
      body: data,
    );
    return SaveEmployeeTestResponse(
        status: ApiResponseStatus.fromMap(response.data));
  }

  @override
  Future<GetEmployeeTestsResponse> getTestsScore(int testId) async {
    final response = await _apiService.get(
      endpoint: '${ApiUrl.getTestsScore}/$testId',
    );
    return GetEmployeeTestsResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<TestModel>.from(
                response.data['data'].map((e) => TestModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<BeginTestResponse> beginTest(int employeeTestId) async {
    final response = await _apiService.patch(
      endpoint: '${ApiUrl.beginTest}/$employeeTestId',
    );
    return BeginTestResponse(status: ApiResponseStatus.fromMap(response.data));
  }

  @override
  Future<GetTestDetailResponse> getTestDetail(int employeeTestId) async {
    final response = await _apiService.get(
      endpoint: '${ApiUrl.getTestDetails}/$employeeTestId',
    );
    return GetTestDetailResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: TestModel.fromMap(response.data['data']));
  }
}
