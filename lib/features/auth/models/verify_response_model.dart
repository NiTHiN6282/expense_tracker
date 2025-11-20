enum VerifyStatus {
  success,
  error;

  static VerifyStatus fromString(String value) {
    switch (value) {
      case 'success':
        return VerifyStatus.success;
      case 'error':
      default:
        return VerifyStatus.error;
    }
  }

  String toValue() {
    switch (this) {
      case VerifyStatus.success:
        return 'success';
      case VerifyStatus.error:
        return 'error';
    }
  }
}

class VerifyResponse {
  final VerifyStatus status;
  final VerifyData? data;
  final String? message;
  final VerifyErrors? errors;

  VerifyResponse({required this.status, this.data, this.message, this.errors});

  factory VerifyResponse.fromJson(Map<String, dynamic> json) {
    return VerifyResponse(
      status: VerifyStatus.fromString(json['status']),
      data: json['data'] != null ? VerifyData.fromJson(json['data']) : null,
      message: json['message'],
      errors: json['errors'] != null
          ? VerifyErrors.fromJson(json['errors'])
          : null,
    );
  }

  bool get isSuccess => status == VerifyStatus.success;
  bool get isError => status == VerifyStatus.error;
}

class VerifyData {
  final int userId;
  final String name;
  final String accessToken;
  final String refreshToken;
  final String message;

  VerifyData({
    required this.userId,
    required this.name,
    required this.accessToken,
    required this.refreshToken,
    required this.message,
  });

  factory VerifyData.fromJson(Map<String, dynamic> json) {
    return VerifyData(
      userId: json['user_id'],
      name: json['name'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      message: json['message'],
    );
  }
}

class VerifyErrors {
  final List email;

  VerifyErrors({required this.email});

  factory VerifyErrors.fromJson(Map<String, dynamic> json) {
    return VerifyErrors(email: List.from(json['email']));
  }
}
