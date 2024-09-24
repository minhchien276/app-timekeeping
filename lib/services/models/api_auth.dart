import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';

class LoginResponse extends ApiResponse<EmployeeModel> {
  LoginResponse({required super.status, required super.data});
}
