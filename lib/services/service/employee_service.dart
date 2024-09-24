import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/salary_model.dart';
import 'package:e_tmsc_app/services/models/api_employee.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';
import 'package:e_tmsc_app/services/networking/api_service.dart';
import 'package:e_tmsc_app/services/networking/api_url.dart';

abstract class BaseEmployeeService {
  Future<GetListEmployeeResponse> getAllEmployee();

  Future<GetEmployeeResponse> getEmployeeDetails({required int id});

  Future<CheckInOutApiResponse> checkIn({required Map<String, dynamic> params});

  Future<CheckInOutApiResponse> checkOut(
      {required Map<String, dynamic> params});

  Future<GetListEmployeeResponse> getEmployeeOnline();

  Future<GetListEmployeeResponse> getEmployeeDayoff();

  Future<GetListSalaryResponse> getSalary();

  Future<GetSalaryResponse> getLastestSalary();

  Future<GetSalaryResponse> getSalaryByNotification(int? id);

  Future<GetListEmployeeResponse> getEmployeeBirthdayToday();

  Future<GetListEmployeeResponse> getEmployeeOnboardToday();
}

class EmployeeService implements BaseEmployeeService {
  final _apiService = ApiService();
  EmployeeService._();
  static final EmployeeService _instance = EmployeeService._();
  factory EmployeeService() => _instance;

  @override
  Future<GetListEmployeeResponse> getAllEmployee() async {
    final response = await _apiService.get(endpoint: ApiUrl.getEmployeeAll);
    return GetListEmployeeResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<EmployeeModel>.from(
                response.data['data'].map((e) => EmployeeModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<GetEmployeeResponse> getEmployeeDetails({required int id}) async {
    final response =
        await _apiService.get(endpoint: '${ApiUrl.getEmployeeDetail}/$id');
    return GetEmployeeResponse(
      status: ApiResponseStatus.fromMap(response.data),
      data: response.data['data'],
    );
  }

  @override
  Future<CheckInOutApiResponse> checkIn(
      {required Map<String, dynamic> params}) async {
    final response = await _apiService.post(
      endpoint: ApiUrl.checkIn,
      body: params,
    );
    return CheckInOutApiResponse(
      status: ApiResponseStatus.fromMap(response.data),
      data: response.data['data'],
    );
  }

  @override
  Future<CheckInOutApiResponse> checkOut(
      {required Map<String, dynamic> params}) async {
    final response = await _apiService.post(
      endpoint: ApiUrl.checkOut,
      body: params,
    );
    return CheckInOutApiResponse(
      status: ApiResponseStatus.fromMap(response.data),
      data: response.data['data'],
    );
  }

  @override
  Future<GetListEmployeeResponse> getEmployeeDayoff() async {
    final response = await _apiService.get(endpoint: ApiUrl.getEmployeeDayoff);
    return GetListEmployeeResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<EmployeeModel>.from(
                response.data['data'].map((e) => EmployeeModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<GetListEmployeeResponse> getEmployeeOnline() async {
    final response = await _apiService.get(endpoint: ApiUrl.getEmployeeOnline);
    return GetListEmployeeResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<EmployeeModel>.from(
                response.data['data'].map((e) => EmployeeModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<GetListSalaryResponse> getSalary() async {
    final response = await _apiService.get(endpoint: ApiUrl.getEmployeeSalary);
    return GetListSalaryResponse(
      status: ApiResponseStatus.fromMap(response.data),
      data: List<SalaryModel>.from(
        response.data['data'].map((e) => SalaryModel.fromMap(e)),
      ),
    );
  }

  @override
  Future<GetSalaryResponse> getLastestSalary() async {
    final response =
        await _apiService.get(endpoint: ApiUrl.getEmployeeLastSalary);
    return GetSalaryResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: SalaryModel.fromMap(response.data['data']));
  }

  @override
  Future<GetSalaryResponse> getSalaryByNotification(int? id) async {
    final response = await _apiService
        .get(endpoint: ApiUrl.getSalaryByNotification, body: {'id': id});
    return GetSalaryResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: SalaryModel.fromMap(response.data['data'][0]));
  }

  @override
  Future<GetListEmployeeResponse> getEmployeeBirthdayToday() async {
    final response =
        await _apiService.get(endpoint: ApiUrl.getEmployeeBirthdayToday);
    return GetListEmployeeResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<EmployeeModel>.from(
                response.data['data'].map((e) => EmployeeModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<GetListEmployeeResponse> getEmployeeOnboardToday() async {
    final response =
        await _apiService.get(endpoint: ApiUrl.getEmployeeOnboardToday);
    return GetListEmployeeResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<EmployeeModel>.from(
                response.data['data'].map((e) => EmployeeModel.fromMap(e)),
              )
            : []);
  }
}
