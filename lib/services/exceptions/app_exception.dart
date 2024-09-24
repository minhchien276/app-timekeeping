class AppException implements Exception {
  final int code;
  final String message;

  AppException(this.code, this.message);

  @override
  String toString() => message;
}

class BadRequestException extends AppException {
  BadRequestException(super.code, super.message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.code, super.message);
}

class ForbiddenException extends AppException {
  ForbiddenException(super.code, super.message);
}

class NotFoundException extends AppException {
  NotFoundException(super.code, super.message);
}

class ServerErrorException extends AppException {
  ServerErrorException(super.code, super.message);
}

class ConnectionErrorException extends AppException {
  ConnectionErrorException(super.code, super.message);
}

class UnknownException extends AppException {
  UnknownException(super.code, super.message);
}
