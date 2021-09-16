import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:he_treinamentos/block/movie_bloc/movie_state.dart';
import 'package:he_treinamentos/block/movie_bloc/movie_event.dart';
import 'package:he_treinamentos/data/model/api_result_model.dart';
import 'package:he_treinamentos/data/repositoties/movie_repositories.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieRepository repository;

  MovieBloc({@required this.repository}) : super(null);

  @override
  // TODO: implement initialState
  MovieState get initialState => MovieInitialState();

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    // TODO: implement mapEventToState

    if (event is FetchMovieEvent) {
      yield MovieLoadingState();
      try {
        List<Results> movies = await repository.getMovies(event.movieType);
        yield MovieLoadedState(movies: movies);
      } catch (e) {
        yield MovieErrorState(message: e.toString());
      }
    }
  }
}
