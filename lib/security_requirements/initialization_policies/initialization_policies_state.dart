import 'initialization_policies_changer.dart';

class InitializationPoliciesState {
  static int bootStart = -1;

  setBootStartState() {
    bootStart = InitializationPoliciesChanger.getBootStartDriverPolicy();
  }

}