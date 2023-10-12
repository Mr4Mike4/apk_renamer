import 'package:fluent_ui/fluent_ui.dart';

import '../../../data/model/file_info.dart';

class ApkTableItem extends StatelessWidget {
  const ApkTableItem({
    super.key,
    required this.fileInfo,
  });

  final FileInfo fileInfo;

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
        ],
      ),
    );
  }
}
