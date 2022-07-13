class ProfileModel {
  int? status;
  String? message;
  Data? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

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
  String? id;
  String? nama;
  String? telepon;
  String? email;
  String? status;
  String? tanggalLahir;
  String? alamat;
  String? foto;

  Data(
      {this.id,
      this.nama,
      this.telepon,
      this.email,
      this.status,
      this.tanggalLahir,
      this.alamat,
      this.foto});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    telepon = json['telepon'];
    email = json['email'];
    status = json['status'];
    tanggalLahir = json['tanggal_lahir'];
    alamat = json['alamat'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['telepon'] = telepon;
    data['email'] = email;
    data['status'] = status;
    data['tanggal_lahir'] = tanggalLahir;
    data['alamat'] = alamat;
    data['foto'] = foto;
    return data;
  }
}
