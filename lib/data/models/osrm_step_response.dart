class OsrmStepResponse {
  final String? geometry;

  OsrmStepResponse({
    this.geometry,
  });

  factory OsrmStepResponse.fromJson(Map<String, dynamic> json) => OsrmStepResponse(
        geometry: json["geometry"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry,
      };
}
