class RequestTokenModel {
  final bool success;
  final String? expiresAt;
  final String? requestToken;

  RequestTokenModel({this.success = false, this.expiresAt, this.requestToken});

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
        success: json['success'],
        expiresAt: json['expires_at'],
        requestToken: json['request_token']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_token'] = requestToken;
    return data;
  }

  @override
  String toString() {
    return 'RequestTokenModel{success: $success, expiresAt: $expiresAt, requestToken: $requestToken}';
  }
}
