import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:photo_view/photo_view.dart';

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

Color getStatusColor(String status) {
  switch (status) {
    case "NOT_YET_VERIFIED":
      return Colors.orange.shade300;
    case "ON_PROGRESS":
      return Colors.purple.shade300;
    case "COMPLETED":
      return Colors.green.shade300;
    case "REFUSED":
      return Colors.red.shade300;
    case "Banjir":
      return Colors.blue.shade300;
    case "Drainase Rusak":
      return Colors.brown.shade300;
    default:
      return Colors.grey.shade300;
  }
}

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    required this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Foto Laporan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: Get.height,
        ),
        child: PhotoView(
          imageProvider: imageProvider,
          backgroundDecoration: backgroundDecoration,
          minScale: minScale,
          maxScale: maxScale,
          heroAttributes: const PhotoViewHeroAttributes(tag: "image"),
        ),
      ),
    );
  }
}
