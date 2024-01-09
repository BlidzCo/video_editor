import 'package:flutter/material.dart';

/// Layer class with some common properties
class Layer {
  Offset offset;
  late double rotation, scale, opacity;

  Layer({
    this.offset = const Offset(64, 64),
    this.opacity = 1,
    this.rotation = 0,
    this.scale = 1,
  });

  copyFrom(Map json) {
    offset = Offset(json['offset'][0], json['offset'][1]);
    opacity = json['opacity'];
    rotation = json['rotation'];
    scale = json['scale'];
  }

  static Layer fromJson(Map json) {
    switch (json['type']) {
      case 'EmojiLayer':
        return EmojiLayerData.fromJson(json);
      case 'TextLayer':
        return TextLayerData.fromJson(json);
      default:
        return Layer();
    }
  }

  Map toJson() {
    return {
      'offset': [offset.dx, offset.dy],
      'opacity': opacity,
      'rotation': rotation,
      'scale': scale,
    };
  }
}

/// Attributes used by [EmojiLayer]
class EmojiLayerData extends Layer {
  String text;
  double size;

  EmojiLayerData({
    this.text = '',
    this.size = 64,
    super.offset,
    super.opacity,
    super.rotation,
    super.scale,
  });

  static EmojiLayerData fromJson(Map json) {
    var layer = EmojiLayerData(
      text: json['text'],
      size: json['size'],
    );

    layer.copyFrom(json);
    return layer;
  }

  @override
  Map toJson() {
    return {
      'type': 'EmojiLayer',
      'text': text,
      'size': size,
      ...super.toJson(),
    };
  }
}

/// Attributes used by [TextLayer]
class TextLayerData extends Layer {
  String text;
  double size;
  Color color, background;
  double backgroundOpacity;
  TextAlign align;

  TextLayerData({
    required this.text,
    this.size = 64,
    this.color = Colors.white,
    this.background = Colors.transparent,
    this.backgroundOpacity = 0,
    this.align = TextAlign.left,
    super.offset,
    super.opacity,
    super.rotation,
    super.scale,
  });

  static TextLayerData fromJson(Map json) {
    var layer = TextLayerData(
      text: json['text'],
      size: json['size'],
      color: Color(json['color']),
      background: Color(json['background']),
      backgroundOpacity: json['backgroundOpacity'],
      align: TextAlign.values.firstWhere((e) => e.name == json['align']),
    );

    layer.copyFrom(json);
    return layer;
  }

  @override
  Map toJson() {
    return {
      'type': 'TextLayer',
      'text': text,
      'size': size,
      'color': color.value,
      'background': background.value,
      'backgroundOpacity': backgroundOpacity,
      'align': align.name,
      ...super.toJson(),
    };
  }
}
