import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_summer_school_24/domain/model/item_model.dart';
import 'package:surf_flutter_summer_school_24/features/tape/bloc/tape_bloc.dart';
import 'package:surf_flutter_summer_school_24/router/router.dart';

class ImageBox extends StatefulWidget {
  const ImageBox({super.key});

  @override
  State<ImageBox> createState() => _ImageBoxState();
}

class _ImageBoxState extends State<ImageBox> {
  @override
  Widget build(BuildContext context) {
    const padding = 2.0;

    return BlocBuilder<TapeBloc, TapeState>(
      builder: (context, state) {
        if (state is TapeLoadingState) {
          return const SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is TapeLoadedState) {
          final items = state.items.items;
          return SliverPadding(
            padding: const EdgeInsets.all(
              padding,
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 1.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      context.router.push(const ImageViewRoute());
                    },
                    child: _baseImageBox(items, index),
                  );
                },
                childCount: items.length,
              ),
            ),
          );
        } else if (state is TapeFailureState) {
          return _errorTitle();
        } else {
          return const SliverFillRemaining(
            child: SizedBox.shrink(),
          );
        }
      },
    );
  }

  ClipRRect _baseImageBox(
    List<ItemModel> items,
    int index, [
    double borderRadius = 8,
    String placeholder = './assets/images/placeholder.png',
    int duration = 300,
  ]) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: FadeInImage.assetNetwork(
        placeholder: placeholder,
        image: items[index].file,
        fit: BoxFit.cover,
        fadeInDuration: Duration(milliseconds: duration),
        fadeOutDuration: Duration(milliseconds: duration),
      ),
    );
  }

  SliverFillRemaining _errorTitle([
    String title = 'Ошибка при загрузке изображения',
  ]) {
    return SliverFillRemaining(
      child: Center(
        child: Text(title),
      ),
    );
  }
}
