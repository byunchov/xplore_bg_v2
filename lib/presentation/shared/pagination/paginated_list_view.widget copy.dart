import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/pagination/pagination_notifier.dart';
import 'package:xplore_bg_v2/models/pagination/pagination_state.model.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PaginatedListViewWidget<T> extends HookConsumerWidget {
  const PaginatedListViewWidget({
    Key? key,
    required this.paginationProvider,
    required this.builder,
  }) : super(key: key);
  final AutoDisposeStateNotifierProvider<PaginationNotifier<T>, PaginationState<T>>
      paginationProvider;
  final Widget Function(T item) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      final delta = MediaQuery.of(context).size.width * 0.20;
      if (maxScroll - currentScroll <= delta) {
        ref.read(paginationProvider.notifier).fetchNextBatch();
      }
    });

    return CustomScrollView(
      controller: scrollController,
      restorationId: "items List",
      slivers: [
        _ItemList<T>(provider: paginationProvider, builder: builder),
        _NoMoreItems(paginationProvider),
        _OnGoingBottomWidget(provider: paginationProvider),
      ],
    );
  }
}

class _ItemList<T> extends ConsumerWidget {
  const _ItemList({
    Key? key,
    required this.provider,
    required this.builder,
  }) : super(key: key);
  final AutoDisposeStateNotifierProvider<PaginationNotifier<T>, PaginationState<T>> provider;
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
      loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
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
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          // return builder.call(items[index]);
          return Container();
        },
        childCount: items.length,
      ),
    );
  }
}

class _NoMoreItems extends ConsumerWidget {
  const _NoMoreItems(this.provider, {Key? key}) : super(key: key);
  final AutoDisposeStateNotifierProvider<PaginationNotifier, PaginationState> provider;

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

class _OnGoingBottomWidget extends ConsumerWidget {
  const _OnGoingBottomWidget({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final AutoDisposeStateNotifierProvider<PaginationNotifier, PaginationState> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    return SliverPadding(
      padding: const EdgeInsets.all(40),
      sliver: SliverToBoxAdapter(
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
      ),
    );
  }
}
