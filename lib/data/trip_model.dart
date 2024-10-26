class TripModel {
  List<Data> data;

  StatusCount? statusCount;

  TripModel({
    required this.data,
    required this.statusCount,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
      data: json["trips"] != null && json["trips"] != []
          ? (json["trips"] as List).map((e) => Data.fromJson(e)).toList()
          : [],
      statusCount: json["status_counts"] != null
          ? StatusCount.fromJson(json["status_counts"])
          : null);
}

class Data {
  final String date;
  final String registrationNo;
  final String VUserName;
  final String status;
  final List orderList;

  Data({
    required this.date,
    required this.registrationNo,
    required this.orderList,
    required this.status,
    required this.VUserName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      date: json["date"] ?? "",
      registrationNo: json["v_registration_no"] ?? "",
      orderList: json["orders"] ?? [],
      VUserName: json["v_api_username"] ?? "",
      status: json["status"] ?? "");
}

class StatusCount {
  final int assigned;
  final int enroute;
  final int arrived;
  final int completed;
  final int completedLate;
  final int failed;

  StatusCount({
    required this.assigned,
    required this.enroute,
    required this.arrived,
    required this.completed,
    required this.completedLate,
    required this.failed,
  });

  factory StatusCount.fromJson(Map json) => StatusCount(
        assigned: json["assigned"] ?? 0,
        enroute: json["enroute"] ?? 0,
        arrived: json["arrived"] ?? 0,
        completed: json["completed"] ?? 0,
        completedLate: json["completedLate"] ?? 0,
        failed: json["failed"] ?? 0,
      );
}
