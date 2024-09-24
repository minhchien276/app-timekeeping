class ApiResponseStatus {
  final bool status;
  final String message;
  ApiResponseStatus({
    required this.status,
    required this.message,
  });

  factory ApiResponseStatus.fromMap(Map<String, dynamic> map) {
    return ApiResponseStatus(
      status: map['status'] ?? false,
      message: map['message'] ?? '',
    );
  }

  String get responseMessage => message;
}

class ApiResponse<T> {
  final ApiResponseStatus status;
  final T data;
  ApiResponse({
    required this.status,
    required this.data,
  });

  bool get isOk => status.status;
}
