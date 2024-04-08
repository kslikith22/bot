import 'package:bloc/bloc.dart';
import 'package:bot/data/models/message_model.dart';
import 'package:bot/data/repository/message_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageRepository messageRepository;
  MessageBloc(this.messageRepository) : super(MessageInitial()) {
    on<PostMessageEvent>((event, emit) async {
      await _postMessage(event, emit);
    });
    on<MessagesResetEvent>((event, emit) {
      _resetMessagesState(event, emit);
    });
  }

  void _resetMessagesState(event, emit) {
    emit(MessageInitial());
  }

  Future _postMessage(event, emit) async {
    try {
      if (state is MessagePostedState) {
        var currentState = state as MessagePostedState;
        emit(
          MessagePostedState(
            messageModel: currentState.messageModel +
                [
                  MessageModel(message: event.message, reply: ''),
                ],
            isLoading: true,
          ),
        );
        List<MessageModel> currentMessages =
            List<MessageModel>.from(currentState.messageModel);

        MessageModel newMessage =
            await messageRepository.getReply(message: event.message);
        currentMessages.add(newMessage);
        emit(
          MessagePostedState(messageModel: currentMessages, isLoading: false),
        );
      } else {
        emit(
          MessagePostedState(
            messageModel: [MessageModel(message: event.message, reply: '')],
            isLoading: true,
          ),
        );
        emit(
          MessagePostedState(
            messageModel: [MessageModel(message: event.message, reply: '')],
            isLoading: true,
          ),
        );
        MessageModel newMessage =
            await messageRepository.getReply(message: event.message);

        emit(MessagePostedState(messageModel: [newMessage], isLoading: false));
      }
    } catch (e) {
      emit(MessagePostError(error: e.toString()));
    }
  }
}
