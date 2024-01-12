
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class DialogPage<T> extends CustomTransitionPage<T> {
  // final Color? barrierColor;
  // final bool barrierDismissible;
  // final WidgetBuilder builder;
  // final bool useRootNavigator;
  // final RouteTransitionsBuilder transitionBuilder;
  // // final Duration? transitionDuration;
  // final bool dismissWithEsc;
  // final RouteSettings? routeSettings;

  const DialogPage({
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    required super.child,
    super.transitionsBuilder = _defaultTransitionBuilder,
    super.transitionDuration = const Duration(milliseconds: 300),
    super.reverseTransitionDuration = const Duration(milliseconds: 300),
    super.maintainState = true,
    super.fullscreenDialog = true,
    super.opaque = false,
    super.barrierDismissible = false,
    super.barrierColor = const Color(0x8A000000),
    super.barrierLabel,
  });

  static Widget _defaultTransitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: Tween<double>(
            begin: 1,
            end: 0.85,
          ).animate(animation),
          curve: Curves.easeOut,
        ),
        child: child,
      ),
    );

  // @override
  // Route<T> createRoute(BuildContext context) {
  //   // final themes = InheritedTheme.capture(
  //   //   from: context,
  //   //   to: Navigator.of(
  //   //     context,
  //   //     rootNavigator: useRootNavigator,
  //   //   ).context,
  //   // );
  //   return FluentDialogRoute<T>(
  //     context: context,
  //     builder: builder,
  //     barrierColor: barrierColor,
  //     barrierDismissible: barrierDismissible,
  //     barrierLabel: FluentLocalizations.of(context).modalBarrierDismissLabel,
  //     dismissWithEsc: dismissWithEsc,
  //     settings: routeSettings,
  //     transitionBuilder: transitionBuilder,
  //     transitionDuration: transitionDuration ??
  //         FluentTheme.maybeOf(context)?.fastAnimationDuration ??
  //         const Duration(milliseconds: 300),
  //     // themes: themes,
  //   );
  // }
}
