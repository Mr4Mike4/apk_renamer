import 'dart:async';

import 'package:apk_renamer/data/database/template_dao.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import '../../../internal/localiz.dart';
import '../../model/tag_info.dart';
import '../../model/template_info.dart';
import 'help_tags.dart';

part 'help_tags_bloc.freezed.dart';
part 'help_tags_event.dart';
part 'help_tags_state.dart';

class HelpTagsBloc extends Bloc<HelpTagsEvent, HelpTagsState> {
  HelpTagsBloc(this._isar) : super(const HelpTagsState.initial()) {
    on<_StartedHelpTagsEvent>(_onStartedHelpTagsEvent);
    on<_SaveTemplateHelpTagsEvent>(_onSaveTemplateHelpTagsEvent);
    on<_DeleteHelpTagsEvent>(_onDeleteHelpTagsEvent);
    Localiz.l10n.then((l10n) {
      _S = l10n;
    });
  }

  late final AppLocalizations _S;
  final Isar _isar;
  final HelpTags _helpTags = HelpTags();

  Future<List<TemplateInfo>> _loadTemplate() async {
    final templateDaos = await _isar.templateDaos
        .where()
        .sortByName()
        .findAll();
    final myTemplates = templateDaos
        .map((e) => e.toModel())
        .toList(growable: false);
    return myTemplates;
  }

  FutureOr<void> _onStartedHelpTagsEvent(
      _StartedHelpTagsEvent event, Emitter<HelpTagsState> emit) async {
    _helpTags.init(_S);
    final myTemplates = await _loadTemplate();
    emit.call(HelpTagsState.load(
      dateTimeHelp: _helpTags.dateTimeHelp,
      apkHelp: _helpTags.apkHelp,
      myTemplates: myTemplates,
    ));
  }

  Future<void> _updateTemplates(Emitter<HelpTagsState> emit) async {
    final myTemplates = await _loadTemplate();
    emit.call(HelpTagsState.updateTemplates(
      myTemplates: myTemplates,
    ));
  }

  FutureOr<void> _onSaveTemplateHelpTagsEvent(
      _SaveTemplateHelpTagsEvent event, Emitter<HelpTagsState> emit) async {
    final name = event.name.trim();
    final templateStr = event.template.trim();
    if (name.isEmpty || templateStr.isEmpty) {
      return;
    }
    final template = TemplateDao(
      name: event.name,
      templateStr: event.template,
    );
    await _isar.writeTxn(() async {
      await _isar.templateDaos.put(template);
    });
    await _updateTemplates(emit);
  }

  FutureOr<void> _onDeleteHelpTagsEvent(
      _DeleteHelpTagsEvent event, Emitter<HelpTagsState> emit) async {
    final id = event.id;
    await _isar.writeTxn(() async {
      await _isar.templateDaos.delete(id);
    });
    await _updateTemplates(emit);
  }
}
