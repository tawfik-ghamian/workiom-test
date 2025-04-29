class SignInRequestModel {
  final String email;
  final String password;
  final String tenantName;
  final String timeZone;

  SignInRequestModel({
    required this.email,
    required this.password,
    required this.tenantName,
    required this.timeZone,
  });

  static Map<String, dynamic> toJson(SignInRequestModel requestModel) => {
        "ianaTimeZone": requestModel.timeZone,
        "password": requestModel.password,
        "rememberClient": false,
        "returnUrl": null,
        "singleSignIn": false,
        "tenantName": requestModel.tenantName,
        "userNameOrEmailAddress": requestModel.email,
      };
}
