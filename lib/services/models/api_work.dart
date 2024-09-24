import 'package:e_tmsc_app/data/models/room_model.dart';
import 'package:e_tmsc_app/data/models/task_model.dart';
import 'package:e_tmsc_app/services/models/api_response.dart';

class CreateRoomResponse extends ApiResponse<bool> {
  CreateRoomResponse({required super.status, super.data = true});
}

class GetListRoomResponse extends ApiResponse<List<RoomModel>> {
  GetListRoomResponse({required super.status, required super.data});
}

class GetListTaskResponse extends ApiResponse<List<TaskModel>> {
  GetListTaskResponse({required super.status, required super.data});
}

class CreateTaskResponse extends ApiResponse<bool> {
  CreateTaskResponse({required super.status, super.data = true});
}
