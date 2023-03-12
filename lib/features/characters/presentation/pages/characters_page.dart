import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/common/presentation/blocs/api_page_bloc/api_page_bloc.dart';
import 'package:rick_and_morty/core/common/presentation/widgets/filters_container_widget.dart';
import 'package:rick_and_morty/core/common/presentation/widgets/loading_widget.dart';
import 'package:rick_and_morty/core/common/presentation/widgets/message_display_widget.dart';
import 'package:rick_and_morty/core/common/presentation/widgets/sliver_header_scroll_view.dart';
import 'package:rick_and_morty/features/characters/domain/entities/api_character_data.dart';
import 'package:rick_and_morty/features/characters/domain/entities/character_params.dart';
import 'package:rick_and_morty/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/charaters_grid_widget.dart';
import 'package:rick_and_morty/injection_container.dart' as di;

typedef LoadedCharactersState
    = LoadedApiPageState<ApiCharacterData, CharacterParams>;

typedef ErrorCharactersState = ErrorApiPageState<CharacterParams>;

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  int? _mPage;
  int? _mPagesCount;
  CharacterFilters? _mFilters;

  CharactersBloc bloc(BuildContext context) =>
      BlocProvider.of<CharactersBloc>(context);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di.sl<CharactersBloc>()
        ..add(const FetchDataApiPageEvent(params: CharacterParams(page: 1))),
      child: Builder(builder: (context) {
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: Scaffold(
            body: BlocBuilder<CharactersBloc, ApiPageState>(
              builder: (context, state) {
                if (state is LoadedCharactersState) {
                  _mPage = state.params.page;
                  _mPagesCount = state.response.info.pages;
                  _mFilters = state.params.filters;
                }
                return SliverHeaderScrollView(
                  title: "Characters",
                  currentPage: _mPage,
                  pagesCount: _mPagesCount,
                  onNextPagePressed: _onNextPagePressed(context),
                  onPreviousPagePressed: _onPreviousPagePressed(context),
                  headerWidget: FiltersContainerWidget<CharacterFilters>(
                    filters: _mFilters ?? const CharacterFilters(),
                    onChangeFilter: (filters, isAdd) =>
                        _applyFilters(context, filters, isAdd),
                  ),
                  slivers: [
                    // _filtersContainer(context),
                    _stateToWidget(state),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _stateToWidget(ApiPageState state) {
    if (state is LoadingApiPageState) {
      return const LoadingWidget();
    } else if (state is LoadedCharactersState) {
      return CharactersGridWidget(characters: state.response.results);
    } else if (state is ErrorApiPageState) {
      return MessageDisplayWidget(message: state.message);
    }

    return const LoadingWidget();
  }

  Future<void> _onRefresh(BuildContext context) async =>
      bloc(context).add(RefreshDataApiPageEvent());

  void Function()? _onNextPagePressed(BuildContext context) {
    var currentState = bloc(context).state;

    if (currentState is LoadedCharactersState) {
      if (!currentState.hasReachedMax) {
        return () {
          bloc(context).add(FetchNextApiPageEvent());
        };
      }
    }

    return null;
  }

  void Function()? _onPreviousPagePressed(BuildContext context) {
    var currentState = bloc(context).state;

    if (currentState is LoadedCharactersState) {
      if (!currentState.isFirstPage) {
        return () {
          bloc(context).add(FetchPrevApiPageEvent());
        };
      }
    }

    return null;
  }

  void _applyFilters(BuildContext context, CharacterFilters filters,
      [bool isAdd = true]) {
    _mFilters = filters;
    final currentState = bloc(context).state;
    late CharacterParams params;

    if (currentState is LoadedCharactersState) {
      params = currentState.params;
    } else if (currentState is ErrorCharactersState) {
      params = currentState.params;
    }

    final currentfilters = params.filters ?? const CharacterFilters();

    final newFilters = currentfilters.merge<CharacterFilters>(filters, isAdd)
        as CharacterFilters;

    _mFilters = newFilters;

    bloc(context).add(FetchDataApiPageEvent<CharacterParams>(
      params: params.copyWith(
        page: 1,
        filters: newFilters,
      ),
    ));
  }
}
