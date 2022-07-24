import 'package:google_maps_flutter/google_maps_flutter.dart';

class IOT {
  List<TitikPcr>? titikPcr;
  List<TitikWismaAtlet>? titikWismaAtlet;

  LatLng coordinatTitikPcr = LatLng(0.5706402299637866, 101.42479050961819);
  LatLng coordinatTitikWismaAtlet =
      LatLng(0.5693114261697235, 101.43217234433037);

  IOT({this.titikPcr, this.titikWismaAtlet});

  IOT.fromJson(Map<String, dynamic> json) {
    if (json['titik_pcr'] != null) {
      titikPcr = <TitikPcr>[];
      json['titik_pcr'].forEach((v) {
        titikPcr!.add(new TitikPcr.fromJson(v));
      });
    }
    if (json['titik_wisma_atlet'] != null) {
      titikWismaAtlet = <TitikWismaAtlet>[];
      json['titik_wisma_atlet'].forEach((v) {
        titikWismaAtlet!.add(new TitikWismaAtlet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.titikPcr != null) {
      data['titik_pcr'] = this.titikPcr!.map((v) => v.toJson()).toList();
    }
    if (this.titikWismaAtlet != null) {
      data['titik_wisma_atlet'] =
          this.titikWismaAtlet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TitikPcr {
  int? id;
  int? tingginode1;
  int? debitnode1;
  String? tanggal1;
  TitikPcr({this.id, this.tingginode1, this.debitnode1, this.tanggal1});

  TitikPcr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tingginode1 = json['Tingginode1'];
    debitnode1 = json['Debitnode1'];
    tanggal1 = json['Tanggal1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Tingginode1'] = this.tingginode1;
    data['Debitnode1'] = this.debitnode1;
    data['Tanggal1'] = this.tanggal1;
    return data;
  }
}

class TitikWismaAtlet {
  int? id;
  int? tingginode2;
  int? debitnode2;
  String? tanggal2;

  TitikWismaAtlet({this.id, this.tingginode2, this.debitnode2, this.tanggal2});

  TitikWismaAtlet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tingginode2 = json['Tingginode2'];
    debitnode2 = json['Debitnode2'];
    tanggal2 = json['Tanggal2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Tingginode2'] = this.tingginode2;
    data['Debitnode2'] = this.debitnode2;
    data['Tanggal2'] = this.tanggal2;
    return data;
  }
}
