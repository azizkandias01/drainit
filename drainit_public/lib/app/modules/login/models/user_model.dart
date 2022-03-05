class LoginReponse {
  String? message;
  User? user;
  String? accessToken;
  int? statusCode;

  LoginReponse({this.message, this.user, this.accessToken, this.statusCode});

  LoginReponse.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    user = json['user'] != null
        ? User?.fromJson(json['user'] as Map<String, dynamic>)
        : null;
    accessToken = json['access_token'].toString();
    statusCode = json['status_code'] as int;
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
  User({
    this.id,
    this.nama,
    this.foto,
    this.noHp,
    this.alamat,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    nama = json['nama'] as String;
    foto = json['foto'] as String;
    noHp = json['no_hp'] as String;
    alamat = json['alamat'] as String;
    email = json['email'] as String;
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
  }
  String? id;
  String? nama;
  String? foto;
  String? noHp;
  String? alamat;
  String? email;
  String? createdAt;
  String? updatedAt;

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
