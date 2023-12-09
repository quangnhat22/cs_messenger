import 'package:app/components/features/message/utils/message_utils.dart';
import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:app/configs/theme/app_theme.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:resources/resources.dart';

class PickerMapWidget extends StatefulWidget {
  const PickerMapWidget({super.key});

  @override
  State<PickerMapWidget> createState() => _PickerMapWidgetState();
}

class _PickerMapWidgetState extends State<PickerMapWidget> {
  late GoogleMapController _controller;
  Set<Marker> markers = {};

  Future<void> _getCurrentLocation() async {
    try {
      await MessageUtils.getCurrentLocation().then((position) {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 16.0,
            ),
          ),
        );
        markers.clear();
        markers.add(
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: LatLng(position.latitude, position.longitude),
          ),
        );
        setState(() {});
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _sendMyLocation(BuildContext context) async {
    final lat = markers.first.position.latitude;
    final long = markers.first.position.longitude;
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    final address =
        "${placemarks.first.street}, ${placemarks.first.thoroughfare} ,${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}";
    final mapParams = MapMessageParam(lat: lat, long: long, name: address);
    if (context.mounted) {
      Navigator.of(context).pop<MapMessageParam>(mapParams);
    }
  }

  @override
  void initState() {
    super.initState();
    (() async {})();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizeExt.of.majorScale(4)),
            ),
            padding: EdgeInsets.all(AppSizeExt.of.majorPaddingScale(2)),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppSizeExt.of.majorScale(9))),
              child: Align(
                alignment: Alignment.bottomRight,
                heightFactor: 0.3,
                widthFactor: 2.5,
                child: GoogleMap(
                  initialCameraPosition: _kInitialCamera,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (GoogleMapController controller) async {
                    _controller = controller;
                    await _getCurrentLocation();
                  },
                  markers: markers,
                  // onCameraIdle: () {
                  //   setState(() {});
                  // },
                  onTap: (LatLng latPress) {
                    markers.clear();
                    markers.add(
                      Marker(
                        markerId: const MarkerId('currentLocation'),
                        position: LatLng(latPress.latitude, latPress.longitude),
                      ),
                    );
                    setState(() {});
                  },
                  // onCameraMove: (CameraPosition cameraPosition) {
                  //   markers.clear();
                  //   markers.add(
                  //     Marker(
                  //       markerId: const MarkerId('currentLocation'),
                  //       position: LatLng(cameraPosition.target.latitude,
                  //           cameraPosition.target.longitude),
                  //     ),
                  //   );
                  // },
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            AppButtonTextWidget()
                .setButtonText(R.strings.sendMyLocation)
                .setTextStyle(
                    TextStyle(color: Theme.of(context).colorScheme.primary))
                .setOnPressed(() async {
              await _sendMyLocation(context);
            }).build(context),
          ],
        )
      ],
    );
  }

  static const CameraPosition _kInitialCamera =
      CameraPosition(target: LatLng(33.6844, 73.0499));
}
