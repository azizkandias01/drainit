class UpdateProfileRequest {
  UpdateProfileRequest(
    this.name,
    this.phone,
    this.email,
    this.alamat,
    this.foto,
  );

  String name;
  String phone;
  String email;
  String alamat;
  String? foto;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['foto'] = foto;
    data['telepon'] = phone;
    data['alamat'] = alamat;
    data['email'] = email;
    return data;
  }
}
