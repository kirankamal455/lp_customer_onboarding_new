class AppURLs {
  AppURLs._();
  //static const String baseUrl = "https://api.usercreation.dokyc.com/";
  static const String baseUrl =
      "https://lp-customer-onboarding.uat-lplusltd.com/";
  // static const String baseUrl = "https://api.usercreation.dokyc.com/";
  // static const String facelivenesApiBaseUrl =
  //     "https://pyapi.usercreation.dokyc.com/";
  static const String facelivenesApiBaseUrl =
      "https://api.faceonlive.dev-lplusltd.com/";
  static const String processDocument = "/auto/validate-doc";

  static const updateDocument = "auto/update-user-input";
  static const addUserPhoneNumber = "user/add-phone";
  static const verifyUserPhoneNumber = "user/verify-phone";
  static const addUserEmail = "user/add-email";
  static const getToken = "user/get/access-token";
  static const addKycInfo = "user/add-kyc-info";
  static const getProfileInfo = "user/get/profile-info";
  static const sendLoginOtp = "user/send/login-otp";
  static const faceVerify = "/auto/validate-photo";
  static const getDocExpiry = "user/get/doc-expiry";
  static const getCustomerOnboardingMode = "user/get/kyc-method";
  static const getLivenssIntructions = "api/Liveness/feature-settings";
}
