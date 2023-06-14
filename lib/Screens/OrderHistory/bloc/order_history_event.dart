part of 'order_history_bloc.dart';

@immutable
abstract class OrderHistoryEvent {}

class OrderHistoryStarted extends OrderHistoryEvent {}
