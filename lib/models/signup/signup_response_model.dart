class SignUpResponseModel {
  final int tenantId;
  SignUpResponseModel({
    required this.tenantId,
  });
  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      SignUpResponseModel(tenantId: json["tenantId"] ?? -1);
}
