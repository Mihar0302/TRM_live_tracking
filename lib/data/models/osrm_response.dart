import 'dart:convert';
import 'osrm_route_response.dart';
import 'osrm_waypoint_response.dart';

OsrmResponse osrmResponseFromJson(String str) => OsrmResponse.fromJson(json.decode(str));

String osrmResponseToJson(OsrmResponse data) => json.encode(data.toJson());

class OsrmResponse {
  final String code;
  final List<OsrmRouteResponse> routes;
  final List<OsrmWaypointResponse> waypoints;

  OsrmResponse({
    required this.code,
    required this.routes,
    required this.waypoints,
  });

  factory OsrmResponse.fromJson(Map<String, dynamic> json) => OsrmResponse(
        code: json["code"],
        routes: List<OsrmRouteResponse>.from(json["routes"].map((x) => OsrmRouteResponse.fromJson(x))),
        waypoints: List<OsrmWaypointResponse>.from(json["waypoints"].map((x) => OsrmWaypointResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toJson())),
      };
}
