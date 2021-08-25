class LoginReponse {
  String? message;
  LoginReponse? user;
  String? accessToken;
  int? statusCode;

  LoginReponse({this.message, this.user, this.accessToken, this.statusCode});

  LoginReponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? LoginReponse?.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['access_token'] = accessToken;
    data['status_code'] = statusCode;
    return data;
  }
}

class User {
  String? id;
  String? nama;
  String? foto;
  String? noHp;
  String? alamat;
  String? email;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.nama,
      this.foto,
      this.noHp,
      this.alamat,
      this.email,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    foto = json['foto'];
    noHp = json['no_hp'];
    alamat = json['alamat'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['foto'] = foto;
    data['no_hp'] = noHp;
    data['alamat'] = alamat;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
