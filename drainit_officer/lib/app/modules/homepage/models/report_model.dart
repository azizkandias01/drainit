class ReportModel {
  String? id;
  String? idMasyarakat;
  String? namaPelapor;
  String? namaJalan;
  String? foto;
  String? tipe;
  String? deskripsi;
  String? status;
  String? feedbackMasyarakat;
  String? createdAt;
  String? updatedAt;
  String? geometry;
  int? upvote;
  int? downvote;

  ReportModel(
      {this.id,
      this.idMasyarakat,
      this.namaPelapor,
      this.namaJalan,
      this.foto,
      this.tipe,
      this.deskripsi,
      this.status,
      this.feedbackMasyarakat,
      this.createdAt,
      this.updatedAt,
      this.geometry,
      this.upvote,
      this.downvote});

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMasyarakat = json['id_masyarakat'];
    namaPelapor = json['nama_pelapor'];
    namaJalan = json['nama_jalan'];
    foto = json['foto'];
    tipe = json['tipe'];
    deskripsi = json['deskripsi'];
    status = json['status'];
    feedbackMasyarakat = json['feedback_masyarakat'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    geometry = json['geometry'];
    upvote = json['upvote'];
    downvote = json['downvote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_masyarakat'] = idMasyarakat;
    data['nama_pelapor'] = namaPelapor;
    data['nama_jalan'] = namaJalan;
    data['foto'] = foto;
    data['tipe'] = tipe;
    data['deskripsi'] = deskripsi;
    data['status'] = status;
    data['feedback_masyarakat'] = feedbackMasyarakat;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['geometry'] = geometry;
    data['upvote'] = upvote;
    data['downvote'] = downvote;
    return data;
  }
}
