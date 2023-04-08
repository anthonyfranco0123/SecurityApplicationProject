import 'initialization_policies_changer.dart';

class InitializationPoliciesState {
  static int bootStart = -1;

  Future<void> futureIntToInt() async {
    bootStart = await InitializationPoliciesChanger.getBootStartDriverPolicy();
  }

}