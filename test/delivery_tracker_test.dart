import 'package:delivery_tracker/delivery_tracker.dart';
import 'package:delivery_tracker/models/tracking_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test('test SDA tracker', () async {
    final service = SDAService();
    final mock = TrackingInfo(packages: [
      TrackingPackage(trackingCode: '1C4371H074041', details: [
        TrackingPackageDetails(
            location: 'Centro Operativo SDA Novara (NO)',
            date: _toDate('24-12-2021 11:20'),
            status: TrackingStatus.delivered),
        TrackingPackageDetails(
            location: 'Centro Operativo SDA Novara (NO)',
            date: _toDate('24-12-2021 09:19'),
            status: TrackingStatus.delivering),
        TrackingPackageDetails(
            location: 'Hub Espresso Piacenza',
            date: _toDate('22-12-2021 15:06'),
            status: TrackingStatus.inTransit),
        TrackingPackageDetails(
            location: 'Hub Espresso Piacenza',
            date: _toDate('22-12-2021 15:06'),
            status: TrackingStatus.inTransit),
        TrackingPackageDetails(
            location: 'Casarano (LE)',
            date: _toDate('21-12-2021 14:13'),
            status: TrackingStatus.inTransit),
        TrackingPackageDetails(
            location: 'Casarano (LE)',
            date: _toDate('20-12-2021 18:59'),
            status: TrackingStatus.readyToSend),
      ]),
    ], status: TrackingStatus.delivered, signature: "bosa");

    TrackingInfo trackingInfo = await service.searchDelivery('1C4371H074041');
    print("[ INFO ] >> Checking signature");
    expect(trackingInfo.signature, mock.signature,
        reason: "Signature doesn't match");
    print("[ INFO ] >> Checking status");
    expect(trackingInfo.status, mock.status, reason: "Status doesn't match");
    print("[ INFO ] >> Checking packages number");
    expect(trackingInfo.packages.length, mock.packages.length,
        reason: "Packages number doesn't match");
    for (int i = 0; i < trackingInfo.packages.length; i++) {
      print("[ Package #$i ] -- Checking tracking code");
      expect(
          trackingInfo.packages[i].trackingCode, mock.packages[i].trackingCode,
          reason: "TrackingCode doesn't match");
      print("[ Package #$i ] -- Checking details number");
      expect(trackingInfo.packages[i].details.length,
          mock.packages[i].details.length,
          reason: "Details number doesn't match");
      for (int j = 0; j < trackingInfo.packages[i].details.length; j++) {
        print("\t[ Detail #$j ] -- Checking details status");
        expect(trackingInfo.packages[i].details[j].status,
            mock.packages[i].details[j].status,
            reason: "Details Status doesn't match");
        print("\t[ Detail #$j ] -- Checking details date");
        expect(trackingInfo.packages[i].details[j].date,
            mock.packages[i].details[j].date,
            reason: "Details Date doesn't match");
        print("\t[ Detail #$j ] -- Checking details location");
        expect(trackingInfo.packages[i].details[j].location,
            mock.packages[i].details[j].location,
            reason: "Details Location doesn't match");
      }
    }
  });
}

DateTime _toDate(String value) {
  return DateFormat('dd-MM-yyyy HH:mm').parse(value);
}
