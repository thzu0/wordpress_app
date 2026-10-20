import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wordpress_app/UI/login/login_page.dart';
import 'package:wordpress_app/UI/signup/custom_form_field.dart';
import 'package:wordpress_app/UI/utils/custom_appbar.dart';
import 'package:wordpress_app/UI/utils/custom_dialog_box.dart';
import 'package:wordpress_app/UI/utils/extension.dart';
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
  GlobalKey<FormState> globalKey = GlobalKey();

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
          CustomAppBar(appBarTitle: 'ثبت نام'),
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
                        CustomFormField(
                          textDirection: TextDirection.rtl,
                          labelName: 'نام',
                          initialValue: customerModel.firstName,
                          onChanged: (value) {
                            customerModel.firstName = value;
                          },
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'این فلید باید تکمیل شود';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        CustomFormField(
                          textDirection: TextDirection.rtl,
                          labelName: ' نام خانوادگی',
                          initialValue: customerModel.lastName,
                          onChanged: (value) {
                            customerModel.lastName = value;
                          },
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'این فلید باید تکمیل شود';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        CustomFormField(
                          textDirection: TextDirection.ltr,
                          labelName: 'ایمیل',
                          initialValue: customerModel.email,
                          onChanged: (value) {
                            customerModel.email = value;
                          },
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'این فلید باید تکمیل شود';
                            }
                            if (!value!.isValidEmail) {
                              return 'ایمیل صحیح نمیباشد';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),

                        CustomFormField(
                          textDirection: TextDirection.ltr,
                          labelName: 'پسورد',
                          initialValue: customerModel.password,
                          onChanged: (value) {
                            customerModel.password = value;
                          },
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'این فلید باید تکمیل شود';
                            }
                            if (!value!.isValidPassword) {
                              return 'پسورد قوی نمیباشد';
                            }
                            return null;
                          },
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
                                if (!globalKey.currentState!.validate()) return;

                                setState(() => isApiCalled = true);

                                final bool retRes = await apiService
                                    .createCustomer(customerModel);

                                if (!context.mounted) {
                                  return; // گارد درست بعد از await
                                }

                                setState(() => isApiCalled = false);

                                CustomDialogBox.showMessage(
                                  context,
                                  retRes ? 'ثبت نام موفق' : 'ثبت نام ناموفق',
                                  retRes
                                      ? 'ثبت نام ما با موفقیت انجام شد'
                                      : 'ایمیلی که استفاده کردید تکراری است',
                                  'بستن',
                                  () => Navigator.of(context).pop(),
                                );
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: const LoginPage(),
                                  ),
                                );
                              },
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
