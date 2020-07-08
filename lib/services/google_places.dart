import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:smartcaseflutter/controllers/destination_controller.dart';
import 'package:smartcaseflutter/utils/snackbar.dart';

class GooglePlaces {

  static final String _kGoogleApiKey = "AIzaSyDbUy-jN_qvKr1lXLSbA65Vv2KGUvEC8O8";

  static final GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: _kGoogleApiKey);

  static _onError(PlacesAutocompleteResponse response) {
    CustomSnackbar.snackbar(response.errorMessage);
    print(response.errorMessage);
  }

  static showAddressDialog() async {
    Prediction p = await PlacesAutocomplete.show(
      context: Get.overlayContext,
      apiKey: _kGoogleApiKey,
      onError: _onError,
      mode: Mode.overlay,
      language: "fr",
      hint: "Rechercher une ville",
    //  components: [Component(Component.country, "fr")],
    );

    _displayPrediction(p);
  }

  static _displayPrediction(Prediction p) async {
    if (p != null) {
      try {
        // get detail (lat/lng)
        PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId);
        final lat = detail.result.geometry.location.lat;
        final lon = detail.result.geometry.location.lng;
        String city = (detail.result.formattedAddress.split(", "))[0];
        CustomSnackbar.snackbar("Ajout de $city en cours...");
        DestinationController.to.insertDestination(city, lat, lon);
      } catch (err) {
        print("ERROR: $err");
      }
    }
  }

}