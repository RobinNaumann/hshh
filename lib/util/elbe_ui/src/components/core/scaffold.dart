import 'package:flutter/material.dart' as m;
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/tools.dart';

import 'maybe_hero.dart';

class LeadingIcon {
  final IconData icon;
  final Function(BuildContext context)? onTap;

  const LeadingIcon.back()
      : icon = Icons.chevronLeft,
        onTap = popPage;
  const LeadingIcon.close()
      : icon = Icons.x,
        onTap = popPage;
  const LeadingIcon({required this.icon, this.onTap});
}

class Scaffold extends ThemedWidget {
  final ColorSchemes? scheme;
  final String title;
  final List<Widget>? actions;
  final LeadingIcon? leadingIcon;
  final String? heroTag;
  final Widget? customTitle;
  final Widget body;

  const Scaffold(
      {super.key,
      this.scheme = ColorSchemes.primary,
      required this.title,
      this.customTitle,
      this.actions,
      this.leadingIcon,
      this.heroTag,
      required this.body});

  @override
  Widget make(context, theme) {
    final s = theme.color.activeMode.get(scheme ?? ColorSchemes.primary);

    return m.Scaffold(
      backgroundColor: s.plain.neutral,
      appBar: AppBar(
        toolbarHeight: 50,
        scrolledUnderElevation: 3,
        surfaceTintColor: theme.color.activeScheme.majorAccent.neutral,
        backgroundColor: theme.color.activeLayer.back,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: leadingIcon != null
            ? IconButton.integrated(
                onTap: leadingIcon!.onTap != null
                    ? () => leadingIcon!.onTap?.call(context)
                    : null,
                icon: leadingIcon!.icon)
            : null,
        actions: actions?.isEmpty ?? true
            ? null
            : [
                Padded.only(
                    right: 0.4,
                    child: Row(children: actions!.spaced(amount: 0.4)))
              ],
        title: customTitle ?? Text.h4(title),
      ),
      body: MaybeHero(tag: heroTag, child: body),
    );
  }
}
