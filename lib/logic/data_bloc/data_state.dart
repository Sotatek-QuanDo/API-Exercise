part of 'data_bloc.dart';

abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  late List<Post> post;
  DataLoaded(this.post);
}

class DataAdding extends DataState {}

class DataAdded extends DataState {}
