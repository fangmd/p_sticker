import 'package:flutter/material.dart';

import 'sticker_c.dart';
import 'sticker_data.dart';

class StickerUtils {
  static bool containSticker(String text) {
    return text.indexOf('[') != -1 && text.indexOf(']') != -1;
  }

  /// 创建图文 Widget
  static Text createRichText(String text, {TextStyle style}) {
    if (!containSticker(text)) return Text(text, style: style);

    List<InlineSpan> core = [];

    while (containSticker(text)) {
      final startIndex = text.indexOf('[');
      final endIndex = text.indexOf(']');

      if (startIndex != 0) {
        core.add(
            TextSpan(text: text.substring(0, startIndex), style: style)); //left
      }

      final stickerName = text.substring(startIndex, endIndex + 1);
      final sticker = getSticker(stickerName);
      if (sticker != null) {
        core.add(WidgetSpan(
          child: Image.asset(
            sticker.img,
            width: 24,
            height: 24,
            package: 'p_sticker',
          ),
        ));
      } else {
        core.add(TextSpan(
            text: text.substring(startIndex, endIndex + 1),
            style: style)); //center
      }

      text = text.substring(endIndex + 1);
    }

    core.add(TextSpan(text: text, style: style)); //end

    return Text.rich(
      TextSpan(children: core),
    );
  }

  static Sticker getSticker(String stickerName) {
    final indexIc = StickerData.emojis.indexOf(stickerName);
    if (indexIc != -1) {
      return Sticker(
          StickerData.emojis[indexIc], StickerData.emojiIcons[indexIc]);
    }

    final indexFace = StickerData.faces01.indexOf(stickerName);
    if (indexFace != -1) {
      return Sticker(
          StickerData.faces01[indexFace], StickerData.face01Icons[indexFace]);
    }

    final indexGif = StickerData.dm_gif_01_names.indexOf(stickerName);
    if (indexGif != -1) {
      return Sticker(StickerData.dm_gif_01_names[indexGif],
          StickerData.dmGifIcon[indexGif]);
    }
    return null;
  }

  static Widget textImg() {
    // return Image.asset(
    //   'sticker/dm_e_03.png',
    //   package: 'p_sticker',
    // );

    List<InlineSpan> core = [];
    final sticker = getSticker('[大哭]');
    core.add(WidgetSpan(
      child: Image.asset(
        sticker.img,
        width: 24,
        height: 24,
        package: 'p_sticker',
      ),
    ));
    return Text.rich(
      TextSpan(children: core),
    );
  }
}
