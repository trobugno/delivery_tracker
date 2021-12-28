part of delivery_tracker;

class TrackingPackage {
  final String trackingCode;
  final List<TrackingPackageDetails> details;

  TrackingPackage({required this.trackingCode, required this.details});

  @override
  String toString() {
    return 'TrackingPackage{trackingCode: $trackingCode, details: $details}';
  }
}
