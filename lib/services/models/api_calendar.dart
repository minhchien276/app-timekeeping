import 'package:e_tmsc_app/data/models/overtime_model.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';

class GetOvertimeResponse extends ApiResponse<List<OvertimeModel>> {
  GetOvertimeResponse({required super.status, required super.data});
}
