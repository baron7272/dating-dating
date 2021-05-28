import 'package:dating/model/user.dart';
import 'package:scoped_model/scoped_model.dart';


User _profile;

mixin ConnectPodModel on Model {
}

mixin UserModel on ConnectPodModel {
    User get user => _profile;

  User setUser(Map<String, dynamic> user) {
    _profile = User.fromJson(user);
    notifyListeners();
    return _profile;
  }

}

mixin HomeModel on ConnectPodModel {
}

mixin CommentModel on ConnectPodModel {
}

mixin TransactionModel on ConnectPodModel {
}

mixin NotifyModel on ConnectPodModel { 
}

mixin ConfigModel on ConnectPodModel {


  void logout() {

  }
}
