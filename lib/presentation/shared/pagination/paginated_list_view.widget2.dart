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
    required this.loadingPlaceholder,
    required this.emptyResultPlaceholder,
    required this.errorPlaceholderBuilder,
  }) : super(key: key);
  // final dynamic provider;
  final StateNotifierProvider<PaginationNotifier<T>, PaginationState<T>> provider;
  final Widget Function(dynamic error) errorPlaceholderBuilder;
  final Widget Function(T item) builder;
  final Widget loadingPlaceholder;
  final Widget emptyResultPlaceholder;

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
    final paginationNotifier = ref.watch(provider.notifier);

    return Scaffold(
      body: paginationState.when(
        data: (items) {
          if (items.isEmpty) {
            return loadingPlaceholder;
          }
          return _ItemList<T>(
            provider: provider,
            builder: builder,
            items: items,
            scrollController: scrollController,
          );
        },
        loading: () => loadingPlaceholder,
        error: (e, stk) => errorPlaceholderBuilder(e),
        onGoingLoading: (items) {
          return _ItemList<T>(
            provider: provider,
            builder: builder,
            items: items,
            scrollController: scrollController,
          );
        },
        onGoingError: (items, e, stk) {
          return _ItemList<T>(
            provider: provider,
            builder: builder,
            items: items,
            scrollController: scrollController,
          );
        },
      ),
    );
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
  final Widget Function(T item) builder;
  final dynamic provider;
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
        _OnGoingBottomWidget<T>(provider),
      ],
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
  final dynamic provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    return SliverToBoxAdapter(
      child: state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          data: (items) {
            items as List<T>;
            final bool noMoreItems = ref.read(provider.notifier).noMoreItems;

            if (noMoreItems && items.isNotEmpty) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "No More Items Found!",
                  textAlign: TextAlign.center,
                ),
              );
            }

            return const SizedBox.shrink();
          }),
    );
  }
}

class _OnGoingBottomWidget<T> extends ConsumerWidget {
  const _OnGoingBottomWidget(this.provider, {Key? key}) : super(key: key);
  final dynamic provider;

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
