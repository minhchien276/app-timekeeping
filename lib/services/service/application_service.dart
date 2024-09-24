import 'package:e_tmsc_app/data/models/application_model.dart';
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/services/models/api_application.dart';
import 'package:e_tmsc_app/services/models/api_employee.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';
import 'package:e_tmsc_app/services/networking/api_service.dart';
import 'package:e_tmsc_app/services/networking/api_url.dart';
import 'package:e_tmsc_app/shared/typedef.dart';
import 'package:e_tmsc_app/utils/shared_prefs.dart';

import '../../data/models/reason.dart';

abstract class BaseApplicationService {
  Future<SubmitApplicationApiResponse> createApplication({required JSON parms});

  Future<GetListEmployeeResponse> getReceiver();

  Future<GetListApplicationResponse> getApplicationById(int page);

  Future<GetListApplicationResponse> getPeopleApplication(int page);

  Future<GetListApplicationResponse> getApproveApplication(int page);

  Future<GetListApplicationResponse> getPendingApplication(int page);

  Future<UpdateApplicationResponse> updateStatus(Map<String, dynamic> parms);

  Future<GetApplicationResponse> getApplicationDetail(int id);
}

class ApplicationService implements BaseApplicationService {
  final _apiService = ApiService();
  ApplicationService._();
  static final ApplicationService _instance = ApplicationService._();
  factory ApplicationService() => _instance;

  final _prefs = SharedPrefs();

  @override
  Future<SubmitApplicationApiResponse> createApplication(
      {required JSON parms}) async {
    final response = await _apiService.post(
      endpoint: ApiUrl.createApplication,
      body: parms,
    );
    return SubmitApplicationApiResponse(
      status: ApiResponseStatus.fromMap(response.data),
    );
  }

  @override
  Future<GetListEmployeeResponse> getReceiver() async {
    final response =
        await _apiService.get(endpoint: '${ApiUrl.getReceiver}/${_prefs.id}');
    return GetListEmployeeResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<EmployeeModel>.from(
                response.data['data'].map((e) => EmployeeModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<GetListApplicationResponse> getApplicationById(int page) async {
    final response = await _apiService.get(
      endpoint: ApiUrl.getApplicationById,
      body: {'page': page},
    );
    return GetListApplicationResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<ApplicationModel>.from(
                response.data['data'].map((e) => ApplicationModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<GetListApplicationResponse> getPeopleApplication(int page) async {
    final response = await _apiService.get(
      endpoint: ApiUrl.getPeopleApplication,
      body: {'page': page},
    );
    return GetListApplicationResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<ApplicationModel>.from(
                response.data['data'].map((e) => ApplicationModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<UpdateApplicationResponse> updateStatus(
      Map<String, dynamic> parms) async {
    final response = await _apiService.patch(
        endpoint: ApiUrl.applicationUpdateStatus, body: parms);
    return UpdateApplicationResponse(
      status: ApiResponseStatus.fromMap(response.data),
    );
  }

  @override
  Future<GetApplicationResponse> getApplicationDetail(int id) async {
    final response =
        await _apiService.get(endpoint: '${ApiUrl.getApplicationDetail}/$id');
    return GetApplicationResponse(
      status: ApiResponseStatus.fromMap(response.data),
      data: ApplicationModel.fromMap(response.data['data']),
    );
  }

  @override
  Future<GetListApplicationResponse> getApproveApplication(int page) async {
    final response = await _apiService.get(
      endpoint: ApiUrl.getApproveApplication,
      body: {'page': page},
    );
    return GetListApplicationResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<ApplicationModel>.from(
                response.data['data'].map((e) => ApplicationModel.fromMap(e)),
              )
            : []);
  }

  @override
  Future<GetListApplicationResponse> getPendingApplication(int page) async {
    final response = await _apiService.get(
      endpoint: ApiUrl.getPendingApplication,
      body: {'page': page},
    );
    return GetListApplicationResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<ApplicationModel>.from(
                response.data['data'].map((e) => ApplicationModel.fromMap(e)),
              )
            : []);
  }

  Future<List<Reason>> getListReason() async {
    List<Reason> listReason = [
      Reason(
          title: "Công việc cá nhân",
          subTitle: "Giải quyết công việc cá nhân",
          isChecked: false),
      Reason(
          title: "Công việc gia đình",
          subTitle: "Giải quyết công việc gia đình",
          isChecked: false),
      Reason(
          title: "Lí do khác",
          subTitle: "Bị ốm, nhà có đám hỏi, nhà có đám hiếu,...",
          isChecked: false),
      Reason(title: "Đi sự kiện", subTitle: "Đi sự kiện", isChecked: false),
      Reason(title: "Đi công tác", subTitle: "Đi công tác", isChecked: false),
      Reason(
          title: "Hoàn thành công việc",
          subTitle: "Hoàn thành công việc",
          isChecked: false),
    ];
    return listReason;
  }
}
