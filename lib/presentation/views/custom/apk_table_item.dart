import 'package:fluent_ui/fluent_ui.dart';

import '../../../data/model/file_info.dart';

typedef DelFileInfoCallback = void Function(FileInfo fileInfo);

class ApkTableItem extends StatelessWidget {
  const ApkTableItem({
    super.key,
    required this.fileInfo,
    this.onDelete,
  });

  final FileInfo fileInfo;
  final DelFileInfoCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          const SizedBox(
            width: 64,
            child: Center(
              child: Checkbox(
                checked: true,
                onChanged: null,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(fileInfo.currentFileName ?? ''),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(fileInfo.newFileName ?? ''),
          ),
          SizedBox(
            width: 64,
            child: Center(
              child: IconButton(
                icon: const Icon(FluentIcons.delete, size: 18.0),
                onPressed: () {
                  onDelete?.call(fileInfo);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
