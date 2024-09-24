import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/salary_model.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';

class CheckInOutApiResponse extends ApiResponse<dynamic> {
  CheckInOutApiResponse({required super.status, required super.data});
}

class GetListEmployeeResponse extends ApiResponse<List<EmployeeModel>> {
  GetListEmployeeResponse({required super.status, required super.data});
}

class GetEmployeeResponse extends ApiResponse<dynamic> {
  GetEmployeeResponse({required super.status, required super.data});
}

class GetListSalaryResponse extends ApiResponse<List<SalaryModel>> {
  GetListSalaryResponse({required super.status, required super.data});
}

class GetSalaryResponse extends ApiResponse<SalaryModel> {
  GetSalaryResponse({required super.status, required super.data});
}
