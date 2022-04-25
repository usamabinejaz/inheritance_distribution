import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:inheritance_distribution/app_reserved/constants.dart';
import 'package:inheritance_distribution/app_reserved/helpers.dart';
import 'package:inheritance_distribution/services/dialogs.dart';
import 'package:inheritance_distribution/services/firebase/authentication.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordNode = FocusNode();

  late bool hiddenPassword;
  late bool login;
  late bool enabled;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login = true;
    hiddenPassword = true;
    enabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            ...fixedWidgets(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: loginForm(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Powered by Religion To Present \u00a9",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget socialMediaLinks() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildGoogleSigninButton(),
            // const SizedBox(
            //   width: 5.0,
            // ),
            // // Google Sign in Elevated Button
            // buildFacebookSigninButton(),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Widget buildGoogleSigninButton() {
    return ElevatedButton(
      onPressed: enabled
          ? () async {
              final provider = Provider.of<Auth>(context, listen: false);
              setState(() {
                enabled = false;
              });
              try {
                await provider.signInWithGoogle();
              } on FirebaseAuthException catch (e) {
                String errorMessage = getExceptionMessage(e.code);
                getDialog(
                  closeText: 'OK',
                  content: Text(errorMessage),
                  context: context,
                  title: const Text("Login Failed"),
                );
              } on PlatformException catch (e) {
                String errorMessage = getExceptionMessage(e.code);
                await getDialog(
                  closeText: 'OK',
                  content: Text(errorMessage),
                  context: context,
                  title: const Text("Login Failed"),
                );
              } catch (e) {
                await getDialog(
                  closeText: 'OK',
                  content: const Text("Unknown Error"),
                  context: context,
                  title: const Text("Login Failed"),
                );
              } finally {
                setState(() {
                  enabled = true;
                });
              }
            }
          : null,
      child: Image.asset(
        "assets/images/google_logo.png",
        height: 20,
        width: 20,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).scaffoldBackgroundColor,
        ),
        foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColor,
        ),
        elevation: MaterialStateProperty.all<double>(8),
      ),
    );
  }

  Future loginNow() async {
    final provider = Provider.of<Auth>(context, listen: false);
    setState(() {
      enabled = false;
    });
    try {
      await provider.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } on FirebaseAuthException catch (e) {
      String errorMessage = getExceptionMessage(e.code);
      getDialog(
        closeText: 'OK',
        content: Text(errorMessage),
        context: context,
        title: const Text("Login Failed"),
      );
    } on PlatformException catch (e) {
      String errorMessage = getExceptionMessage(e.code);
      await getDialog(
        closeText: 'OK',
        content: Text(errorMessage),
        context: context,
        title: const Text("Login Failed"),
      );
    } catch (e) {
      await getDialog(
        closeText: 'OK',
        content: const Text("Unknown Error"),
        context: context,
        title: const Text("Login Failed"),
      );
    } finally {
      setState(() {
        enabled = true;
      });
    }
  }

  Future signUpNow() async {
    final provider = Provider.of<Auth>(context, listen: false);
    setState(() {
      enabled = false;
    });
    try {
      await provider.createUserWithEmailAndPassword(
          emailController.text, passwordController.text);
    } on FirebaseAuthException catch (e) {
      String errorMessage = getExceptionMessage(e.code);
      getDialog(
        closeText: 'OK',
        content: Text(errorMessage),
        context: context,
        title: const Text("Sign up Failed"),
      );
    } on PlatformException catch (e) {
      String errorMessage = getExceptionMessage(e.code);
      await getDialog(
        closeText: 'OK',
        content: Text(errorMessage),
        context: context,
        title: const Text("Sign up Failed"),
      );
    } catch (e) {
      await getDialog(
        closeText: 'OK',
        content: const Text("Unknown Error"),
        context: context,
        title: const Text("Sign up Failed"),
      );
    } finally {
      setState(() {
        enabled = true;
      });
    }
  }

  List<Widget> fixedWidgets() {
    return [
      const Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: CircleAvatar(
          backgroundImage: AssetImage(
            "assets/images/splash_logo.png",
          ),
          radius: 100,
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "WeRaast",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Constants.appTitleSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const Text(
        "HELPING YOU DIVIDE THE HERITAGE",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Constants.appSubtitle1Size,
        ),
      ),
    ];
  }

  Future<void> resetPasswordPopUp(BuildContext contextMain) async {
    TextEditingController emailForReset = TextEditingController();
    bool buttonsEnabled = true;
    return showDialog(
      barrierDismissible: false,
      context: contextMain,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          title: const Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: 'forgetEmail',
                onChanged: (value) {},
                controller: emailForReset,
                focusNode: FocusNode(),
                inputFormatters: const [],
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: buttonsEnabled
                        ? () async {
                            final provider =
                                Provider.of<Auth>(context, listen: false);
                            setState(() {
                              buttonsEnabled = false;
                            });
                            try {
                              bool result = await provider
                                  .resetPassword(emailForReset.text);
                              if (result) {
                                Navigator.pop(context);
                                getDialog(
                                  closeText: 'OK',
                                  content: const Text(
                                      "Instruction to reset password has been sent to the given email address."),
                                  context: contextMain,
                                  title: const Text("Email sent"),
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              String errorMessage = getExceptionMessage(e.code);
                              getDialog(
                                closeText: 'OK',
                                content: Text(errorMessage),
                                context: context,
                                title: const Text("Resetting failed"),
                              );
                            } on PlatformException catch (e) {
                              String errorMessage = getExceptionMessage(e.code);
                              await getDialog(
                                closeText: 'OK',
                                content: Text(errorMessage),
                                context: context,
                                title: const Text("Resetting failed"),
                              );
                            } catch (e) {
                              await getDialog(
                                closeText: 'OK',
                                content: const Text("Unknown Error"),
                                context: context,
                                title: const Text("Resetting failed"),
                              );
                            } finally {
                              setState(() {
                                buttonsEnabled = true;
                              });
                            }
                          }
                        : null,
                    child: const Text("Reset"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: buttonsEnabled
                        ? () {
                            Navigator.pop(context);
                          }
                        : null,
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget loginForm() {
    Size size = MediaQuery.of(context).size;
    return Theme(
      data: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Theme.of(context).colorScheme.secondary,
          selectionColor: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
          selectionHandleColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width > 400 ? 700 : double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //Sing in/Sign up option
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          login ? 'New User?' : 'Already have an account?',
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        Material(
                          color: Constants.appTransparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                login = !login;
                              });
                            },
                            splashColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Text(
                              login ? ' Sign up' : ' Log in',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Sing in/Sign up form
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        // Email Container
                        FormBuilderTextField(
                          enabled: enabled,
                          name: 'email',
                          controller: emailController,
                          focusNode: emailNode,
                          style: TextStyle(
                            color: login
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Theme.of(context).colorScheme.secondary,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: login
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: login
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            label: Text(
                              "Email",
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            hintText: "email",
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: login
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          onSubmitted: (value) {
                            passwordNode.requestFocus();
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FormBuilderTextField(
                          enabled: enabled,
                          name: 'password',
                          controller: passwordController,
                          focusNode: passwordNode,
                          inputFormatters: const [],
                          style: TextStyle(
                            color: login
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Theme.of(context).colorScheme.secondary,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: login
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: login
                                    ? Theme.of(context).scaffoldBackgroundColor
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            label: Text(
                              "Password",
                              style: TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            hintText: "password",
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: login
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          obscureText: hiddenPassword,
                          onSubmitted: (value) {
                            passwordNode.unfocus();
                          },
                        ),
                      ],
                    ),
                  ),
                  // //Forgot Password
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        Material(
                          color: Constants.appTransparent,
                          child: InkWell(
                            onTap: () {
                              resetPasswordPopUp(context);
                            },
                            splashColor:
                                Theme.of(context).colorScheme.secondary,
                            child: Text(
                              ' Reset Password',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // // Save Password and Sign with Row
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: enabled
                        ? () async {
                            if (emailController.text.isEmpty ||
                                emailController.text == '' ||
                                passwordController.text.isEmpty ||
                                passwordController.text == '') {
                              final snackBar = SnackBar(
                                duration: const Duration(seconds: 2),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 8.0,
                                ),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.7),
                                content: Text(
                                  'Please Enter Details',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              login ? await loginNow() : await signUpNow();
                            }
                          }
                        : null,
                    child: Text(login ? 'Login' : 'Signup'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).scaffoldBackgroundColor,
                      ),
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor,
                      ),
                      elevation: MaterialStateProperty.all<double>(8),
                    ),
                  ),
                  // //Social Login Options
                  socialMediaLinks(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
