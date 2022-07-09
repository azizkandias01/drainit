class Profile {
  Profile({
    this.id,
    this.nama,
    this.foto,
    this.noHp,
    this.alamat,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  Profile.fromJson(Map<String, dynamic> json) {
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

class ProfileResponse {

  ProfileResponse({this.status, this.message, this.data});
  ProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] as int;
    message = json['message'].toString();
    data = json['data'] != null
        ? Data.fromJson(json['data'] as Map<String, dynamic>)
        : null;
  }
  int? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Data(
      {this.id,
      this.nama,
      this.email,
      this.telepon,
      this.alamat,
      this.tanggalLahir,
      this.foto,});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    nama = json['nama'].toString();
    email = json['email'].toString();
    telepon = json['telepon'].toString();
    alamat = json['alamat'].toString();
    tanggalLahir = json['tanggal_lahir'].toString();
    foto = json['foto'].toString();
  }
  String? id;
  String? nama;
  String? email;
  String? telepon;
  String? alamat;
  String? tanggalLahir;
  String? foto;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['email'] = email;
    data['telepon'] = telepon;
    data['alamat'] = alamat;
    data['tanggal_lahir'] = tanggalLahir;
    data['foto'] = foto;
    return data;
  }
}
