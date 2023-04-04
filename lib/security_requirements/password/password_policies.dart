import 'registry_access.dart';

class PasswordPolicies {
  static int pwHist = -1;
  static int maxPwAge = -1;
  static int minLength = -1;
  static int maxLength = -1;
  static int upperCase = -1;
  static int lowerCase = -1;
  static int special = -1;

  Future<void> getPwHist() async {
    pwHist = await RegistryAccess.getPwHist();
  }
  Future<void> getMaxPwAge() async {
    pwHist = await RegistryAccess.getPwAge();
  }
  Future<void> getPwMinLen() async {
    pwHist = await RegistryAccess.getMinPwLen();
  }
  Future<void> getPwMaxLen() async {
    pwHist = await RegistryAccess.getMaxPwLen();
  }
  Future<void> getUpperCase() async {
    pwHist = await RegistryAccess.getUpperCaseSetting();
  }
  Future<void> getLowerCase() async {
    pwHist = await RegistryAccess.getLowerCaseSetting();
  }
  Future<void> getSpecial() async {
    pwHist = await RegistryAccess.getSpecialCharSetting();
  }
}