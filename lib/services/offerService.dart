import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/models/Offer.dart';
import 'package:quiz_app/services/authService.dart';

class OfferService extends AuthService {
  // ignore: missing_return
  static Future<List<Offer>> getAllOffers() async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'offer/app',
        method: 'GET');
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Offer> offers =
      responseMap.map<Offer>((offerMap) => Offer.fromJson(offerMap)).toList();
      return offers;
    } else {
      print("DEBUG");
    }
  }
}