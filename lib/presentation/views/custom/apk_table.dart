import 'package:fluent_ui/fluent_ui.dart';

import '../../../data/model/file_info.dart';
import '../../../localizations.dart';

class ApkTable extends StatelessWidget {
  const ApkTable({super.key, this.listInfo});

  final List<FileInfo>? listInfo;

  @override
  Widget build(BuildContext context) {
    // final FluentThemeData theme = FluentTheme.of(context);
    final S = AppLocal.of(context);
    return Table(
      // border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.top,
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(64),
        1: FlexColumnWidth(),
        2: FlexColumnWidth(),
      },
      children: _rows(S),
    );
  }

  List<TableRow> _rows(AppLocalizations S) {
    final rowList = <TableRow>[];
    rowList.add(TableRow(
      // decoration: BoxDecoration(),
      children: <Widget>[
        const SizedBox(),
        TableCell(
          child: Text(S.table_column_name),
        ),
        TableCell(
          child: Text(S.table_column_new_name),
        ),
      ],
    ));
    listInfo?.forEach((e) {
      rowList.add(TableRow(
        decoration: const BoxDecoration(),
        children: <Widget>[
          const TableCell(
            child: Center(
              child: Checkbox(
                checked: true,
                onChanged: null,
              ),
            ),
          ),
          TableCell(
            child: Text(e.currentFileName ?? ''),
          ),
          TableCell(
            child: Text(e.newFileName ?? ''),
          ),
        ],
      ));
    });
    return rowList;
  }
}