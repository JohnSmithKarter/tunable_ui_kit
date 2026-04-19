import 'package:flutter/material.dart';

import 'tui_notification_types.dart';

/// A compact, snack-like notification banner.
///
/// This widget is used as a default notification UI inside `TUINotifications`.
/// For full layout control, pass a `builder` to `TUINotifications.show()`.
class TUINotificationBanner extends StatelessWidget {
  const TUINotificationBanner({
    required this.message,
    required this.onClose,
    super.key,
    this.actionText,
    this.onAction,
    this.showCloseIcon = true,
    this.style,
  });

  /// Notification message.
  final String message;

  /// Optional action label.
  final String? actionText;

  /// Optional action callback.
  final VoidCallback? onAction;

  /// Whether to show the close icon.
  final bool showCloseIcon;

  /// Close callback.
  final VoidCallback onClose;

  /// Style overrides for the banner.
  ///
  /// If null, default values derived from the current theme are used.
  final TUINotificationStyle? style;

  /// Resolves background color for the banner.
  Color _backgroundColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return style?.backgroundColor ?? scheme.surfaceContainerHighest;
  }

  /// Resolves foreground color for text and icons.
  Color _foregroundColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return style?.foregroundColor ?? scheme.onSurface;
  }

  @override
  Widget build(BuildContext context) {
    final bg = _backgroundColor(context);
    final fg = _foregroundColor(context);

    final icon = style?.icon;
    final iconColor = style?.iconColor ?? fg;
    final iconSize = style?.iconSize ?? 20.0;
    final borderRadius = style?.borderRadius ?? BorderRadius.circular(14);
    final boxShadow = style?.boxShadow ??
        const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ];
    final constraints = style?.constraints ??
        const BoxConstraints(minHeight: 48, maxWidth: 520);
    final padding = style?.padding ??
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        );

    final messageTextStyle = style?.messageTextStyle ??
        TextStyle(
          color: fg,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        );

    final maxLines = style?.maxLines ?? 2;
    final overflow = style?.overflow ?? TextOverflow.ellipsis;

    final actionButtonStyle = style?.actionButtonStyle ??
        TextButton.styleFrom(
          foregroundColor: fg,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          visualDensity: VisualDensity.compact,
        );

    final actionTextStyle =
        style?.actionTextStyle ?? const TextStyle(fontWeight: FontWeight.w700);

    final closeIcon = style?.closeIcon ?? Icons.close;
    final closeIconColor = style?.closeIconColor ?? fg;

    return Material(
      color: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
        ),
        child: ConstrainedBox(
          constraints: constraints,
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: iconColor, size: iconSize),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    message,
                    maxLines: maxLines,
                    overflow: overflow,
                    style: messageTextStyle,
                  ),
                ),
                if (actionText != null && onAction != null) ...[
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: onAction,
                    style: actionButtonStyle,
                    child: Text(
                      actionText!,
                      style: actionTextStyle,
                    ),
                  ),
                ],
                if (showCloseIcon) ...[
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: onClose,
                    icon: Icon(closeIcon, color: closeIconColor, size: 18),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
