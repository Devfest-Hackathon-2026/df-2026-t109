import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_map/screens/map/map_canvas/region_photo_overlay.dart';

void main() {
  group('RegionPhotoOverlay.latLngToScreenOffset', () {
    const camera = CameraPosition(target: LatLng(36.2048, 137.55), zoom: 5.2);
    const mapSize = Size(390, 844);

    test('カメラターゲットは画面中央に投影される', () {
      final offset = RegionPhotoOverlay.latLngToScreenOffset(
        camera.target,
        camera,
        mapSize,
      );
      expect(offset.dx, closeTo(mapSize.width / 2, 0.01));
      expect(offset.dy, closeTo(mapSize.height / 2, 0.01));
    });

    test('bottom padding がある場合、カメラターゲットは余白を除いた領域の中央に投影される', () {
      const padding = EdgeInsets.only(bottom: 30);
      final offset = RegionPhotoOverlay.latLngToScreenOffset(
        camera.target,
        camera,
        mapSize,
        padding: padding,
      );

      // Google Maps と同様に、下余白を除いた高さの中央へ寄せる
      expect(offset.dx, closeTo(mapSize.width / 2, 0.01));
      expect(offset.dy, closeTo((mapSize.height - 30) / 2, 0.01));
      // padding 未考慮の中央より 15px 上になること
      expect(offset.dy, closeTo(mapSize.height / 2 - 15, 0.01));
    });
  });
}
