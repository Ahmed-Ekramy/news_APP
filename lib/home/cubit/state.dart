import 'dart:html';

abstract class HomeState {}

class HomeInitState extends HomeState {}
class HomeChangeSource extends HomeState {}

class HomeGetSourceLoadingState extends HomeState {}
class HomeOnDrawerClickState extends HomeState {
}
class HomeOnCategorySelectState extends HomeState {}
class HomeOnSearch extends HomeState {
}

class HomeGetSourceSuccessState extends HomeState {}

class HomeGetSourceErrorState extends HomeState {
  String error;

  HomeGetSourceErrorState(this.error);
}

class HomeGetNewsLoadingState extends HomeState {}

class HomeGetNewsSuccessState extends HomeState {}

class HomeGetNewsErrorState extends HomeState {
  String error;

  HomeGetNewsErrorState(this.error);
}