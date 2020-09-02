class Error {
  int code;
  String message;
  String details;
  String validationErrors;

  Error(this.message, {this.code, this.details});

  Error.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    code = json['code'];
    message = json['message'];
    details = json['details'];
    validationErrors = json['validationErrors'];
  }

  @override
  String toString() {
    return 'Error {code: $code, message: $message, details: $details, validationError: $validationErrors';
  }
}

class ApiError {
  Error error;

  ApiError(this.error);

  ApiError.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    error = Error.fromJson(json['error']);
  }
}
