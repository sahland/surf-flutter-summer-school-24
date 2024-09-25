import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_summer_school_24/domain/domain.dart';
import 'package:surf_flutter_summer_school_24/features/features.dart';

class ScrollImage extends StatefulWidget {
  final double height;
  final double verticalPadding;
  const ScrollImage({
    super.key,
    this.height = 600,
    this.verticalPadding = 5,
  });

  @override
  State<ScrollImage> createState() => _ScrollImageState();
}

class _ScrollImageState extends State<ScrollImage> {
  int activePage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageViewBloc, ImageViewState>(
      builder: (context, state) {
        if (state is ImageViewLoadingState) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is ImageViewLoadedState) {
          final items = state.items.items;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: widget.verticalPadding,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: widget.height,
                  child: PageView.builder(
                    itemCount: items.length,
                    pageSnapping: true,
                    controller: _pageController,
                    onPageChanged: (page) {
                      setState(() {
                        activePage = page;
                        BlocProvider.of<ImageViewBloc>(context)
                            .add(ImageViewPageChangedEvent(page));
                      });
                    },
                    itemBuilder: (context, pagePosition) {
                      bool active = pagePosition == activePage;
                      return slider(items, pagePosition, active);
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is ImageViewFailureState) {
          return Center(child: Text(state.error.toString()));
        } else {
          return Container();
        }
      },
    );
  }

  AnimatedContainer slider(
    List<ItemModel> items,
    int pagePosition,
    bool active, [
    int duration = 200,
    double borderRadius = 30,
  ]) {
    double margin = active ? 6 : 25;

    return AnimatedContainer(
      duration: Duration(milliseconds: duration),
      curve: Curves.easeInCubic,
      margin: EdgeInsets.all(margin),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedNetworkImage(
          imageUrl: items[pagePosition].file,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
