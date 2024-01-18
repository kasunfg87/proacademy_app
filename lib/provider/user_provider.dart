import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:proacademy_app/controller/auth_controller.dart';
import 'package:proacademy_app/screens/home/home.dart';
import 'package:proacademy_app/screens/sign_in/signin.dart';
import '../components/widgets/utilities/alert_helper.dart';
import '../components/widgets/utilities/navigation_function.dart';
import '../models/objects.dart';

class UserProvider extends ChangeNotifier {
  //---------------- controllers
  final AuthController _authController = AuthController();

  // ----- store firebase user
  User? _firebaseUser;

  // ----- getter for firebase user

  User? get firebaseUser => _firebaseUser;

  //----- user model
  UserModel? _userModel;

  //-------get user model
  UserModel? get userModel => _userModel;

  // ----- first name controller

  final _firstNameController = TextEditingController();

  // ----- get first name controller

  TextEditingController get firstNameController => _firstNameController;

  // ----- last name controller

  final _lastNameController = TextEditingController();

  // ----- get last name controller

  TextEditingController get lastNameController => _lastNameController;

  // ----- birth day controller

  final _birthDayController = TextEditingController();

  // ----- get birth day controller

  TextEditingController get birthDayController => _birthDayController;

  // ----- age controller

  final _ageController = TextEditingController();

  // ----- get age controller

  TextEditingController get ageController => _ageController;

  // ----- mobile controller

  final _mobileNumberController = TextEditingController();

  // ----- get mobile number controller

  TextEditingController get mobileNumberController => _mobileNumberController;

  // ----- gender controller

  final _genderController = TextEditingController();

  // ----- get gender controller

  TextEditingController get genderController => _genderController;

  // ----- address controller

  final _addressController = TextEditingController();

  // ----- get address controller

  TextEditingController get addressController => _addressController;

  // ----- school controller

  final _schoolController = TextEditingController();

  // ----- get school controller

  TextEditingController get schoolController => _schoolController;

  // ----- check box state

  bool _isChecked = false;

  // ----- get check box state

  bool get isChecked => _isChecked;

  // -----chage check box state
  void setIsCheck(bool value) {
    _isChecked = value;
    notifyListeners();
  }

  // ----- email controller

  final _emailController = TextEditingController();

  // ----- get email controller

  TextEditingController get emailController => _emailController;

  // ----- password controller

  final _passwordController = TextEditingController();

  // ----- get password controller

  TextEditingController get passwordController => _passwordController;

  // ----- confirm password controller

  final _confirmPasswordController = TextEditingController();

  // ----- get confirm password controller

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  //---- loading state

  bool _isLoading = false;

  // ----- get loading state

  bool get isLoading => _isLoading;

  // -----chage loading state
  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void clearTextController() {
    _firstNameController.clear();
    _lastNameController.clear();
    _birthDayController.clear();
    _ageController.clear();
    _genderController.clear();
    _mobileNumberController.clear();
    _addressController.clear();
    _schoolController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear;
    setIsCheck(false);

    notifyListeners();
  }

  // --- login account detials for sign in validation

