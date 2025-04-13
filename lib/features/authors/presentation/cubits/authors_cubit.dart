import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/usecases/get_authors.dart';
import 'package:foursquare_ebbok_app/features/authors/domain/usecases/get_single_author.dart';
import 'package:foursquare_ebbok_app/features/authors/presentation/models/authors_model.dart';

part 'authors_state.dart';

class AuthorsCubit extends Cubit<AuthorsState> {
  AuthorsCubit({
    required GetAuthors getAuthors,
    required GetSingleAuthor getSingleAuthor,
  })  : _getAuthors = getAuthors,
        _getSingleAuthor = getSingleAuthor,
        super(AuthorsInitial());

  final GetAuthors _getAuthors;
  final GetSingleAuthor _getSingleAuthor;

  Future<void> authorScreenEvent(AuthorsModel model) async {
    emit(
      AuthorScreenState(model),
    );
  }

  Future<void> getAuthorsEvent() async {
    final model = state.model;
    final model1 = model.getAuthorsNetworkModel;

    emit(
      AuthorScreenState(
        model.copyWith(
          getAuthorsNetworkModel: model1.copyWith(
            loading: true,
            error: '',
          ),
        ),
      ),
    );

    final result = await _getAuthors();

    result.fold(
      (l) => emit(
        AuthorScreenState(
          model.copyWith(
            getAuthorsNetworkModel: model1.copyWith(
              loading: false,
              loaded: false,
              error: l.errorMessage,
            ),
          ),
        ),
      ),
      (r) => emit(
        AuthorScreenState(
          model.copyWith(
            getAuthorsNetworkModel: model1.copyWith(
              loading: false,
              loaded: true,
              error: '',
              authors: r,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getSingleAuthorEvent(String id) async {
    final model = state.model;
    final model2 = model.getSingleAuthorNetworkModel;

    emit(
      AuthorScreenState(
        model.copyWith(
          getSingleAuthorNetworkModel: model2.copyWith(
            loading: true,
            loaded: false,
            error: '',
          ),
        ),
      ),
    );

    final result = await _getSingleAuthor(id);

    result.fold(
      (l) => emit(
        AuthorScreenState(
          model.copyWith(
            getSingleAuthorNetworkModel: model2.copyWith(
              loading: false,
              loaded: false,
              error: l.errorMessage,
            ),
          ),
        ),
      ),
      (r) => emit(
        AuthorScreenState(
          model.copyWith(
            getSingleAuthorNetworkModel: model2.copyWith(
              loading: false,
              loaded: true,
              error: '',
              author: r,
            ),
          ),
        ),
      ),
    );
  }
}
