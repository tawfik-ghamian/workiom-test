enum ApiErrorType {
  network,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  internalServer,
  cancelled,
  unexpected,
  custom,
}

class ApiError implements Exception {
  final ApiErrorType type;
  final String message;

  ApiError(this.type, this.message);
}
