import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.isActive,
    this.message,
    this.data,
  });

  bool isActive;
  String message;
  Data data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        isActive: json["is_active"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
  Map<String, dynamic> toJson() => {
        "is_active": isActive,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.iduser,
    this.nama,
    this.profesi,
    this.email,
    this.password,
    this.roleId,
    this.isActive,
    this.tanggalInput,
    this.modified,
  });

  String iduser;
  String nama;
  String profesi;
  String email;
  String password;
  String roleId;
  String isActive;
  DateTime tanggalInput;
  String modified;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        iduser: json["iduser"].toString(),
        nama: json["nama"],
        profesi: json["profesi"],
        email: json["email"],
        password: json["password"],
        roleId: json["role_id"].toString(),
        isActive: json["is_active"].toString(),
        tanggalInput: DateTime.parse(json["tanggal_input"]),
        modified: json["modified"],
      );

  Map<String, dynamic> toJson() => {
        "iduser": iduser.toString(),
        "nama": nama,
        "profesi": profesi,
        "email": email,
        "password": password,
        "role_id": roleId.toString(),
        "is_active": isActive.toString(),
        "tanggal_input":
            "${tanggalInput.year.toString().padLeft(4, '0')}- ${tanggalInput.month.toString().padLeft(2, '0')}- ${tanggalInput.day.toString().padLeft(2, '0')}",
        "modified": modified,
      };
}
