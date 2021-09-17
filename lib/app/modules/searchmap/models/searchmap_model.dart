// ignore_for_file: avoid_renaming_method_parameters

class Place {
  const Place({
    required this.lat,
    required this.long,
    required this.name,
    required this.state,
    required this.country,
  });
  factory Place.fromJson(Map<String, dynamic> map) {
    final props = map['properties'];
    final lat = map['geometry']['coordinates'][1];
    final long = map['geometry']['coordinates'][0];

    return Place(
      name: props['name'].toString(),
      state: props['state'].toString(),
      country: props['country'].toString(),
      lat: double.parse(lat.toString()) + 0.0,
      long: double.parse(long.toString()) + 0.0,
    );
  }
  final String name;
  final String state;
  final String country;
  final double lat;
  final double long;

  bool get hasCountry => country.isNotEmpty == true;
  bool get hasState => state.isNotEmpty == true;

  bool get isCountry => hasCountry && name == country;
  bool get isState => hasState && name == state;

  String get address {
    if (isCountry) return country;
    return '$name, $level2Address, $lat';
  }

  String get addressShort {
    if (isCountry) return country;
    return '$name, $country';
  }

  String get level2Address {
    if (isCountry || isState || !hasState) return country;
    if (!hasCountry) return state;
    return '$state, $country';
  }

  @override
  String toString() => 'Place(name: $name, state: $state, country: $country)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Place &&
        o.name == name &&
        o.state == state &&
        o.country == country;
  }

  @override
  int get hashCode => name.hashCode ^ state.hashCode ^ country.hashCode;
}
