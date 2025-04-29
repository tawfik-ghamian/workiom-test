class SignUpRequestModel {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final int editionId;
  final String tenantName;
  final String name;

  SignUpRequestModel({
    required this.name,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.editionId,
    required this.tenantName,
  });

  static Map<String, dynamic> toJson(SignUpRequestModel requestModel) => {
        "adminEmailAddress": requestModel.email,
        "adminFirstName": requestModel.firstName,
        "adminLastName": requestModel.lastName,
        "adminPassword": requestModel.password,
        "captchaResponse": null,
        "editionId": requestModel.editionId,
        "name": requestModel.tenantName,
        "tenancyName": requestModel.tenantName,
      };
}
