import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:surf_flutter_summer_school_24/features/features.dart';
import 'package:surf_flutter_summer_school_24/features/image_view/widgets/widgets.dart';
import 'package:surf_flutter_summer_school_24/uikit/uikit.dart';

@RoutePage()
class ImageViewScreen extends StatefulWidget {
  const ImageViewScreen({super.key});

  @override
  State<ImageViewScreen> createState() => _ImageViewScreenState();
}

class _ImageViewScreenState extends State<ImageViewScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ImageViewBloc>(context).add(const ImageViewItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    const expandedHeight = 50.0;
    const fontSize = 20.0;

    return Scaffold(
      body: BlocBuilder<ImageViewBloc, ImageViewState>(
        builder: (context, state) {
          if (state is ImageViewLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ImageViewLoadedState) {
            final items = state.items.items;
            final currentImage =
                items.isNotEmpty ? items[state.activePage] : null;
            return RefreshIndicator(
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surface,
              onRefresh: () async {
                await _refreshScreen(context);
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: expandedHeight,
                    surfaceTintColor: Colors.transparent,
                    centerTitle: true,
                    title: Text(
                      _dateProcessing(currentImage?.created ?? ''),
                      style: const TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    actions: [
                      imageViewAction((state.activePage + 1).toString(),
                          items.length.toString(), fontSize),
                    ],
                  ),
                  const SliverToBoxAdapter(
                    child: ScrollImage(),
                  ),
                ],
              ),
            );
          } else if (state is ImageViewNoConnectionState) {
            return NoConnecting(onRetry: () => _refreshScreen(context));
          } else {
            return NoConnecting(onRetry: () => _refreshScreen(context));
          }
        },
      ),
    );
  }

  Row imageViewAction(
    String imageIndex,
    String allImages,
    double fontSize,
  ) {
    const sizedBoxWidth = 22.0;

    return Row(
      children: [
        Text(
          imageIndex,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          '/$allImages',
          style: TextStyle(
            color: Colors.grey,
            fontSize: fontSize,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(width: sizedBoxWidth),
      ],
    );
  }

  String _dateProcessing(String date, [String dateFormat = 'yyyy.MM.dd']) {
    final DateFormat formatter = DateFormat(dateFormat);
    final formattedDate = DateTime.parse(date);
    return formatter.format(formattedDate).toString();
  }

  Future<void> _refreshScreen(BuildContext context) async {
    final imageViewBloc = BlocProvider.of<ImageViewBloc>(context);
    final completer = Completer<void>();
    imageViewBloc.add(ImageViewItemsEvent(completer: completer));
    await completer.future;
  }
}
