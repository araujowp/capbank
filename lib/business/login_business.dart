import 'package:capbank/service/user/user_dto.dart';
import 'package:capbank/service/user/user_service.dart';

class LoginBusiness {
  final UserService userService = UserService();

  Future<UserDTO> login(String email, String password) async {
    String uuid = await userService.login(email, password);

    UserDTO user = await userService.getUser(uuid);

    return user;
  }
}
