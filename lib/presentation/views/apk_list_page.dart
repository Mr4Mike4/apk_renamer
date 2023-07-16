import 'package:apk_renamer/data/repository/apk_info.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/state/apk_info/apk_info_bloc.dart';

class ApkListPage extends StatefulWidget {
  const ApkListPage({
    super.key,
  });

  @override
  State<ApkListPage> createState() => _ApkListPageState();
}

class _ApkListPageState extends State<ApkListPage> {
  late ApkInfoBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ApkInfoBloc();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    final theme = FluentTheme.of(context);
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Fluent UI for Flutter Showcase App'),
      ),
      content: Column(
        children: [
          Expanded(
            child: BlocBuilder<ApkInfoBloc, ApkInfoState>(
              bloc: _bloc,
              builder: (context, state) {
                List<ApkInfo>? listInfo;
                state.whenOrNull(
                  load: (st) {
                    listInfo = st;
                  },
                );
                return ListView.builder(
                  itemCount: listInfo?.length ?? 0,
                  itemBuilder: (context, index) {
                    final item = listInfo![index];
                    return ListTile(
                      title: Text(item.toString()),
                    );
                  },
                );
              },
            ),
          ),
          FilledButton(
            onPressed: () {
              _bloc.add(const ApkInfoEvent.openFiles());
            },
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }
}
