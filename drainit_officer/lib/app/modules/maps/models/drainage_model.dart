class Drainage {
  Drainage({
    this.id,
    this.namaJalan,
    this.keterangan,
    this.kondisiKerusakan,
    this.status,
    this.foto,
    this.geometry,
  });

  Drainage.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    namaJalan = json['nama_jalan'].toString();
    keterangan = json['keterangan'].toString();
    kondisiKerusakan = json['kondisi_kerusakan'].toString();
    status = json['status'].toString();
    foto = json['foto'].toString();
    geometry = json['geometry'].toString();
  }

  String? id;
  String? namaJalan;
  String? keterangan;
  String? kondisiKerusakan;
  String? status;
  String? foto;
  String? geometry;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama_jalan'] = namaJalan;
    data['keterangan'] = keterangan;
    data['kondisi_kerusakan'] = kondisiKerusakan;
    data['status'] = status;
    data['foto'] = foto;
    data['geometry'] = geometry;
    return data;
  }
}
