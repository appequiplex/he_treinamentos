import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:he_treinamentos/block/cast_and_crew_bloc/cast_event.dart';
import 'package:he_treinamentos/block/cast_and_crew_bloc/cast_state.dart';
import 'package:he_treinamentos/data/model/api_cast_model.dart';
import 'package:he_treinamentos/data/repositoties/movie_repositories.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  MovieRepository repository;

  CastBloc({@required this.repository}) : super(null);

  @override
  // TODO: implement initialState
  CastState get initialState => CastInitialState();

  @override
  Stream<CastState> mapEventToState(CastEvent event) async* {
    // TODO: implement mapEventToState

    if (event is FetchCastAndCrewEvent) {
      yield CastLoadingState();
      try {
        List<Cast> casts = await repository.getCastList(event.movieId);
        yield CastLoadedState(casts: casts);
      } catch (e) {
        yield CastErrorState(message: e.toString());
      }
    }
  }
}
