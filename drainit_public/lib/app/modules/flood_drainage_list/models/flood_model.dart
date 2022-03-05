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
    id = json['id'] as String;
    namaJalan = json['nama_jalan'] as String;
    kondisiKerusakan = json['kondisi_kerusakan'] as String;
    foto = json['foto'] as String;
    keterangan = json['keterangan'] as String;
    status = json['status'];
    geometry = json['geometry'] as String;
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
