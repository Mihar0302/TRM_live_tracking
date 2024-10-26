class CustomModel {
  final List data;
  StatusCount? statusCount;

  CustomModel({
    required this.data,
    required this.statusCount,

  });

  factory CustomModel.fromJson(Map json) => CustomModel(
      data: json["data"] ?? [],
      statusCount: json["status_counts"] != null
          ? StatusCount.fromJson(json["status_counts"])
          : null);
}

class LoginModel {
  final String token;
  UserData? userData;

  LoginModel({required this.token, required this.userData});

  factory LoginModel.fromJson(Map json) => LoginModel(
      token: json["token"],
      userData: json["user"] != null ? UserData.fromJson(json["user"]) : null);
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

class UserData {
  final String id;
  final String name;
  final String mobile;
  final String address;
  final String age;
  final String licenseNo;
  final String licenseExpdate;
  final String totalExp;
  final String doj;
  final String ref;
  final String is_active;
  final String file;
  final String file1;

  UserData(
      {required this.id,
      required this.name,
      required this.mobile,
      required this.address,
      required this.age,
      required this.licenseNo,
      required this.licenseExpdate,
      required this.totalExp,
      required this.doj,
      required this.ref,
      required this.is_active,
      required this.file,
      required this.file1});

  factory UserData.fromJson(Map json) => UserData(
      id: json["d_id"] ?? "",
      name: json["d_name"] ?? "",
      mobile: json["d_mobile"] ?? "",
      address: json["d_address"] ?? "",
      age: json["d_age"] ?? "",
      licenseNo: json["d_licenseno"] ?? "",
      licenseExpdate: json["d_license_expdate"] ?? "",
      totalExp: json["d_total_exp"] ?? "",
      doj: json["d_doj"] ?? "",
      ref: json["d_ref"] ?? "",
      is_active: json["d_is_active"] ?? "",
      file: json["d_file"] ?? "",
      file1: json["d_file1"] ?? "");
}


