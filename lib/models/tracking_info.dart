part of delivery_tracker;

class TrackingInfo {
  final List<TrackingPackage> packages;
  final TrackingStatus status;
  String? signature;

  TrackingInfo({required this.packages, required this.status, this.signature});

  @override
  String toString() {
    return 'TrackingInfo{packages: $packages, status: $status, signature: $signature}';
  }
}
