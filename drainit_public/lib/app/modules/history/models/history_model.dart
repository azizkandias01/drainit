class HistoryModel {
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

  HistoryModel({
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
  });

  @override
  String toString() {
    return 'History(id: $id, idMasyarakat: $idMasyarakat, namaPelapor: $namaPelapor, idAdmin: $idAdmin, namaAdmin: $namaAdmin, idPetugas: $idPetugas, namaPetugas: $namaPetugas, namaJalan: $namaJalan, foto: $foto, tipePengaduan: $tipePengaduan, deskripsiPengaduan: $deskripsiPengaduan, statusPengaduan: $statusPengaduan, laporanPetugas: $laporanPetugas, feedbackMasyarakat: $feedbackMasyarakat, createdAt: $createdAt, updatedAt: $updatedAt, geometry: $geometry)';
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json['id'] as String?,
        idMasyarakat: json['id_masyarakat'] as String?,
        namaPelapor: json['nama_pelapor'] as String?,
        idAdmin: json['id_admin'] as String?,
        namaAdmin: json['nama_admin'] as String?,
        idPetugas: json['id_petugas'] as String?,
        namaPetugas: json['nama_petugas'] as String?,
        namaJalan: json['nama_jalan'] as String?,
        foto: json['foto'] as String?,
        tipePengaduan: json['tipe_pengaduan'] as String?,
        deskripsiPengaduan: json['deskripsi_pengaduan'] as String?,
        statusPengaduan: json['status_pengaduan'] as String?,
        laporanPetugas: json['laporan_petugas'] as String?,
        feedbackMasyarakat: json['feedback_masyarakat'] as dynamic?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        geometry: json['geometry'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_masyarakat': idMasyarakat,
        'nama_pelapor': namaPelapor,
        'id_admin': idAdmin,
        'nama_admin': namaAdmin,
        'id_petugas': idPetugas,
        'nama_petugas': namaPetugas,
        'nama_jalan': namaJalan,
        'foto': foto,
        'tipe_pengaduan': tipePengaduan,
        'deskripsi_pengaduan': deskripsiPengaduan,
        'status_pengaduan': statusPengaduan,
        'laporan_petugas': laporanPetugas,
        'feedback_masyarakat': feedbackMasyarakat,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'geometry': geometry,
      };

  HistoryModel copyWith({
    String? id,
    String? idMasyarakat,
    String? namaPelapor,
    String? idAdmin,
    String? namaAdmin,
    String? idPetugas,
    String? namaPetugas,
    String? namaJalan,
    String? foto,
    String? tipePengaduan,
    String? deskripsiPengaduan,
    String? statusPengaduan,
    String? laporanPetugas,
    dynamic feedbackMasyarakat,
    String? createdAt,
    String? updatedAt,
    String? geometry,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      idMasyarakat: idMasyarakat ?? this.idMasyarakat,
      namaPelapor: namaPelapor ?? this.namaPelapor,
      idAdmin: idAdmin ?? this.idAdmin,
      namaAdmin: namaAdmin ?? this.namaAdmin,
      idPetugas: idPetugas ?? this.idPetugas,
      namaPetugas: namaPetugas ?? this.namaPetugas,
      namaJalan: namaJalan ?? this.namaJalan,
      foto: foto ?? this.foto,
      tipePengaduan: tipePengaduan ?? this.tipePengaduan,
      deskripsiPengaduan: deskripsiPengaduan ?? this.deskripsiPengaduan,
      statusPengaduan: statusPengaduan ?? this.statusPengaduan,
      laporanPetugas: laporanPetugas ?? this.laporanPetugas,
      feedbackMasyarakat: feedbackMasyarakat ?? this.feedbackMasyarakat,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      geometry: geometry ?? this.geometry,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HistoryModel &&
        other.id == id &&
        other.idMasyarakat == idMasyarakat &&
        other.namaPelapor == namaPelapor &&
        other.idAdmin == idAdmin &&
        other.namaAdmin == namaAdmin &&
        other.idPetugas == idPetugas &&
        other.namaPetugas == namaPetugas &&
        other.namaJalan == namaJalan &&
        other.foto == foto &&
        other.tipePengaduan == tipePengaduan &&
        other.deskripsiPengaduan == deskripsiPengaduan &&
        other.statusPengaduan == statusPengaduan &&
        other.laporanPetugas == laporanPetugas &&
        other.feedbackMasyarakat == feedbackMasyarakat &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.geometry == geometry;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      idMasyarakat.hashCode ^
      namaPelapor.hashCode ^
      idAdmin.hashCode ^
      namaAdmin.hashCode ^
      idPetugas.hashCode ^
      namaPetugas.hashCode ^
      namaJalan.hashCode ^
      foto.hashCode ^
      tipePengaduan.hashCode ^
      deskripsiPengaduan.hashCode ^
      statusPengaduan.hashCode ^
      laporanPetugas.hashCode ^
      feedbackMasyarakat.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      geometry.hashCode;
}
