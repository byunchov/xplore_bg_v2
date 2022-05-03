import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PaginatedListViewWidget<T> extends HookConsumerWidget {
  const PaginatedListViewWidget({
    Key? key,
    required this.provider,
    required this.builder,
    required this.loadingPlaceholder,
    required this.emptyResultPlaceholder,
    this.errorPlaceholderBuilder,
  }) : super(key: key);
  final dynamic provider;
  final Widget Function(dynamic error)? errorPlaceholderBuilder;
  final Widget Function(T item) builder;
  final Widget loadingPlaceholder;
  final Widget emptyResultPlaceholder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    scrollController.addListener(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      final delta = MediaQuery.of(context).size.height * 0.15;

      final isScrollable = maxScroll > 0;
      // final isAtPosition = (maxScroll == currentScroll);
      final isAtPosition = (maxScroll - currentScroll) <= delta;

      if (isAtPosition && isScrollable) {
        ref.read(provider.notifier).fetchNextBatch();
      }
    });

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        restorationId: "restorationCode",
        slivers: [
          _itemList(context, ref),
          _noMoreItems(context, ref),
          _onGoingBottomWidget(context, ref),
        ],
      ),
    );
  }

  @protected
  Widget _itemList(BuildContext context, WidgetRef ref) {
    final paginationState = ref.watch(provider);
    return paginationState.when(
      data: (items) {
        // return SliverFillRemaining(child: errorPlaceholderBuilder("Error message"));
        if (items.isEmpty) return SliverFillRemaining(child: emptyResultPlaceholder);

        return _ListBuilder<T>(items: items, builder: builder);
      },
      loading: () => SliverFillRemaining(child: loadingPlaceholder),
      error: (e, stk) => SliverFillRemaining(
        child: errorPlaceholderBuilder != null
            ? errorPlaceholderBuilder?.call(e)
            : BlankPage(
                icon: Icons.error_outline_rounded,
                heading: "Error",
                shortText: e.toString(),
              ),
      ),
      onGoingLoading: (items) {
        return _ListBuilder<T>(items: items, builder: builder);
      },
      onGoingError: (items, e, stk) {
        return _ListBuilder<T>(items: items, builder: builder);
      },
    );
  }

  @protected
  Widget _noMoreItems(BuildContext context, WidgetRef ref) {
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

  @protected
  Widget _onGoingBottomWidget(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    return SliverToBoxAdapter(
      child: state.maybeWhen(
        orElse: () => const SizedBox.shrink(),
        onGoingLoading: (items) => const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Center(child: CircularProgressIndicator()),
        ),
        onGoingError: (items, e, _) => Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
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
