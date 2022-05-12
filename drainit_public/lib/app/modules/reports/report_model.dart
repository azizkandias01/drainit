class Report {
  String? message;
  Data? data;
  int? statusCode;

  Report({this.message, this.data, this.statusCode});

  Report.fromJson(Map<String, dynamic> json) {
    message = json['message'].toString();
    data = json['data'] != null
        ? Data?.fromJson(json['data'] as Map<String, dynamic>)
        : null;
    statusCode = json['status_code'] as int;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    if (data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status_code'] = statusCode;
    return data;
  }
}

class Data {
  String? namaJalan;
  String? foto;
  String? deskripsiPengaduan;
  String? geometry;
  String? idMasyarakat;
  String? tipePengaduan;
  String? statusPengaduan;
  String? id;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.namaJalan,
      this.foto,
      this.deskripsiPengaduan,
      this.geometry,
      this.idMasyarakat,
      this.tipePengaduan,
      this.statusPengaduan,
      this.id,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    namaJalan = json['nama_jalan'].toString();
    foto = json['foto'].toString();
    deskripsiPengaduan = json['deskripsi_pengaduan'].toString();
    geometry = json['geometry'].toString();
    idMasyarakat = json['id_masyarakat'].toString();
    tipePengaduan = json['tipe_pengaduan'].toString();
    statusPengaduan = json['status_pengaduan'].toString();
    id = json['id'].toString();
    updatedAt = json['updated_at'].toString();
    createdAt = json['created_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nama_jalan'] = namaJalan;
    data['foto'] = foto;
    data['deskripsi_pengaduan'] = deskripsiPengaduan;
    data['geometry'] = geometry;
    data['id_masyarakat'] = idMasyarakat;
    data['tipe_pengaduan'] = tipePengaduan;
    data['status_pengaduan'] = statusPengaduan;
    data['id'] = id;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
