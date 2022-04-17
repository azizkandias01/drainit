// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/text_poppins.dart';

String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
  final DateTime reportDate = DateTime.parse(dateString);
  final date2 = DateTime.now();
  final difference = date2.difference(reportDate);

  if (difference.inDays > 60) {
    return '2 months ago';
  }
  if (difference.inDays > 30) {
    return '1 month ago';
  }
  if (difference.inDays > 21) {
    return '4 weeks ago';
  }
  if (difference.inDays > 15) {
    return '3 weeks ago';
  }
  if (difference.inDays > 8) {
    return '2 weeks ago';
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? '1 week ago' : 'Last week';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? '1 day ago' : 'Yesterday';
  } else if (difference.inHours >= 2) {
    return '${difference.inHours} hours ago';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? '1 hour ago' : 'An hour ago';
  } else if (difference.inMinutes >= 2) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '1 minute ago' : 'A minute ago';
  } else if (difference.inSeconds >= 3) {
    return '${difference.inSeconds} seconds ago';
  } else {
    return 'Just now';
  }
}

String imagePath() =>
    "https://gis-drainase.pocari.id/storage/app/public/images/";

void showErrorSnackBar(String error) {
  Get.snackbar(
    'Error',
    error,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showSuccessSnackBar(String body) {
  Get.snackbar(
    'Berhasil',
    body,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showInfoSnackBar(String body) {
  Get.snackbar(
    'Info',
    body,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.blue,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showWarningSnackBar(String body) {
  Get.snackbar(
    'Warning',
    body,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.orange,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    snackStyle: SnackStyle.FLOATING,
  );
}

void showConfirmDialog(
  String title,
  String body,
  Function() onConfirm,
  Function() onCancel, {
  String confirmText = 'Ya',
  String cancelText = 'Tidak',
}) {
  Get.dialog(
    AlertDialog(
      title: TextPoppinsBold(
        text: title,
        fontSize: 16,
      ),
      content: TextPoppinsRegular(
        text: body,
        fontSize: 14,
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Get.back();
          },
          child: TextPoppinsBold(
            text: cancelText,
            fontSize: 16,
          ),
        ),
        FlatButton(
          onPressed: () {
            Get.back();
            onConfirm();
          },
          child: TextPoppinsBold(
            text: confirmText,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

extension ExtendedDouble on double {
  Widget get sizedHeight => SizedBox(
        height: this,
      );
  Widget get sizedWidget => SizedBox(
        width: this,
      );
}

const String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
