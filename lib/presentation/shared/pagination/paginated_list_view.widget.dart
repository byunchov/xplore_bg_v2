import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/pagination/pagination_notifier.dart';
import 'package:xplore_bg_v2/models/pagination/pagination_state.model.dart';

class PaginatedListViewWidget<T> extends HookConsumerWidget {
  const PaginatedListViewWidget({
    Key? key,
    required this.provider,
    required this.builder,
  }) : super(key: key);
  final StateNotifierProvider<PaginationNotifier<T>, PaginationState<T>> provider;
  final Widget Function(T item) builder;

  //AutoDisposeStateNotifierProvider

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      final delta = MediaQuery.of(context).size.height * 0.20;
      // if (maxScroll == currentScroll) {
      if ((maxScroll - currentScroll) <= delta) {
        ref.read(provider.notifier).fetchNextBatch();
      }
    });

    final paginationState = ref.watch(provider);
    return Scaffold(
      body: paginationState.when(
        data: (items) {
          if (items.isEmpty) {
            return const SliverToBoxAdapter(child: Text("Nothing found!"));
          } else {
            return _ItemList(
              provider: provider,
              builder: builder,
              items: items,
              scrollController: scrollController,
            );
          }
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (e, stk) => Text(e.toString()),
        onGoingLoading: (items) {
          return _ItemList(
            provider: provider,
            builder: builder,
            items: items,
            scrollController: scrollController,
          );
        },
        onGoingError: (items, e, stk) {
          return _ItemList(
            provider: provider,
            builder: builder,
            items: items,
            scrollController: scrollController,
          );
        },
      ),
    );

    /*  return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          _ItemList<T>(provider: paginationProvider, builder: builder),
          _NoMoreItems(paginationProvider),
          _OnGoingBottomWidget(provider: paginationProvider),
        ],
      ),
    ); */
  }
}

class _ItemList<T> extends ConsumerWidget {
  const _ItemList({
    Key? key,
    required this.provider,
    required this.builder,
    required this.items,
    required this.scrollController,
  }) : super(key: key);
  final StateNotifierProvider<PaginationNotifier<T>, PaginationState<T>> provider;
  final Widget Function(T item) builder;
  final List<T> items;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restorationCode = T.hashCode.toString();
    return CustomScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      restorationId: restorationCode,
      slivers: [
        _ListBuilder(items: items, builder: builder),
        _NoMoreItems<T>(provider),
        _OnGoingBottomWidget<T>(provider: provider),
      ],
    );
  }
}

class _ItemList2<T> extends ConsumerWidget {
  const _ItemList2({
    Key? key,
    required this.provider,
    required this.builder,
  }) : super(key: key);
  final StateNotifierProvider<PaginationNotifier<T>, PaginationState<T>> provider;
  final Widget Function(T item) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paginationState = ref.watch(provider);
    return paginationState.when(
      data: (items) {
        if (items.isEmpty) {
          return const SliverToBoxAdapter(child: Text("Nothing found!"));
        } else {
          return _ListBuilder(items: items, builder: builder);
        }
      },
      loading: () {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(height: 15, color: Colors.white);
            },
            childCount: 10,
          ),
        );
      },
      error: (e, stk) => SliverToBoxAdapter(child: Text(e.toString())),
      onGoingLoading: (items) {
        return _ListBuilder(items: items, builder: builder);
      },
      onGoingError: (items, e, stk) {
        return _ListBuilder(items: items, builder: builder);
      },
    );
  }
}

class _ListBuilder<T> extends StatelessWidget {
  const _ListBuilder({
    Key? key,
    required this.items,
    required this.builder,
  }) : super(key: key);

  final List<T> items;
  final Widget Function(T item) builder;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return builder.call(items[index]);
          },
          childCount: items.length,
        ),
      ),
    );
  }
}

class _NoMoreItems<T> extends ConsumerWidget {
  const _NoMoreItems(this.provider, {Key? key}) : super(key: key);
  final StateNotifierProvider<PaginationNotifier<T>, PaginationState<T>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    return SliverToBoxAdapter(
      child: state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          data: (items) {
            final nomoreItems = ref.read(provider.notifier).noMoreItems;
            return nomoreItems
                ? const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "No More Items Found!",
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox.shrink();
          }),
    );
  }
}

class _OnGoingBottomWidget<T> extends ConsumerWidget {
  const _OnGoingBottomWidget({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final StateNotifierProvider<PaginationNotifier<T>, PaginationState<T>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    return SliverToBoxAdapter(
      child: state.maybeWhen(
        orElse: () => const SizedBox.shrink(),
        onGoingLoading: (items) => const Center(child: CircularProgressIndicator()),
        onGoingError: (items, e, _) => Center(
          child: Column(
            children: const [
              Icon(Icons.info),
              SizedBox(height: 20),
              Text(
                "Something Went Wrong!",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
