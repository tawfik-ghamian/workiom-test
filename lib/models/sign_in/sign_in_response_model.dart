class SignInResponseModel {
  final String accessToken;
  SignInResponseModel({
    required this.accessToken,
  });
  factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      SignInResponseModel(accessToken: json["accessToken"] ?? "");
}
