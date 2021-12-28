**Delivery Tracker** is born to give you a way to retrieve information about your delivery. <br>

## About Delivery Tracker

The author of this package, made it to help himself to develop a website for his brother to manager his customers, delivery requests, etc. During the development of this applicative, Trobugno decide to separate the logic and make a standlone package.

## Installing
Add **delivery_tracker** to your pubspec.yaml file:
```yaml
dependencies:
  delivery_tracker:
```
Import **delivery_tracker** in files that it will be used:
```dart
import 'package:delivery_tracker/delivery_tracker.dart';
```

## Search a Delivery

At this moment **delivery_tracker** search only _SDA_ deliveries.

```dart
final service = SDAService();
TrackingInfo trackingInfo = await service.searchDelivery('1C4371H074041');
```

If you want to see an example of this **TrackingInfo** look following code:
```dart
TrackingInfo(packages: [
    TrackingPackage(
        trackingCode: '1C4371H074041', 
        details: [
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
```
