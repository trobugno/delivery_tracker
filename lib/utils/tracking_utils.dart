part of delivery_tracker;

mixin TrackingUtils {
  DateTime stringToDate(String value) {
    return DateFormat('dd-MM-yyyy HH:mm').parse(value);
  }

  TrackingStatus pickStatus(
      bool readyToSend, bool inTransit, bool delivering, bool delivered) {
    if (readyToSend) {
      return TrackingStatus.readyToSend;
    } else if (inTransit) {
      return TrackingStatus.inTransit;
    } else if (delivering) {
      return TrackingStatus.delivering;
    } else if (delivered) {
      return TrackingStatus.delivered;
    }

    throw Error();
  }

  TrackingStatus stringToStatus(String value) {
    if (value.toLowerCase() == "consegnata") {
      return TrackingStatus.delivered;
    } else if (value.toLowerCase() == "in consegna") {
      return TrackingStatus.delivering;
    } else if (value.toLowerCase().contains("in transito")) {
      return TrackingStatus.inTransit;
    } else {
      return TrackingStatus.readyToSend;
    }
  }
}
