// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:math';

import 'package:drainit_flutter/app/components/constant.dart';
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
              Map(),
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
                      controller.goToSearch(
                        place.lat,
                        place.long,
                        await Map._updateController.future,
                      );
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
}

class Map extends GetView<SearchmapController> {
  static final Completer<GoogleMapController> _controller = Completer();
  static final Completer<GoogleMapController> _updateController = Completer();

  static final Marker marker = Marker(
    markerId: const MarkerId('marker pku'),
    position: const LatLng(
      0.5696307903657801,
      101.42544396221638,
    ),
    infoWindow: const InfoWindow(
      title: 'Marker in rumbai',
      snippet: 'Hi this is marker in rumbai',
    ),
    onTap: () {
      // print(marker.infoWindow.title);
    },
  );

  @override
  Widget build(BuildContext context) {
    return buildMap();
  }

  Widget buildMap() {
    const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    return Scaffold(
      body: Obx(
        () => GoogleMap(
          onTap: (LatLng latLng) async {
            controller.myMarker.clear();
            controller.myMarker.add(
              Marker(markerId: const MarkerId("newMarker"), position: latLng),
            );
            controller.data.value = latLng;
            Get.bottomSheet(
              Center(
                child: Container(
                  width: Get.width,
                  color: white,
                  child: Column(
                    children: [
                      Text(await controller.getAddress(latLng)),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          Get.back(result: controller.getAddress(latLng));
                        },
                        child: const Text('select this coordinate'),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          markers: Set.from(controller.myMarker),
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (controller) {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
              _updateController.complete(controller);
              this.controller.goToSearch(
                  0.5696307903657801, 101.42544396221638, controller);
              controller.dispose();
            } else {
              this.controller.goToSearch(
                  0.5696307903657801, 101.42544396221638, controller);
              controller.dispose();
            }
          },
        ),
      ),
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
