import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/pagination/pagination_notifier.dart';
import 'package:xplore_bg_v2/models/pagination/pagination_state.model.dart';
import 'package:xplore_bg_v2/models/location/place.model.dart';
// import 'package:xplore_bg_v2/presentation/shared/pagination/paginated_list_view.widget%20copy%202.dart';
import 'package:xplore_bg_v2/presentation/shared/pagination/paginated_list_view.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/bookmarks.controller.dart';

class LikedLocationsScreen extends HookConsumerWidget {
  const LikedLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // return RefreshIndicator(
    //   onRefresh: () async {
    //     ref.refresh(likedProvider.notifier);
    //   },
    //   child: PaginatedListViewWidget(),
    // );

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(likedProvider.notifier);
      },
      child: PaginatedListViewWidget<PlaceModel>(
        provider: likedProvider,
        builder: (item) {
          return PlaceListTile(placePreview: item);
        },
      ),
    );

    // return const CustomScrollView(slivers: [
    //   SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
    // ]);

    /* final state = ref.watch(likedProvider);
    return Scaffold(
      body: state.maybeWhen(
        data: (items) {
          return CustomScrollView(slivers: [
            // SliverList(
            //   delegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       return PlaceListTile(placePreview: items[index]);
            //     },
            //     childCount: items.length,
            //   ),
            // )
            // _ListBuilder<PlaceModel>(
            //   items: items,
            //   builder: (item) => PlaceListTile(placePreview: item),
            // ),
            _ItemList<PlaceModel>(
              provider: likedProvider,
              builder: (item) => PlaceListTile(placePreview: item),
            ),
            _NoMoreItems<PlaceModel>(likedProvider),
            _OnGoingBottomWidget<PlaceModel>(provider: likedProvider),
          ]);
        },
        orElse: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ); */

    /* return PaginatedListViewWidget<PlaceModel>(
      paginationProvider: likedProvider,
      builder: (item) {
        return PlaceListTile(placePreview: item);
      },
    );

    final scrollController = useScrollController();
    scrollController.addListener(() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        ref.read(likedProvider.notifier).fetchNextBatch();
      }
    });
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    title: Text("Item >> ${index + 1}"),
                  );
                },
                childCount: 15,
              ),
            ),
            ItemsList(),
            NoMoreItems(),
            OnGoingBottomWidget(),
          ],
        ),
        // child: PaginatedListViewWidget(),
        // child: PaginatedListViewWidget<PlaceModel>(
        //   paginationProvider: likedProvider,
        //   builder: (item) => PlaceListTile(placePreview: item),
        // ),
      ),
    ); */
  }
}

class _ItemList<T> extends ConsumerWidget {
  const _ItemList({
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
          return builder.call(items[index]);
        },
        childCount: items.length,
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

/* class LikedLocationsScreen extends ConsumerWidget {
  const LikedLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(likedLocationsProvider);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(likedLocationsProvider.future),
      child: liked.when(
        data: (data) => ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          itemCount: data.length,
          itemBuilder: (ctx, index) {
            return PlaceListTile(placePreview: data[index]);
          },
          separatorBuilder: (ctx, index) => const SizedBox(height: 2),
        ),
        error: (err, _) => Column(
          children: [
            Text(err.toString()),
            IconButton(
              onPressed: () async => ref.refresh(likedLocationsProvider.future),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        loading: () => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          itemCount: 5,
          itemBuilder: (contex, index) {
            return const PLaceTileLoadingWidget();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15);
          },
        ),
      ),
    );
  }
} */
