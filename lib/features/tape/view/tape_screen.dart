import 'dart:async';
import 'dart:io';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:surf_flutter_summer_school_24/features/features.dart';
import 'package:surf_flutter_summer_school_24/features/tape/widgets/widgets.dart';
import 'package:surf_flutter_summer_school_24/uikit/uikit.dart';

@RoutePage()
class TapeScreen extends StatefulWidget {
  const TapeScreen({super.key});

  @override
  State<TapeScreen> createState() => _TapeScreenState();
}

class _TapeScreenState extends State<TapeScreen> {
  @override
  void initState() {
    super.initState();
    final tapeBloc = BlocProvider.of<TapeBloc>(context);
    tapeBloc.add(const TapeInit(path: ''));
  }

  @override
  Widget build(BuildContext context) {
    const logoPath = './assets/images/logo.png';
    const cameraPath = './assets/icons/camera.svg';
    const pointsPath = './assets/icons/points.svg';
    const cameraIconSize = 32.0;
    const expandedHeight = 50.0;
    const padding = 8.0;

    return Scaffold(
      body: BlocBuilder<TapeBloc, TapeState>(
        builder: (context, state) {
          if (state is TapeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TapeLoadedState) {
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
                    centerTitle: true,
                    title: _baseIcon(logoPath, context),
                    leading: IconButton(
                      onPressed: _onClickCamera,
                      icon: SvgPicture.asset(
                        cameraPath,
                        width: cameraIconSize,
                        height: cameraIconSize,
                        // ignore: deprecated_member_use
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    actions: [
                      IconButton(
                        onPressed: _showBottomSheet,
                        icon: _baseIcon(pointsPath, context),
                      ),
                    ],
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.all(padding),
                    sliver: ImageBox(),
                  ),
                ],
              ),
            );
          } else if (state is TapeNoConnectionState) {
            return NoConnecting(onRetry: () => _refreshScreen(context));
          } else if (state is TapeFailureState) {
            return NoConnecting(onRetry: () => _refreshScreen(context));
          } else {
            return NoConnecting(onRetry: () => _refreshScreen(context));
          }
        },
      ),
    );
  }

  Image _baseIcon(String imagePath, BuildContext context) {
    return Image.asset(
      imagePath,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  void _showBottomSheet([
    double heightFactor = 0.4,
    double padding = 10,
  ]) {
    const topHeight = 15.0;
    const lowHeight = 15.0;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: heightFactor,
          child: Container(
            padding: EdgeInsets.all(padding),
            child: Column(
              children: [
                const SizedBox(height: topHeight),
                const ThemeButton(),
                const SizedBox(height: lowHeight),
                UploadButton(
                  onClickGallery: _onClickGallery,
                  onClickCamera: _onClickCamera,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _getImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final imageFromGallery =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFromGallery != null) {
      final file = File(imageFromGallery.path);
      final completer = Completer<void>();
      final fileName = imageFromGallery.name;

      // ignore: use_build_context_synchronously
      BlocProvider.of<TapeBloc>(context, listen: false).add(
        UploadImageEvent(
          path: file.path,
          fileName: fileName,
          completer: completer,
        ),
      );

      await completer.future;
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  void _onClickGallery() {
    _getImageFromGallery(context);
  }

  void _onClickCamera() {
    _getImageFromCamera(context);
  }

  Future<void> _getImageFromCamera(BuildContext context) async {
    final picker = ImagePicker();
    final imageFromCamera = await picker.pickImage(source: ImageSource.camera);
    if (imageFromCamera != null) {
      final file = File(imageFromCamera.path);
      final completer = Completer<void>();
      final fileName = imageFromCamera.name;

      // ignore: use_build_context_synchronously
      BlocProvider.of<TapeBloc>(context, listen: false).add(
        UploadImageEvent(
          path: file.path,
          fileName: fileName,
          completer: completer,
        ),
      );

      await completer.future;
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future<void> _refreshScreen(BuildContext context) async {
    final tapeBloc = BlocProvider.of<TapeBloc>(context);
    final completer = Completer<void>();
    tapeBloc.add(TapeInit(completer: completer, path: ''));
    await completer.future;
  }
}
