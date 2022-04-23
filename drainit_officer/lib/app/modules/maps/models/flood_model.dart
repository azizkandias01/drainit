class FloodModel {
  FloodModel({
    this.id,
    this.namaJalan,
    this.kondisiKerusakan,
    this.foto,
    this.keterangan,
    this.status,
    this.geometry,
  });

  FloodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    namaJalan = json['nama_jalan'].toString();
    kondisiKerusakan = json['kondisi_kerusakan'].toString();
    foto = json['foto'].toString();
    keterangan = json['keterangan'].toString();
    status = json['status'].toString();
    geometry = json['geometry'].toString();
  }
  String? id;
  String? namaJalan;
  String? kondisiKerusakan;
  String? foto;
  String? keterangan;
  dynamic status;
  String? geometry;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['nama_jalan'] = namaJalan;
    data['kondisi_kerusakan'] = kondisiKerusakan;
    data['foto'] = foto;
    data['keterangan'] = keterangan;
    data['status'] = status;
    data['geometry'] = geometry;
    return data;
  }
}
