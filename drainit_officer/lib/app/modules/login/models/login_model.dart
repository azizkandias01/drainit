class Login {
  String? message;
  User? user;
  String? accessToken;
  int? statusCode;

  Login({this.message, this.user, this.accessToken, this.statusCode});

  Login.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? User?.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user?.toJson();
    }
    data['access_token'] = accessToken;
    data['status_code'] = statusCode;
    return data;
  }
}

class User {
  String? id;
  String? email;
  dynamic emailVerifiedAt;
  String? nama;
  String? foto;
  String? posisiPetugas;
  String? tempatLahir;
  String? tglLahir;
  String? alamat;
  String? noHp;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.email,
      this.emailVerifiedAt,
      this.nama,
      this.foto,
      this.posisiPetugas,
      this.tempatLahir,
      this.tglLahir,
      this.alamat,
      this.noHp,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    nama = json['nama'];
    foto = json['foto'];
    posisiPetugas = json['posisi_petugas'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = json['tgl_lahir'];
    alamat = json['alamat'];
    noHp = json['no_hp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['nama'] = nama;
    data['foto'] = foto;
    data['posisi_petugas'] = posisiPetugas;
    data['tempat_lahir'] = tempatLahir;
    data['tgl_lahir'] = tglLahir;
    data['alamat'] = alamat;
    data['no_hp'] = noHp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
