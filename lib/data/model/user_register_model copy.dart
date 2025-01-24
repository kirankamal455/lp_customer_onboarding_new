// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserRegister {
  String fname;
  String mname;
  String lname;
  String dob;
  String gender;
  UserAddress address;
  String photoidtype;
  String photoidimagepath;
  UserRegister({
    required this.fname,
    required this.mname,
    required this.lname,
    required this.dob,
    required this.gender,
    required this.address,
    required this.photoidtype,
    required this.photoidimagepath,
  });

  UserRegister copyWith({
    String? fname,
    String? mname,
    String? lname,
    String? dob,
    String? gender,
    UserAddress? address,
    String? photoidtype,
    String? photoidimagepath,
  }) {
    return UserRegister(
      fname: fname ?? this.fname,
      mname: mname ?? this.mname,
      lname: lname ?? this.lname,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      photoidtype: photoidtype ?? this.photoidtype,
      photoidimagepath: photoidimagepath ?? this.photoidimagepath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fname': fname,
      'mname': mname,
      'lname': lname,
      'dob': dob,
      'gender': gender,
      'address': address.toMap(),
      'photoidtype': photoidtype,
      'photoidimagepath': photoidimagepath,
    };
  }

  factory UserRegister.fromMap(Map<String, dynamic> map) {
    return UserRegister(
      fname: map['fname'] as String,
      mname: map['mname'] as String,
      lname: map['lname'] as String,
      dob: map['dob'] as String,
      gender: map['gender'] as String,
      address: UserAddress.fromMap(map['address'] as Map<String, dynamic>),
      photoidtype: map['photoidtype'] as String,
      photoidimagepath: map['photoidimagepath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRegister.fromJson(String source) =>
      UserRegister.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserRegister(fname: $fname, mname: $mname, lname: $lname, dob: $dob, gender: $gender, address: $address, photoidtype: $photoidtype, photoidimagepath: $photoidimagepath)';
  }

  @override
  bool operator ==(covariant UserRegister other) {
    if (identical(this, other)) return true;

    return other.fname == fname &&
        other.mname == mname &&
        other.lname == lname &&
        other.dob == dob &&
        other.gender == gender &&
        other.address == address &&
        other.photoidtype == photoidtype &&
        other.photoidimagepath == photoidimagepath;
  }

  @override
  int get hashCode {
    return fname.hashCode ^
        mname.hashCode ^
        lname.hashCode ^
        dob.hashCode ^
        gender.hashCode ^
        address.hashCode ^
        photoidtype.hashCode ^
        photoidimagepath.hashCode;
  }
}

class UserAddress {
  String addressline1;
  String addressline2;
  String city;
  String postalCode;
  String country;
  String street;
  String state;
  String longitude;
  String lattittude;
  UserAddress({
    required this.addressline1,
    required this.addressline2,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.street,
    required this.state,
    required this.longitude,
    required this.lattittude,
  });

  UserAddress copyWith({
    String? addressline1,
    String? addressline2,
    String? city,
    String? postalCode,
    String? country,
    String? street,
    String? state,
    String? longitude,
    String? lattittude,
  }) {
    return UserAddress(
      addressline1: addressline1 ?? this.addressline1,
      addressline2: addressline2 ?? this.addressline2,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      street: street ?? this.street,
      state: state ?? this.state,
      longitude: longitude ?? this.longitude,
      lattittude: lattittude ?? this.lattittude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressline1': addressline1,
      'addressline2': addressline2,
      'city': city,
      'postalCode': postalCode,
      'country': country,
      'street': street,
      'state': state,
      'longitude': longitude,
      'lattittude': lattittude,
    };
  }

  factory UserAddress.fromMap(Map<String, dynamic> map) {
    return UserAddress(
      addressline1: map['addressline1'] as String,
      addressline2: map['addressline2'] as String,
      city: map['city'] as String,
      postalCode: map['postalCode'] as String,
      country: map['country'] as String,
      street: map['street'] as String,
      state: map['state'] as String,
      longitude: map['longitude'] as String,
      lattittude: map['lattittude'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAddress.fromJson(String source) =>
      UserAddress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserAddress(addressline1: $addressline1, addressline2: $addressline2, city: $city, postalCode: $postalCode, country: $country, street: $street, state: $state, longitude: $longitude, lattittude: $lattittude)';
  }

  @override
  bool operator ==(covariant UserAddress other) {
    if (identical(this, other)) return true;

    return other.addressline1 == addressline1 &&
        other.addressline2 == addressline2 &&
        other.city == city &&
        other.postalCode == postalCode &&
        other.country == country &&
        other.street == street &&
        other.state == state &&
        other.longitude == longitude &&
        other.lattittude == lattittude;
  }

  @override
  int get hashCode {
    return addressline1.hashCode ^
        addressline2.hashCode ^
        city.hashCode ^
        postalCode.hashCode ^
        country.hashCode ^
        street.hashCode ^
        state.hashCode ^
        longitude.hashCode ^
        lattittude.hashCode;
  }
}
