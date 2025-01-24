 import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lp_customer_onboarding/data/model/user_register_model.dart';

final userRegisterProvider = StateProvider<UserRegister>(
  (ref) => UserRegister(
    fname: "",
    mname: "",
    lname: "",
    dob: "",
    gender: "",documentExpiryDate: "",
    address: UserAddress(
      state: "",
      addressline1: "",
      addressline2: "",
      city: "",
      postalCode: "",
      country: "",
      longitude: "",
      lattittude: "",
      street: "", 
    ),
    photoidtype: "",
    photoidimagepath: "",
  ),
);
