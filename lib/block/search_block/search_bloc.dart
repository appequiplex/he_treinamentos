import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:he_treinamentos/block/search_block/search_event.dart';
import 'package:he_treinamentos/block/search_block/search_state.dart';
import 'package:he_treinamentos/data/model/api_result_model.dart';
import 'package:he_treinamentos/data/repositoties/movie_repositories.dart';

class SearchMovieBloc extends Bloc<SearchEvent, SearchMovieState> {
  MovieRepository repository;

  SearchMovieBloc({@required this.repository}) : super(null);

  @override
  // TODO: implement initialState
  SearchMovieState get initialState => SearchMovieInitialState();

  @override
  Stream<SearchMovieState> mapEventToState(SearchEvent event) async* {
    // TODO: implement mapEventToState

    if (event is FetchMovieBySearchEvent) {
      yield SearchMovieLoadingState();
      try {
        List<Results> movies = await repository.getMoviesBySearch(event.query);
        yield SearchMovieLoadedState(movies: movies);
      } catch (e) {
        yield SearchMovieErrorState(message: e.toString());
      }
    }
  }
}
