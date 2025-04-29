import 'dart:ui';

class ApiConstant {
  static const baseUrl = "https://api.workiom.club";
  static const String signInUrl = '/api/TokenAuth/Authenticate';
  static const String registerTenant =
      '/api/services/app/TenantRegistration/RegisterTenant';
  static const String checkTenantAvailable =
      '/api/services/app/Account/IsTenantAvailable';
  static const String passwordComplexity =
      '/api/services/app/Profile/GetPasswordComplexitySetting';
  static const String getEditions =
      '/api/services/app/TenantRegistration/GetEditionsForSelect';
  static const String checkAuth =
      '/api/services/app/Session/GetCurrentLoginInformations';
}

class ColorConstant {
  static const subtitleTextColor = Color(0xFF555555);
}
