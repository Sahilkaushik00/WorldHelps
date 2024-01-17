import 'package:worldhelps/user/data/remote/models/user.dart';

import '../../../auth/data/repositories/auth_repository.dart';

class UserRepository {
  UserModel? _userModel;
  final AuthRepository _authRepository = AuthRepository();

  UserModel get getUser => _userModel!;

  Future<void> refreshUser() async {
    try {
      _userModel = await _authRepository.getUserDetails();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
