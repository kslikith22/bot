part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

class PostMessageEvent extends MessageEvent {
  final String message;
  PostMessageEvent({required this.message});
}


class MessagesResetEvent extends MessageEvent{}