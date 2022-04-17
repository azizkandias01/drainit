// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:math';

import 'package:drainit_flutter/app/modules/searchmap/models/searchmap_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:location/location.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../controllers/searchmap_controller.dart';

late LatLng _initialPosition;

Future<LatLng> _getPosition() async {
  final Location location = Location();
  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) throw 'GPS service is disabled';
  }
  if (await location.hasPermission() == PermissionStatus.denied) {
    if (await location.requestPermission() != PermissionStatus.granted) {
      throw 'No GPS permissions';
    }
  }
  final LocationData data = await location.getLocation();
  return LatLng(data.latitude!, data.longitude!);
}

// ignore: must_be_immutable
class SearchmapView extends GetView<SearchmapController> {
  final fabController = FloatingSearchBarController();
  int _index = 0;

  int get index => _index;

  set index(int value) {
    _index = min(value, 2);
    _index == 2 ? fabController.hide() : fabController.show();
    // setState(() {});
  }

  late bool isPortrait;

  @override
  Widget build(BuildContext context) {
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: Container(
          width: 200,
        ),
      ),
      body: SafeArea(
        child: buildSearchBar(),
      ),
    );
  }

  Widget buildSearchBar() {
    final actions = [
      // FloatingSearchBarAction(
      //   // child: CircularButton(
      //   //   icon: const Icon(Icons.place),
      //   //   onPressed: () async {
      //   //     await Map._goToCurrentLocation();
      //   //   },
      //   // ),
      // ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: true,
      ),
    ];

    return Obx(
      () => FloatingSearchBar(
        automaticallyImplyBackButton: true,
        automaticallyImplyDrawerHamburger: false,
        controller: fabController,
        hint: 'search place here',
        iconColor: Colors.grey,
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        //actions: actions,
        progress: controller.isLoading.value,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: controller.onQueryChanged,
        scrollPadding: EdgeInsets.zero,
        transition: CircularFloatingSearchBarTransition(spacing: 16),
        builder: (context, _) => buildExpandableBody(controller),
        body: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: IndexedStack(
            index: min(index, 2),
            children: [
              buildMap(),
              FloatingSearchAppBarExample(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildExpandableBody(SearchmapController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Material(
        color: Colors.white,
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8),
        child: ImplicitlyAnimatedList<Place>(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          items: controller.suggestions.take(10).toList(),
          areItemsTheSame: (a, b) => a == b,
          itemBuilder: (context, animation, place, i) {
            return SizeFadeTransition(
              animation: animation,
              child: buildItem(context, place),
            );
          },
          updateItemBuilder: (context, animation, place) {
            return FadeTransition(
              opacity: animation,
              child: buildItem(context, place),
            );
          },
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, Place place) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            //FloatingSearchBar.of(context)!.close();
            Future.delayed(
              const Duration(milliseconds: 500),
              () => controller.clear(),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SizedBox(
                  width: 36,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: controller.suggestions == history
                        ? const Icon(Icons.history, key: Key('history'))
                        : const Icon(Icons.place, key: Key('place')),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      FloatingSearchBar.of(context)!.close();
                      // controller.goToSearch(
                      //   place.lat,
                      //   place.long,
                      //   mapController,
                      // );
                      //   await Map._updateController.future,
                      // );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.name,
                          style: textTheme.subtitle1,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          place.level2Address + place.lat.toString(),
                          style: textTheme.bodyText2!
                              .copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (controller.suggestions.isNotEmpty &&
            place != controller.suggestions.last)
          const Divider(height: 0),
      ],
    );
  }

  // void _updateSelectedSymbol(SymbolOptions changes) async {
  //   await mapController!.updateSymbol(_selectedSymbol!, changes);
  // }

  Widget buildMap() {
    return Scaffold(
        // body: MapboxMap(
        //   accessToken:
        //       "sk.eyJ1IjoiemVla2FuZHMiLCJhIjoiY2wxZXNzcHY1MGNwcDNpbXFsczV2OXB6dSJ9.Fon9KA_46CpH2d1Yps8S_g",
        //   styleString: "mapbox://styles/mapbox/streets-v11",
        //   initialCameraPosition: const CameraPosition(
        //     target: LatLng(
        //       0.5696307903657801,
        //       101.42544396221638,
        //     ),
        //     zoom: 15,
        //   ),
        //   onMapCreated: (MapboxMapController controller) async {
        //     mapController = controller;
        //     final result = await _getPosition();
        //     await controller.animateCamera(
        //       CameraUpdate.newLatLng(result),
        //     );
        //
        //     await controller.addCircle(
        //       CircleOptions(
        //         circleRadius: 8.0,
        //         circleColor: '#006992',
        //         circleOpacity: 0.8,
        //         geometry: result,
        //         draggable: false,
        //       ),
        //     );
        //   },
        //   onMapClick: (point, latlng) async {
        //     await mapController.addCircle(
        //       CircleOptions(
        //         circleRadius: 8.0,
        //         circleColor: '#006992',
        //         circleOpacity: 0.8,
        //         geometry: latlng,
        //         draggable: false,
        //       ),
        //     );
        //
        //     Get.bottomSheet(Container(
        //       height: Get.height / 2.5,
        //       width: Get.width,
        //       decoration: const BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(20),
        //           topRight: Radius.circular(20),
        //         ),
        //       ),
        //       child: Padding(
        //         padding: const EdgeInsets.all(20),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             Flexible(child: SvgPicture.asset('assets/svg/il_map.svg')),
        //             const SizedBox(height: 20),
        //             Text(
        //               await controller.getAddress(latlng),
        //               style: TextStyle(fontSize: 18),
        //             ),
        //             const SizedBox(height: 10),
        //             ElevatedButton(
        //               onPressed: () async {
        //                 Get.back();
        //                 Get.back(
        //                   result: [
        //                     await controller.getAddress(latlng),
        //                     latlng,
        //                   ],
        //                 );
        //               },
        //               child: Text('Pilih Lokasi'),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ));
        //   },
        // ),
        );
  }
}

class SomeScrollableContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingSearchBarScrollNotifier(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        itemCount: 100,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}

class FloatingSearchAppBarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingSearchAppBar(
      title: const Text('Title'),
      transitionDuration: const Duration(milliseconds: 800),
      color: Colors.greenAccent.shade100,
      colorOnScroll: Colors.greenAccent.shade200,
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: 100,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
      ),
    );
  }
}