  bool accountFieldsValidate(BuildContext context) {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      AlertHelper.showSanckBar(context, 'Empty fields are not allowed !',
          AnimatedSnackBarType.error);
      return false;
    } else if (!_emailController.text.contains('@')) {
      AlertHelper.showSanckBar(
          context, 'Plese enter valid email !', AnimatedSnackBarType.error);
      return false;
    } else if (_passwordController.text.length < 6) {
      AlertHelper.showSanckBar(
          context,
          'Password must have more then 6 digits !',
          AnimatedSnackBarType.error);
      return false;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      AlertHelper.showSanckBar(
          context,
          'The confirm password confirmation does not match !',
          AnimatedSnackBarType.error);

      return false;
    } else {
      return true;
    }
  }

  // --- personal details validation

  bool personalFieldValidate(BuildContext context) {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _birthDayController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _genderController.text.isEmpty) {
      AlertHelper.showSanckBar(context, 'Empty fields are not allowed !',
          AnimatedSnackBarType.error);
      return false;
    } else if (int.parse(_ageController.text) > 35 ||
        int.parse(_ageController.text) < 18) {
      AlertHelper.showSanckBar(context, 'Age Should be between 18 - 35 years !',
          AnimatedSnackBarType.error);
      return false;
    } else {
      return true;
    }
  }

  // --- contact details validation

  bool contactFieldValidate(BuildContext context) {
    if (_mobileNumberController.text.isEmpty ||
        _addressController.text.isEmpty) {
      AlertHelper.showSanckBar(context, 'Empty fields are not allowed !',
          AnimatedSnackBarType.error);
      return false;
    } else if (_mobileNumberController.text.length < 10) {
      AlertHelper.showSanckBar(
          context, 'Invalid mobile number ! ', AnimatedSnackBarType.error);
      return false;
    } else {
      return true;
    }
  }

  // --- educational details validation

  bool educationalFieldValidate(BuildContext context) {
    if (_schoolController.text.isEmpty) {
      AlertHelper.showSanckBar(context, 'Empty fields are not allowed !',
          AnimatedSnackBarType.error);
      return false;
    } else if (_isChecked == false) {
      AlertHelper.showSanckBar(
          context,
          'Tick the checkbox if you want to proceed ! ',
          AnimatedSnackBarType.error);
      return false;
    } else {
      return true;
    }
  }

  // --- login details validation
  bool signInFieldsValidate(BuildContext context) {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      AlertHelper.showSanckBar(context, 'Empty fields are not allowed !',
          AnimatedSnackBarType.error);
      return false;
    } else if (!_emailController.text.contains('@')) {
      AlertHelper.showSanckBar(
          context, 'Plese enter valid email !', AnimatedSnackBarType.error);
      return false;
    } else if (_passwordController.text.length < 6) {
      AlertHelper.showSanckBar(
          context,
          'Password must have more then 6 digits !',
          AnimatedSnackBarType.error);
      return false;
    } else {
      return true;
    }
  }

  // --- forgot password details validation
  bool forgotPasswordFieldsValidate(BuildContext context) {
    if (_emailController.text.isEmpty) {
      AlertHelper.showSanckBar(context, 'Empty fields are not allowed !',
          AnimatedSnackBarType.error);
      return false;
    } else if (!_emailController.text.contains('@')) {
      AlertHelper.showSanckBar(
          context, 'Plese enter valid email !', AnimatedSnackBarType.error);
      return false;
    } else {
      return true;
    }
  }

  // ----- start signup process

  Future<void> startSignUp(BuildContext context) async {
    try {
      setLoading(true);

      await AuthController().registerUser(
          context,
          _emailController.text,
          _passwordController.text,
          _firstNameController.text,
          _lastNameController.text,
          _birthDayController.text,
          int.parse(_ageController.text),
          _genderController.text,
          _mobileNumberController.text,
          _addressController.text,
          _schoolController.text);

      clearTextController();

      setLoading(false);
    } catch (e) {
      setLoading(false);
      // ignore: use_build_context_synchronously
      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.success);
    }
  }

  // ----- start sign in process

  Future<void> startLogin(BuildContext context) async {
    try {
      if (signInFieldsValidate(context)) {
        setLoading(true);

        await AuthController().signInUser(
            context, _emailController.text, _passwordController.text);

        clearTextController();

        setLoading(false);
      } else {}
    } catch (e) {
      setLoading(false);
      // ignore: use_build_context_synchronously
      AlertHelper.showSanckBar(
          context, e.toString(), AnimatedSnackBarType.success);
    }
  }

  // ----- fetch user data process

  Future<void> fetchUser(String id) async {
    try {
      //--start the loader
      setLoading(true);

      await AuthController().fetchUserData(id).then((value) {
        if (value != null) {
          Logger().w(value.firstName);
          _userModel = value;

          //---callling this to notify that usermodel has been set
          notifyListeners();

          //--start the loader
          setLoading(false);
        }
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  //------initialize and check whether the user is signed in or not
  Future<void> initializeUser(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Logger().i('User is currently signed out!');
      } else {
        Logger().i('User is signed in!');
        Logger().i(user.uid);
        await fetchUser(user.uid).then((value) {
          // updating
          updateUserOnline(true);

          //
          NavigationFunction.navigateTo(
              BuildContext, context, Widget, const Home());
        });
      }
    });
  }

  //----- send password rest link

  Future<void> sendPasswordResetLink(BuildContext context) async {
    if (forgotPasswordFieldsValidate(context)) {
      setLoading(true);

      await AuthController()
          .sendPassResetEmail(context, _emailController.text)
          .whenComplete(
            () => NavigationFunction.navigateTo(
                BuildContext, context, Widget, const SignIn()),
          );
      clearTextController();
      setLoading(false);
    }
  }

  //------------------pick, upload and update user profile image
  //---------pick an image

  //image picker instance
  final ImagePicker _picker = ImagePicker();

  //-----file object
  File _image = File("");

  //-----getter for image file
  File get getImage => _image;

  //---a function to pick a file from gallery
  Future<void> selectImageAndUpload() async {
    try {
      // Pick an image
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      //---check if the user has picked a file or not
      if (pickedFile != null) {
        // Logger().i(pickedFile.path);
        //--assigning to the file object
        _image = File(pickedFile.path);

        //start uploading the image after picking
        updateProfileImage(_image);

        notifyListeners();
      } else {
        Logger().e("No image selected");
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  //upload and update profile image
  Future<void> updateProfileImage(File image) async {
    try {
      //--start the loader
      setLoading(true);

      //--start uploading the image
      String imgUrl = await AuthController()
          .uploadAndUpdateProfileImage(_userModel!.uid, image);

      if (imgUrl != "") {
        //---update the usermodel img filed with returned download url
        _userModel!.img = imgUrl;
        notifyListeners();

        //--stop the loader
        setLoading(false);
      }
    } catch (e) {
      Logger().e(e);
      //--stop the loader
      setLoading(false);
    }
  }

  void updateUserOnline(bool val) {
    try {
      _authController.updateOnlineStatus(_firebaseUser!.uid, val);
    } catch (e) {
      Logger().e(e);
    }
  }
}
