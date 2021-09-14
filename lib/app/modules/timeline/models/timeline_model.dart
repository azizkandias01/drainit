class TimelineModel {
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
  String? feedbackMasyarakat;
  String? createdAt;
  String? updatedAt;
  String? geometry;
  int? upvote;
  int? downvote;
  String? vote;

  TimelineModel({
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
    this.laporanPetugas,
    this.feedbackMasyarakat,
    this.createdAt,
    this.updatedAt,
    this.geometry,
    this.upvote,
    this.downvote,
    this.vote,
  });
  TimelineModel.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    idMasyarakat = json["id_masyarakat"]?.toString();
    namaPelapor = json["nama_pelapor"]?.toString();
    idAdmin = json["id_admin"]?.toString();
    namaAdmin = json["nama_admin"]?.toString();
    idPetugas = json["id_petugas"]?.toString();
    namaPetugas = json["nama_petugas"]?.toString();
    namaJalan = json["nama_jalan"]?.toString();
    foto = json["foto"]?.toString();
    tipePengaduan = json["tipe_pengaduan"]?.toString();
    deskripsiPengaduan = json["deskripsi_pengaduan"]?.toString();
    statusPengaduan = json["status_pengaduan"]?.toString();
    laporanPetugas = json["laporan_petugas"]?.toString();
    feedbackMasyarakat = json["feedback_masyarakat"]?.toString();
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
    geometry = json["geometry"]?.toString();
    upvote = json["upvote"]?.toInt();
    downvote = json["downvote"]?.toInt();
    vote = json["vote"]?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["id_masyarakat"] = idMasyarakat;
    data["nama_pelapor"] = namaPelapor;
    data["id_admin"] = idAdmin;
    data["nama_admin"] = namaAdmin;
    data["id_petugas"] = idPetugas;
    data["nama_petugas"] = namaPetugas;
    data["nama_jalan"] = namaJalan;
    data["foto"] = foto;
    data["tipe_pengaduan"] = tipePengaduan;
    data["deskripsi_pengaduan"] = deskripsiPengaduan;
    data["status_pengaduan"] = statusPengaduan;
    data["laporan_petugas"] = laporanPetugas;
    data["feedback_masyarakat"] = feedbackMasyarakat;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["geometry"] = geometry;
    data["upvote"] = upvote;
    data["downvote"] = downvote;
    data["vote"] = vote;
    return data;
  }
}

class TimelineModelAnonymouse {
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
  String? feedbackMasyarakat;
  String? createdAt;
  String? updatedAt;
  String? geometry;
  int? upvote;
  int? downvote;

  TimelineModelAnonymouse({
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
    this.laporanPetugas,
    this.feedbackMasyarakat,
    this.createdAt,
    this.updatedAt,
    this.geometry,
    this.upvote,
    this.downvote,
  });
  TimelineModelAnonymouse.fromJson(Map<String, dynamic> json) {
    id = json["id"]?.toString();
    idMasyarakat = json["id_masyarakat"]?.toString();
    namaPelapor = json["nama_pelapor"]?.toString();
    idAdmin = json["id_admin"]?.toString();
    namaAdmin = json["nama_admin"]?.toString();
    idPetugas = json["id_petugas"]?.toString();
    namaPetugas = json["nama_petugas"]?.toString();
    namaJalan = json["nama_jalan"]?.toString();
    foto = json["foto"]?.toString();
    tipePengaduan = json["tipe_pengaduan"]?.toString();
    deskripsiPengaduan = json["deskripsi_pengaduan"]?.toString();
    statusPengaduan = json["status_pengaduan"]?.toString();
    laporanPetugas = json["laporan_petugas"]?.toString();
    feedbackMasyarakat = json["feedback_masyarakat"]?.toString();
    createdAt = json["created_at"]?.toString();
    updatedAt = json["updated_at"]?.toString();
    geometry = json["geometry"]?.toString();
    upvote = json["upvote"]?.toInt();
    downvote = json["downvote"]?.toInt();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = id;
    data["id_masyarakat"] = idMasyarakat;
    data["nama_pelapor"] = namaPelapor;
    data["id_admin"] = idAdmin;
    data["nama_admin"] = namaAdmin;
    data["id_petugas"] = idPetugas;
    data["nama_petugas"] = namaPetugas;
    data["nama_jalan"] = namaJalan;
    data["foto"] = foto;
    data["tipe_pengaduan"] = tipePengaduan;
    data["deskripsi_pengaduan"] = deskripsiPengaduan;
    data["status_pengaduan"] = statusPengaduan;
    data["laporan_petugas"] = laporanPetugas;
    data["feedback_masyarakat"] = feedbackMasyarakat;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    data["geometry"] = geometry;
    data["upvote"] = upvote;
    data["downvote"] = downvote;
    return data;
  }
}
