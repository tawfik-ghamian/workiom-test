class CurrentSignInInfo {
  final String user;
  final String tenant;

  CurrentSignInInfo({
    required this.user,
    required this.tenant,
  });

  factory CurrentSignInInfo.fromJson(Map<String, dynamic> json) =>
      CurrentSignInInfo(
        user: json["user"] != null ? json["user"]["name"] : "",
        tenant: json["tenant"] != null ? json["tenant"]["tenancyName"] : "",
      );
}
