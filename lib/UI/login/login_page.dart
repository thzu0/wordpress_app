import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wordpress_app/UI/root/root_page.dart';

import 'package:wordpress_app/UI/signup/signup_page.dart';
import 'package:wordpress_app/UI/utils/custom_appbar.dart';
import 'package:wordpress_app/UI/utils/custom_dialog_box.dart';
import 'package:wordpress_app/UI/utils/extension.dart';
import 'package:wordpress_app/api/api_service.dart';
import 'package:wordpress_app/constans/constans.dart';
import 'package:wordpress_app/model/woocommerce/register_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late APIService apiService;
  late CustomerModel customerModel;
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController email = TextEditingController(
    text: "somayealimardani01511@gmail.com",
  );
  TextEditingController password = TextEditingController(text: "Test12345");

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
          CustomAppBar(appBarTitle: 'ورود به برنامه'),
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.8,
              child: Form(
                key: globalKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: email,

                            keyboardType: TextInputType.emailAddress,

                            cursorColor: Constants.primaryColor,
                            style: const TextStyle(
                              fontFamily: 'Lalezar',
                              fontSize: 20,
                              height: 2.0,
                            ),
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                fontFamily: 'Vazirmatn',
                              ),
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
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'این فلید باید تکمیل شود';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 20),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            controller: password,

                            keyboardType: TextInputType.emailAddress,

                            cursorColor: Constants.primaryColor,
                            style: const TextStyle(
                              fontFamily: 'Lalezar',
                              fontSize: 20,
                              height: 2.0,
                            ),
                            textDirection: TextDirection.ltr,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                fontFamily: 'Vazirmatn',
                              ),
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
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'این فلید باید تکمیل شود';
                              }
                              return null;
                            },
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
                              onPressed: () async {
                                if (globalKey.currentState!.validate()) {
                                  setState(() {
                                    isApiCalled = true;
                                  });
                                  apiService
                                      .loginCustomer(
                                        email.text.trim(),
                                        password.text.trim(),
                                      )
                                      .then((retRes) {
                                        debugPrint(
                                          retRes.data!.token.toString(),
                                        );
                                        debugPrint(
                                          retRes.data!.toJson().toString(),
                                        );
                                        setState(() {
                                          isApiCalled = false;
                                        });
                                        if (retRes.success!) {
                                          CustomDialogBox.showMessage(
                                            context,
                                            'موفقیت آمیز',
                                            'ورود با موفقیت انجام شد',
                                            'بستن',
                                            () {
                                              Navigator.pushReplacement(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .leftToRight,
                                                  child: const RootPage(),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          CustomDialogBox.showMessage(
                                            context,
                                            'ناموفق',
                                            'نام کاربری یا پسورد اشتباه است',
                                            'بستن',
                                            () {},
                                          );
                                        }
                                      });
                                }
                              },
                              child: const Text(
                                'ورود',
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.leftToRight,
                                    child: const SignupPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'اکانت ندارید؟',
                                style: TextStyle(
                                  fontFamily: 'Lalezar',
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        isApiCalled
                            ? const Text(
                                'لطفا منتظر بمانید....',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontFamily: 'Vazirmatn',
                                  fontSize: 20,
                                ),
                              )
                            : const Text(''),
                      ],
                    ),
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
