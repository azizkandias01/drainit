class addDeviceResponse {
  String? message;
  Data? data;
  int? statusCode;

  addDeviceResponse({this.message, this.data, this.statusCode});

  addDeviceResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Data {
  int? id;
  String? idUser;
  String? role;
  String? registrationId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.idUser,
      this.role,
      this.registrationId,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    role = json['role'];
    registrationId = json['registration_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['role'] = this.role;
    data['registration_id'] = this.registrationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
