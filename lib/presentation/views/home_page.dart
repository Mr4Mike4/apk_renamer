import 'package:apk_renamer/presentation/views/custom/window_buttons.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import '../../localizations.dart';
import 'custom/confirm_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.child,
    required this.shellContext,
    required this.state,
  });

  final Widget child;
  final BuildContext? shellContext;
  final GoRouterState state;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    // final theme = FluentTheme.of(context);
    if (widget.shellContext != null) {
      if (context.canPop() == false) {
        setState(() {});
      }
    }
    final S = AppLocal.of(context);
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: () {
          return DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(S.app_title),
            ),
          );
        }(),
        actions: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            WindowButtons(),
          ],
        ),
      ),
      content: widget.child,
    );
  }

  @override
  void onWindowClose() {
    windowManager.isPreventClose().then((isPreventClose) {
      if (isPreventClose) {
        showDialog<bool>(
          context: context,
          builder: (context) {
            final S = AppLocal.of(context);
            return ConfirmDialog(
              content: S.app_exit_confirm,
            );
          },
        ).then((result) {
          if (result == true) {
            windowManager.destroy();
          }
        });
      }
    });
  }
}
