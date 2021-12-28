part of delivery_tracker;

class SDAService extends GetConnect with TrackingUtils {
  Future<TrackingInfo> searchDelivery(String trackingNumber) async {
    String url =
        "https://www.sda.it/wps/portal/Servizi_online/ricerca_spedizioni/!ut/p/z1/jZDNDoIwEISfhRdwt5S_q1aJEEn1gOBeTDWkwVQwTfX5JfGGEdnLZpNvZjILBDVQp16tVq7tO2WG-0TRucjWCcsFSsm5wINIMPaTDWIaQTUC0nI1APso57uMowyB5ujxxyxxnn4CoGn7CmgU8d3gn0cOpE1_-bzLt4UoNJCz6tp2emEa5xqrjsN6WgU1EwGP2RbjAAMGj3tZ1ngLjfa8N8JWEQg!/p0/IZ7_6A16HKK0OGGFB0QQ2C2TKR20C7=CZ6_MID81JC0OO33C0QC80728E00F6=NJQCPricercaSpedizione.json=/";
    Response<String> response = await post(url,
        'modalita=01&codiceRicercato=$trackingNumber&campiRicercaVuoti=false',
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        headers: {
          'Accept': 'application/json, text/javascript, */*; q=0.01',
          'X-Requested-With': 'XMLHttpRequest',
          'Origin': 'https://www.sda.it',
          'Sec-Fetch-Site': 'same-origin',
          'Sec-Fetch-Mode': 'cors',
          'Sec-Fetch-Dest': 'empty',
          'Accept-Language': 'it-IT,it;q=0.9,en-US;q=0.8,en;q=0.7',
        });

    Map jsonMap = json.decode(response.body!);
    bool delivered = jsonMap["consegnato"];
    bool readyToSend = jsonMap["presoIncarico"];
    bool inTransit = jsonMap["inTransito"];
    bool delivering = jsonMap["inConsegna"];
    String? signature = jsonMap["firma"];

    List<TrackingPackage> packages = [];
    List<Map> ldvList = List<Map>.from(jsonMap["lettereVettura"]);
    for (Map ldv in ldvList) {
      String ldvTrackingCode = ldv["codiceLetteraVettura"];

      List<TrackingPackageDetails> packageDetails = [];
      List<Map> ldvDetails = List<Map>.from(ldv["dettaglioSpedizioni"]);
      for (Map details in ldvDetails) {
        String date = details["dataOra"];
        String city = details["citta"];
        String status = details["statoLavorazione"];

        packageDetails.add(TrackingPackageDetails(
            location: city,
            date: stringToDate(date),
            status: stringToStatus(status)));
      }
      packages.add(TrackingPackage(
          trackingCode: ldvTrackingCode, details: packageDetails));
    }

    return TrackingInfo(
        packages: packages,
        signature: signature,
        status: pickStatus(readyToSend, inTransit, delivering, delivered));
  }
}
