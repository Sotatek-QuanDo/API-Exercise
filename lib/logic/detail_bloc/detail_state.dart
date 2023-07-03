part of 'detail_bloc.dart';

class DetailState {
  const DetailState();
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final Post post;
  const DetailLoaded({required this.post});
}

class DetailEditing extends DetailState {}

class DetailEdited extends DetailState {}

class DetailDeleting extends DetailState {}

class DetailDeleted extends DetailState {}
