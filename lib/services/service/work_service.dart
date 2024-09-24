import 'package:e_tmsc_app/data/models/room_model.dart';
import 'package:e_tmsc_app/data/models/task_model.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';
import 'package:e_tmsc_app/services/models/api_work.dart';
import 'package:e_tmsc_app/services/networking/api_service.dart';
import 'package:e_tmsc_app/services/networking/api_url.dart';
import 'package:e_tmsc_app/shared/enums/task_enum.dart';
import 'package:e_tmsc_app/shared/typedef.dart';

abstract class BaseWorkService {
  Future<CreateRoomResponse> createRoom(JSON data);

  Future<GetListRoomResponse> getRoomApproved(int page);

  Future<GetListRoomResponse> getRoomPending(int page);

  Future<CreateTaskResponse> createTask(JSON data);

  Future<GetListTaskResponse> getListTask(TaskStatus status);
}

class WorkService extends BaseWorkService {
  final _apiService = ApiService();
  WorkService._();
  static final WorkService _instance = WorkService._();
  factory WorkService() => _instance;

  @override
  Future<CreateRoomResponse> createRoom(JSON data) async {
    final response = await _apiService.post(
      endpoint: ApiUrl.createRoom,
      body: data,
    );
    return CreateRoomResponse(status: ApiResponseStatus.fromMap(response.data));
  }

  @override
  Future<GetListRoomResponse> getRoomApproved(int page) async {
    final response = await _apiService.get(
      endpoint: ApiUrl.getRoomApproved,
      body: {'page': page},
    );
    return GetListRoomResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<RoomModel>.from(
                response.data['data'].map((e) => RoomModel.fromMap(e['room'])),
              )
            : []);
  }

  @override
  Future<GetListRoomResponse> getRoomPending(int page) async {
    final response = await _apiService.get(
      endpoint: ApiUrl.getRoomPending,
      body: {'page': page},
    );
    return GetListRoomResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<RoomModel>.from(
                response.data['data'].map((e) => RoomModel.fromMap(e['room'])),
              )
            : []);
  }

  @override
  Future<CreateTaskResponse> createTask(JSON data) async {
    final response = await _apiService.post(
      endpoint: ApiUrl.createTask,
      body: data,
    );
    return CreateTaskResponse(
        status: ApiResponseStatus.fromMap(response.data), data: true);
  }

  @override
  Future<GetListTaskResponse> getListTask(TaskStatus status) async {
    final response = await _apiService.get(
      endpoint: ApiUrl.getListTask,
      body: {'status': status.parseId()},
    );
    return GetListTaskResponse(
        status: ApiResponseStatus.fromMap(response.data),
        data: response.data['data'] != null
            ? List<TaskModel>.from(
                response.data['data'].map((e) => TaskModel.fromMap(e['task'])),
              )
            : []);
  }
}
