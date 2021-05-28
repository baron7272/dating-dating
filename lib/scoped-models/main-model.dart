import 'package:scoped_model/scoped_model.dart';

import './connected-models.dart';

class MainModel extends Model
with
ConnectPodModel,
ConfigModel,
UserModel,
NotifyModel,
HomeModel,
CommentModel,
TransactionModel
{}