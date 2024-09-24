class PermissionException implements Exception {
  final String message;

  PermissionException(this.message);

  @override
  String toString() => message;
}

class LocationDeniedException extends PermissionException {
  LocationDeniedException(super.message);
}

class CameraDeniedException extends PermissionException {
  CameraDeniedException(super.message);
}
