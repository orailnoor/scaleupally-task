import 'dart:convert';

import 'package:assignment/Models/chartererModel.dart';
import 'package:assignment/api_services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCharterer extends StatefulWidget {
  const AddCharterer({super.key});

  @override
  State<AddCharterer> createState() => _AddChartererState();
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController websiteController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController getCharterer = TextEditingController();
List<Datum> chartererModel = <Datum>[];
String token = '';

class _AddChartererState extends State<AddCharterer> {
  @override
  void initState() {
    // TODO: implement initState
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (() {
            if (nameController.text.isNotEmpty &&
                emailController.text.isNotEmpty &&
                phoneController.text.isNotEmpty &&
                addressController.text.isNotEmpty &&
                stateController.text.isNotEmpty &&
                cityController.text.isNotEmpty &&
                countryController.text.isNotEmpty &&
                websiteController.text.isNotEmpty) {
              ApiServices().callApi(
                tokenAPI: token,
                name: nameController.text,
                email: emailController.text,
                mob: phoneController.text,
                address: addressController.text,
                state: stateController.text,
                city: cityController.text,
                website: websiteController.text,
                country: countryController.text,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please fill all the fields'),
              ));
            }
          }),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(132, 63, 170, 223),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(1, 1), // changes position of shadow
                  )
                ],
                color: const Color(0xff3FABDF),
                borderRadius: BorderRadius.circular(8)),
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: const Text('Continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Gilroy',
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
        elevation: 0,
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffE9EEF0),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: nameController,
                        onChanged: ((value) {
                          setState(() {});
                        }),
                        onSubmitted: (val) {
                          setState(() {});
                        },
                        cursorColor: Colors.grey,
                        // controller: searchingController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Full Name',
                            hintStyle: TextStyle(
                                color: Color(0xff828282),
                                fontFamily: 'Gilroy',
                                fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffE9EEF0),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: emailController,
                        onChanged: ((value) {
                          setState(() {});
                        }),
                        onSubmitted: (val) {
                          setState(() {});
                        },
                        cursorColor: Colors.grey,
                        // controller: searchingController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: Color(0xff828282),
                                fontFamily: 'Gilroy',
                                fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffE9EEF0),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: countryController,
                        onChanged: ((value) {
                          setState(() {});
                        }),
                        onSubmitted: (val) {
                          setState(() {});
                        },
                        cursorColor: Colors.grey,
                        // controller: searchingController,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            border: InputBorder.none,
                            hintText: 'Country of residence',
                            hintStyle: TextStyle(
                                color: Color(0xff828282),
                                fontFamily: 'Gilroy',
                                fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            color: const Color(0xffE9EEF0),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: CountryCodePicker(
                              // ignore: avoid_print
                              // onChanged: (e) =>
                              //     code1 = e.dialCode.toString(),

                              //print(e.dialCode),
                              initialSelection: 'IN',
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              favorite: const ['+39', 'FR'],
                              // showDropDownButton: true,
                            )),
                      ),
                      const Spacer(),
                      //
                      Container(
                        width: MediaQuery.of(context).size.width - 150,
                        decoration: BoxDecoration(
                            color: const Color(0xffE9EEF0),
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: phoneController,
                            onChanged: ((value) {
                              setState(() {});
                            }),
                            onSubmitted: (val) {
                              setState(() {});
                            },
                            cursorColor: Colors.grey,
                            // controller: searchingController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Mobile Number',
                                hintStyle: TextStyle(
                                    color: Color(0xff828282),
                                    fontFamily: 'Gilroy',
                                    fontSize: 13)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffE9EEF0),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: addressController,
                        onChanged: ((value) {
                          setState(() {});
                        }),
                        onSubmitted: (val) {
                          setState(() {});
                        },
                        cursorColor: Colors.grey,
                        // controller: searchingController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Address',
                            hintStyle: TextStyle(
                                color: Color(0xff828282),
                                fontFamily: 'Gilroy',
                                fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffE9EEF0),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: stateController,
                        onChanged: ((value) {
                          setState(() {});
                        }),
                        onSubmitted: (val) {
                          setState(() {});
                        },
                        cursorColor: Colors.grey,
                        // controller: searchingController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'State',
                            hintStyle: TextStyle(
                                color: Color(0xff828282),
                                fontFamily: 'Gilroy',
                                fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffE9EEF0),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: cityController,
                        onChanged: ((value) {
                          setState(() {});
                        }),
                        onSubmitted: (val) {
                          setState(() {});
                        },
                        cursorColor: Colors.grey,
                        // controller: searchingController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'City',
                            hintStyle: TextStyle(
                                color: Color(0xff828282),
                                fontFamily: 'Gilroy',
                                fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffE9EEF0),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: websiteController,

                        onSubmitted: (val) {
                          setState(() {});
                          Future.delayed(const Duration(seconds: 5), () {
                            setState(() {});
                          });
                        },
                        cursorColor: Colors.grey,
                        // controller: searchingController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Website',
                            hintStyle: TextStyle(
                                color: Color(0xff828282),
                                fontFamily: 'Gilroy',
                                fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Want to search again?",
                        style: TextStyle(
                            color: Colors.black38,
                            fontFamily: 'Gilroy',
                            fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          bottomshet();
                        },
                        child: const Text(
                          " Click here",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Gilroy',
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void bottomshet() {
    showModalBottomSheet<void>(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height - 100,
          color: const Color(0xfff7f7f7),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Color(0xffC6EBF6),
                    thickness: 5,
                    indent: 155,
                    endIndent: 155,
                  ),
                  const Text('Charterer',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontFamily: 'Gilroy',
                          fontSize: 18)),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffE9EEF0),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: getCharterer,

                        onSubmitted: (val) {
                          ApiServices().getUserData(getCharterer.text, token);
                          setState(() {});
                        },
                        cursorColor: Colors.grey,
                        // controller: searchingController,
                        decoration: const InputDecoration(
                            // constraints: BoxConstraints(
                            //     maxHeight: 36, minHeight: 36),
                            suffixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintText: 'Country of residence',
                            hintStyle: TextStyle(
                                color: Color(0xff828282),
                                fontFamily: 'Gilroy',
                                fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  getCharterer.text.isEmpty
                      ? Container()
                      : Expanded(
                          child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FutureBuilder(
                              future: ApiServices()
                                  .getUserData(getCharterer.text, token),
                              builder: (context, snap) {
                                return snap.connectionState !=
                                        ConnectionState.waiting
                                    ? snap.data!.isEmpty
                                        ? const Center(child: Text("no data "))
                                        : ListView.builder(
                                            itemCount: snap.data!.length,
                                            itemBuilder: (((context, index) =>
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                  ),
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 8.0,
                                                      ),
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 40,
                                                        child: Text(snap
                                                            .data![index]
                                                            .chartererName
                                                            .toString()),
                                                      )),
                                                ))))
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      );
                              }),
                        )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Can't find your Charterer?",
                        style: TextStyle(
                            color: Colors.black38,
                            fontFamily: 'Gilroy',
                            fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          " Add now",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Gilroy',
                              fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void getToken() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://sheet2api.com/v1/JfU2A24YSh2a/untitled-spreadsheet#'));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // print(await response.body.toString());
      print(body[0]['Token']);
      token = body[0]['Token'];
    } else {
      print(body[0]['Token']);
      token = body[0]['Token'];
      print(response.reasonPhrase);
    }
  }
}
