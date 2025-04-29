class PassCompSettingsModel {
  final bool requiredDigit;
  final bool requiredLowercase;
  final bool requiredNonAlphanumeric;
  final bool requiredUppercase;
  final int requiredLength;

  PassCompSettingsModel({
    required this.requiredDigit,
    required this.requiredLength,
    required this.requiredLowercase,
    required this.requiredNonAlphanumeric,
    required this.requiredUppercase,
  });

  factory PassCompSettingsModel.fromJson(Map<String, dynamic> json) =>
      PassCompSettingsModel(
        requiredUppercase: json["requireUppercase"] ?? false,
        requiredNonAlphanumeric: json["requireNonAlphanumeric"] ?? false,
        requiredLowercase: json["requireLowercase"] ?? false,
        requiredLength: json["requiredLength"] ?? 0,
        requiredDigit: json["requireDigit"] ?? false,
      );
}
