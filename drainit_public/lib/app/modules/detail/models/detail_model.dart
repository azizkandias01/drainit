class Detail {

  Detail({
    this.id,
    this.idMasyarakat,
    this.namaPelapor,
    this.idAdmin,
    this.namaAdmin,
    this.idPetugas,
    this.namaPetugas,
    this.namaJalan,
    this.foto,
    this.tipePengaduan,
    this.deskripsiPengaduan,
    this.statusPengaduan,
    this.feedbackMasyarakat,
    this.createdAt,
    this.updatedAt,
    this.geometry,
  });

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    idMasyarakat = json['id_masyarakat'].toString();
    namaPelapor = json['nama_pelapor'].toString();
    idAdmin = json['id_admin'].toString();
    namaAdmin = json['nama_admin'].toString();
    idPetugas = json['id_petugas'].toString();
    namaPetugas = json['nama_petugas'].toString();
    namaJalan = json['nama_jalan'].toString();
    foto = json['foto'].toString();
    tipePengaduan = json['tipe_pengaduan'].toString();
    deskripsiPengaduan = json['deskripsi_pengaduan'].toString();
    statusPengaduan = json['status_pengaduan'].toString();
    feedbackMasyarakat = json['feedback_masyarakat'];
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    geometry = json['geometry'].toString();
  }
  String? id;
  String? idMasyarakat;
  String? namaPelapor;
  String? idAdmin;
  String? namaAdmin;
  String? idPetugas;
  String? namaPetugas;
  String? namaJalan;
  String? foto;
  String? tipePengaduan;
  String? deskripsiPengaduan;
  String? statusPengaduan;
  dynamic feedbackMasyarakat;
  String? createdAt;
  String? updatedAt;
  String? geometry;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_masyarakat'] = idMasyarakat;
    data['nama_pelapor'] = namaPelapor;
    data['id_admin'] = idAdmin;
    data['nama_admin'] = namaAdmin;
    data['id_petugas'] = idPetugas;
    data['nama_petugas'] = namaPetugas;
    data['nama_jalan'] = namaJalan;
    data['foto'] = foto;
    data['tipe_pengaduan'] = tipePengaduan;
    data['deskripsi_pengaduan'] = deskripsiPengaduan;
    data['status_pengaduan'] = statusPengaduan;
    data['feedback_masyarakat'] = feedbackMasyarakat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['geometry'] = geometry;
    return data;
  }
}
