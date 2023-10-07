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

  final _replacePatternController = TextEditingController();

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
      // header: const PageHeader(
      //   title: Text('Fluent UI for Flutter Showcase App'),
      // ),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  TextBox(
                    controller: _replacePatternController,
                  ),
                  FilledButton(
                    onPressed: () {
                      _bloc.add(const ApkInfoEvent.openFiles());
                    },
                    child: const Text('Open'),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 3,
            child: BlocBuilder<ApkInfoBloc, ApkInfoState>(
              bloc: _bloc,
              builder: (context, state) {
                List<ApkInfo>? listInfo;
                state.whenOrNull(
                  load: (st) {
                    listInfo = st;
                  },
                );
                // final item = listInfo![index];
                // "",
                // "Исходное",
                // "Переименовано",
                return Table(
                  // border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(64),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                  },
                  children: _rows(listInfo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<TableRow> _rows(List<ApkInfo>? listInfo) {
    final rowList = <TableRow>[];
    rowList.add(TableRow(
      decoration: const BoxDecoration(
      ),
      children: <Widget>[
        SizedBox(),
        TableCell(
          child: Text("Исходное"),
        ),
        const TableCell(
          child: Text("Переименовано",),
        ),
      ],
    ));
    listInfo?.forEach((e) {
      rowList.add(TableRow(
        decoration: const BoxDecoration(
        ),
        children: <Widget>[
          const TableCell(
            child: Checkbox(
              checked: true,
              onChanged: null,
            ),
          ),
          TableCell(
            child: Text(e.file.toString()),
          ),
          const TableCell(
            child: Text('hghghh'),
          ),
        ],
      ));
    });
    return rowList;
  }
}
