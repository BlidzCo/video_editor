import 'package:flutter/material.dart';
import 'package:video_editor/src/controller.dart';
import 'package:video_editor/src/widgets/emoji/emoji_layer.dart';
import 'package:video_editor/src/widgets/text/layer.dart';
import 'package:video_editor/src/widgets/text/text_layer.dart';

/// View stacked layers (unbounded height, width)
class LayersViewer extends StatelessWidget {
  final Function()? onUpdate;
  final bool editable;
  final VideoEditorController videoEditorController;

  const LayersViewer({
    super.key,
    required this.editable,
    this.onUpdate,
    required this.videoEditorController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: videoEditorController.layers.map((layerItem) {
        // // Emoji layer
        if (layerItem is EmojiLayerData) {
          return EmojiLayer(
            videoEditorController: videoEditorController,
            layerData: layerItem,
            onUpdate: onUpdate,
            editable: editable,
          );
        }

        // Text layer
        if (layerItem is TextLayerData) {
          return TextLayer(
            videoEditorController: videoEditorController,
            layerData: layerItem,
            onUpdate: onUpdate,
            editable: editable,
          );
        }

        // Blank layer
        return Container();
      }).toList(),
    );
  }
}
