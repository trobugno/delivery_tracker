part of delivery_tracker;

class TrackingPackageDetails {
  final DateTime date;
  final String location;
  final TrackingStatus status;

  TrackingPackageDetails(
      {required this.location, required this.date, required this.status});

  @override
  String toString() {
    return 'TrackingPackageDetails{date: $date, location: $location, status: $status}';
  }
}
