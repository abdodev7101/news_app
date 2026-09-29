abstract class HomeState{}
 class HomeInitialState extends HomeState{}
 class ChangeSourceState extends HomeState{}


 class GetNewsLoadingState extends HomeState{}
 class GetNewsSuccessState extends HomeState{}
 class GetNewsErrorState extends HomeState{
  final String error;
  GetNewsErrorState(this.error);
}

