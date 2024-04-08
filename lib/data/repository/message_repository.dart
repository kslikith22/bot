import 'package:bot/core/secrets.dart';
import 'package:bot/data/models/message_model.dart';
import 'package:bot/data/repository/api/api.dart';
import 'package:dio/dio.dart';

class MessageRepository {
  Future getReply({required String message}) async {
    API api = API();
    final response = await api.sendRequest.get(
      '/reply',
      data: {'message': message},
      options: Options(
        headers: {
          'authorization': Secrets.secret,
        },
      ),
    );
    print(response.toString());
    return MessageModel.fromJson(response.data);
  }
}
