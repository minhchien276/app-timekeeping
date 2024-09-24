import 'package:e_tmsc_app/data/models/overtime_model.dart';
import 'package:e_tmsc_app/services/models/api_calendar.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';
import 'package:e_tmsc_app/services/networking/api_service.dart';
import 'package:e_tmsc_app/services/networking/api_url.dart';

abstract class BaseCalendarService {
  Future getCalendar({required int id});

  Future<GetOvertimeResponse> getOvertime();
}

class CalendarService implements BaseCalendarService {
  final _apiService = ApiService();
  CalendarService._();
  static final CalendarService _instance = CalendarService._();
  factory CalendarService() => _instance;

  @override
  Future getCalendar({required int id}) async {
    final response =
        await _apiService.get(endpoint: ApiUrl.getCalender, body: {"id": id});
    return response.data;
  }

  @override
  Future<GetOvertimeResponse> getOvertime() async {
    final response = await _apiService.get(endpoint: ApiUrl.getOvertime);
    return GetOvertimeResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<OvertimeModel>.from(
                response.data['data'].map((e) => OvertimeModel.fromMap(e)),
              )
            : []);
  }
}
