import 'dart:convert';
import 'package:assignment/Models/chartererModel.dart';
import 'package:assignment/Screens/add_charterer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  var token =
      'eyJhbGciOiJSUzI1NiIsImtpZCI6ImE5NmFkY2U5OTk5YmJmNWNkMzBmMjlmNDljZDM3ZjRjNWU2NDI3NDAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWFybG8tYmFuay1kZXYiLCJhdWQiOiJtYXJsby1iYW5rLWRldiIsImF1dGhfdGltZSI6MTY2OTI3OTc3MCwidXNlcl9pZCI6IlJoSGdiY1U0cHZNMGR3RE90d1piTlhPOTlRMjMiLCJzdWIiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiaWF0IjoxNjY5MjkxNTY1LCJleHAiOjE2NjkyOTUxNjUsImVtYWlsIjoieGlob2g1NTQ5NkBkaW5lcm9hLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.CiwqbB-edj0JfHeY7Xz4cssh1d73l_V6XyTcyW2QwVbkHKpg1HRqjj5rpnJUyyKBWYXgyQtLhH_sTaCg6MPifDl4xxI2RDibZkrtBzvw3dQnDqI3bkKWb11Zvqfupt5yINIDFSbNa3RGVCrZQfvapfUMfkGqmEd45A0Li0JGzy0rY6CP2qRt2l4pr7SkxLTlEqxE0OaptmXL6NnMLVo8jiZy8lqlfiTzv6KtJSSEEFSjIS78CJZQYCKrKwGzGTMKHPWvvCMjrM5bxjin034L5ikiRimGcOjTz1mITwvokw96NJW7S-JH7pbbJRHyLBYm3mlxbPe7qHB3Nl6-kq91Ow';
  void callApi({
    String? name,
    tokenAPI,
    email,
    country,
    mob,
    address,
    state,
    city,
    website,
  }) async {
    print(tokenAPI);
    tokenAPI.isEmpty ? tokenAPI = token : tokenAPI = tokenAPI;
    var headers = {
      'authtoken': '$tokenAPI',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://asia-southeast1-marlo-bank-dev.cloudfunctions.net/api_dev/contracts/charterers'));
    request.body = json.encode({
      "chartererDetails": {
        "name": '$name',
        "email": '$email',
        "address1": '$address',
        "address2": '$address',
        "state": '$state',
        "city": '$city',
        "country": '$country',
        "website": '$website',
        "contactPerson": "$name",
        "phoneNumber": '$mob'
      }
    });
    request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();
    print(request.body);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var body = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      Fluttertoast.showToast(msg: body['error_flag']);
      print(response.body);
    } else {
      response.statusCode == 401
          ? Fluttertoast.showToast(
              msg: 'Error ' + response.statusCode.toString())
          : Fluttertoast.showToast(msg: 'Please correct your fields');
    }
  }

  //

  Future<List<Datum>> getUserData(String chartererName, String tokenAPI) async {
    print(tokenAPI);
    var headers = {'authtoken': tokenAPI.isNotEmpty ? tokenAPI : token};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://asia-southeast1-marlo-bank-dev.cloudfunctions.net/api_dev/contracts/charterers/search?charterer_name=$chartererName'));
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var body = jsonDecode(response.body);
    chartererModel = [];
    if (response.statusCode == 200) {
      chartererModel.addAll(ChartererModel.fromJson(body).data);
    } else {}
    return chartererModel;
  }
}
