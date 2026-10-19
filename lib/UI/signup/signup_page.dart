import 'package:flutter/material.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/constans/constans.dart';
import 'package:wordpress_app/model/woocommerce/register_model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late APIService apiService;
  late CustomerModel customerModel;
  bool isApiCalled = false;

  @override
  void initState() {
    apiService = APIService();
    customerModel = CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 50,
            right: 20,
            left: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Constants.primaryColor.withValues(alpha: 0.15),
                  ),
                  child: Icon(Icons.close, color: Constants.primaryColor),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Constants.primaryColor.withValues(alpha: 0.15),
                  ),
                  child: Icon(Icons.share, color: Constants.primaryColor),
                ),
              ],
            ),
          ),
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.8,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          initialValue: customerModel.firstName,
                          onChanged: (value) {
                            customerModel.firstName = value;
                          },
                          cursorColor: Constants.primaryColor,
                          style: const TextStyle(
                            fontFamily: 'Lalazar',
                            fontSize: 20,
                            height: 2.0,
                          ),
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Constants.primaryColor,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            label: Text(
                              'نام',
                              style: TextStyle(
                                fontFamily: 'Lalezar',
                                fontSize: 20,
                                color: Constants.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          initialValue: customerModel.lastName,
                          onChanged: (value) {
                            customerModel.lastName = value;
                          },
                          cursorColor: Constants.primaryColor,
                          style: const TextStyle(
                            fontFamily: 'Lalazar',
                            fontSize: 20,
                            height: 2.0,
                          ),
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Constants.primaryColor,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            label: Text(
                              ' نام خانوادگی',
                              style: TextStyle(
                                fontFamily: 'Lalezar',
                                fontSize: 20,
                                color: Constants.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          initialValue: customerModel.email,
                          onChanged: (value) {
                            customerModel.email = value;
                          },
                          cursorColor: Constants.primaryColor,
                          style: const TextStyle(
                            fontFamily: 'Lalazar',
                            fontSize: 20,
                            height: 2.0,
                          ),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Constants.primaryColor,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            label: Text(
                              'ایمیل',
                              style: TextStyle(
                                fontFamily: 'Lalezar',
                                fontSize: 20,
                                color: Constants.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          initialValue: customerModel.password,
                          onChanged: (value) {
                            customerModel.password = value;
                          },
                          cursorColor: Constants.primaryColor,
                          style: const TextStyle(
                            fontFamily: 'Lalazar',
                            fontSize: 20,
                            height: 2.0,
                          ),
                          textDirection: TextDirection.ltr,
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Constants.primaryColor,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            label: Text(
                              'پسورد',
                              style: TextStyle(
                                fontFamily: 'Lalezar',
                                fontSize: 20,
                                color: Constants.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                            ),
                            onPressed: () {
                              debugPrint('${customerModel.toJson()}');
                              apiService.createCustomer(customerModel).then((
                                retRes,
                              ) {
                                if (retRes) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Woocommerce App"),
                                        content: const Text(
                                          'Registration Successfull',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Woocommerce App"),
                                        content: const Text('Error'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              });
                            },
                            child: const Text(
                              'ثبت نام',
                              style: TextStyle(
                                fontFamily: 'Lalezar',
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'قبلا اکانت ساختی؟',
                              style: TextStyle(
                                fontFamily: 'Lalezar',
                                fontSize: 15,
                                color: Colors.white,
                              ),
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
        ],
      ),
    );
  }
}
