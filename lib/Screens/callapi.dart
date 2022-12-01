import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CallmeBaby {
  void callingAPI(
      {required String tokenAPI,
      required String name,
      required String email,
      required String address,
      required String mob,
      required String state,
      required String city,
      required String website,
      required String country}) async {
    var headers = {
      'authtoken':
          'eyJhbGciOiJSUzI1NiIsImtpZCI6ImE5NmFkY2U5OTk5YmJmNWNkMzBmMjlmNDljZDM3ZjRjNWU2NDI3NDAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vbWFybG8tYmFuay1kZXYiLCJhdWQiOiJtYXJsby1iYW5rLWRldiIsImF1dGhfdGltZSI6MTY2OTI5Nzk0NSwidXNlcl9pZCI6IlJoSGdiY1U0cHZNMGR3RE90d1piTlhPOTlRMjMiLCJzdWIiOiJSaEhnYmNVNHB2TTBkd0RPdHdaYk5YTzk5UTIzIiwiaWF0IjoxNjY5NTM5NDAxLCJleHAiOjE2Njk1NDMwMDEsImVtYWlsIjoieGlob2g1NTQ5NkBkaW5lcm9hLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ4aWhvaDU1NDk2QGRpbmVyb2EuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.z5bonBeFmSr4L2xlHj7jhl4wvCETg-2FTEk6O5fuizxa149A66--rshAhZVAWZYLYYR72PApM86QWULbl8zvyk4FyYz4NoOhcDY7b9d1GrAyW8gV_kpXhntLzeESVwB0Dy3KI_0twsCPN6L0bY8eiQJxUFLNo0adEQdJATYtxEmZgzOiOs17BJ0x3KdNsOi7FVdRZoy90ppdAY1o7jS2u8CR2A1shUVapgI8X7WRGY_c4St1xduwekU_D5aAc7V5CdykkQwgI9cvZYbfobpV_p4j6ETcMjjCq3XoRDQ6c_tbJX9WFaUuQK7BxB-DdwMqTNxm6wuRngoP20r7zwGn3g',
      'Content-Type': 'application/json'
    };
    print('Calling API');
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://asia-southeast1-marlo-bank-dev.cloudfunctions.net/api_dev/contracts/charterers'));
    request.body = json.encode({
      "chartererDetails": {
        "name": "Bhanu",
        "email": "orailkane@gmail.com",
        "address1": "Noida",
        "address2": "Noida",
        "state": "UP",
        "city": "Noida",
        "country": "India",
        "website": "https://www.google.com",
        "contactPerson": "Noor",
        "phoneNumber": "4234234324"
      }
    });

    //
    // print(request.body);
    request.headers.addAll(headers);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    //

    // http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      Fluttertoast.showToast(
          msg: body['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
      print('Got it');
      print(response.body);
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
