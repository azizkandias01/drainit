class Report {
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
  String? laporanPetugas;
  dynamic feedbackMasyarakat;
  String? createdAt;
  String? updatedAt;
  String? geometry;
  int? upvote;
  int? downvote;

  Report(
      {this.id,
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
      this.laporanPetugas,
      this.feedbackMasyarakat,
      this.createdAt,
      this.updatedAt,
      this.geometry,
      this.upvote,
      this.downvote});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMasyarakat = json['id_masyarakat'];
    namaPelapor = json['nama_pelapor'];
    idAdmin = json['id_admin'];
    namaAdmin = json['nama_admin'];
    idPetugas = json['id_petugas'];
    namaPetugas = json['nama_petugas'];
    namaJalan = json['nama_jalan'];
    foto = json['foto'];
    tipePengaduan = json['tipe_pengaduan'];
    deskripsiPengaduan = json['deskripsi_pengaduan'];
    statusPengaduan = json['status_pengaduan'];
    laporanPetugas = json['laporan_petugas'];
    feedbackMasyarakat = json['feedback_masyarakat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    geometry = json['geometry'];
    upvote = json['upvote'];
    downvote = json['downvote'];
  }

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
    data['laporan_petugas'] = laporanPetugas;
    data['feedback_masyarakat'] = feedbackMasyarakat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['geometry'] = geometry;
    data['upvote'] = upvote;
    data['downvote'] = downvote;
    return data;
  }
}
