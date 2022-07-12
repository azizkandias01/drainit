class UpdateProfileRequest {
  UpdateProfileRequest({
    this.id,
    this.nama,
    this.telepon,
    this.alamat,
    this.tanggalLahir,
  });

  UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    nama = json['nama'].toString();
    telepon = json['telepon'].toString();
    alamat = json['alamat'].toString();
    tanggalLahir = json['tanggal_lahir'].toString();
  }
  String? id;
  String? nama;
  String? telepon;
  String? alamat;
  String? tanggalLahir;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nama'] = nama;
    data['telepon'] = telepon;
    data['alamat'] = alamat;
    data['tanggal_lahir'] = tanggalLahir;
    return data;
  }
}
