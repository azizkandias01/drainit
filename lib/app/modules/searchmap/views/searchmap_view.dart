import 'package:drainit_flutter/app/modules/searchmap/models/searchmap_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../controllers/searchmap_controller.dart';
import 'dart:async';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:location/location.dart';

late var _initialPosition;

Future<LatLng> _getPosition() async {
  final Location location = Location();
  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) throw 'GPS service is disabled';
  }
  if (await location.hasPermission() == PermissionStatus.denied) {
    if (await location.requestPermission() != PermissionStatus.granted)
      throw 'No GPS permissions';
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

  late var isPortrait;

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
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () async {
            await Map._goToCurrentLocation();
          },
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ];

    return Obx(
      () => FloatingSearchBar(
        automaticallyImplyBackButton: false,
        controller: fabController,
        clearQueryOnClose: true,
        hint: 'search place here',
        iconColor: Colors.grey,
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOutCubic,
        physics: const BouncingScrollPhysics(),
        axisAlignment: isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        actions: actions,
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
                      await Map._goToSearch(place.lat, place.long);
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
  static Completer<GoogleMapController> _controller = Completer();

  static final Marker marker = Marker(
    markerId: MarkerId("marker pku"),
    position: LatLng(
      0.5696307903657801,
      101.42544396221638,
    ),
    infoWindow: InfoWindow(
        title: "Marker in rumbai", snippet: 'Hi this is marker in rumbai'),
    onTap: () {
      print(marker.infoWindow.title);
    },
  );

  static Future<void> _goToCurrentLocation() async {
    _initialPosition = await _getPosition();
    final CameraPosition currentLocation = CameraPosition(
      target: _initialPosition,
      zoom: 18.151926040649414,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(currentLocation));
  }

  static Future<void> _goToSearch(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 18.151926040649414,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return buildMap();
  }

  Widget buildMap() {
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        onTap: (LatLng latLng) {
          controller.data.value = latLng;
          _handleTap(latLng);
        },
        markers: Set.from(controller.myMarker),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            _controller.complete(controller);
          } else {
            print("completer has created");
          }
        },
      ),
    );
  }

  _handleTap(LatLng data) {
    var markers = controller.myMarker.value as List<Marker>;
    print(data.toString());
    if (markers.isNotEmpty) {
      markers = [];
    } else {
      markers.add(
        Marker(
            markerId: MarkerId(
              data.toString(),
            ),
            position: data),
      );
    }
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
