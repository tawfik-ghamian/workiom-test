class EditionModel {
  final int editionId;
  final String displayName;
  final bool isRegistrable;
  final double annualPrice;
  final bool hasTrial;
  final bool isMostPopular;

  EditionModel({
    required this.editionId,
    required this.annualPrice,
    required this.displayName,
    required this.hasTrial,
    required this.isMostPopular,
    required this.isRegistrable,
  });

  static List<EditionModel> fromList(List list) =>
      list.map((e) => EditionModel.fromJson(e)).toList();

  factory EditionModel.fromJson(Map<String, dynamic> json) => EditionModel(
        editionId: json["edition"] == null ? -1 : json["edition"]["id"] ?? -1,
        displayName:
            json["edition"] == null ? "" : json["edition"]["displayName"] ?? "",
        isRegistrable: json["edition"] == null
            ? false
            : json["edition"]["isRegistrable"] ?? false,
        annualPrice: json["edition"] == null
            ? 0.0
            : json['edition']["annualPrice"] ?? 0.0,
        hasTrial: json["edition"] == null
            ? false
            : json['edition']["hasTrial"] ?? false,
        isMostPopular: json["isMostPopular"] ?? false,
      );
}
