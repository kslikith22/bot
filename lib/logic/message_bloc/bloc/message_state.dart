part of 'message_bloc.dart';

@immutable
sealed class MessageState extends Equatable {
  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}

final class MessagePostedState extends MessageState {
  final List<MessageModel> messageModel;
  final bool isLoading;
  MessagePostedState({required this.messageModel, required this.isLoading});

  @override
  List<Object> get props => [messageModel, isLoading];
}

final class MessagePostError extends MessageState {
  final String error;
  MessagePostError({required this.error});
  
  @override
  List<Object> get props => [error];
}
