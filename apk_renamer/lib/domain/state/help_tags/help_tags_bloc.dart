import 'dart:async';

import 'package:apk_renamer/data/database/pattern_dao.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import '../../../internal/localiz.dart';
import '../../model/pattern_info.dart';
import '../../model/tag_info.dart';
import 'help_tags.dart';

part 'help_tags_bloc.freezed.dart';
part 'help_tags_event.dart';
part 'help_tags_state.dart';

class HelpTagsBloc extends Bloc<HelpTagsEvent, HelpTagsState> {
  HelpTagsBloc(this._isar) : super(const HelpTagsState.initial()) {
    on<_StartedHelpTagsEvent>(_onStartedHelpTagsEvent);
    on<_SavePatternHelpTagsEvent>(_onSavePatternHelpTagsEvent);
    on<_DeleteHelpTagsEvent>(_onDeleteHelpTagsEvent);
    Localiz.l10n.then((l10n) {
      _S = l10n;
    });
  }

  late final AppLocalizations _S;
  final Isar _isar;
  final HelpTags _helpTags = HelpTags();

  Future<List<PatternInfo>> _loadPattern() async {
    final patternDaos = await _isar.patternDaos
        .where()
        .sortByName()
        .findAll();
    final myPatterns = patternDaos
        .map((e) => e.toModel())
        .toList(growable: false);
    return myPatterns;
  }

  FutureOr<void> _onStartedHelpTagsEvent(
      _StartedHelpTagsEvent event, Emitter<HelpTagsState> emit) async {
    _helpTags.init(_S);
    final myPatterns = await _loadPattern();
    emit.call(HelpTagsState.load(
      dateTimeHelp: _helpTags.dateTimeHelp,
      apkHelp: _helpTags.apkHelp,
      myPatterns: myPatterns,
    ));
  }

  Future<void> _updatePatterns(Emitter<HelpTagsState> emit) async {
    final myPatterns = await _loadPattern();
    emit.call(HelpTagsState.updatePatterns(
      myPatterns: myPatterns,
    ));
  }

  FutureOr<void> _onSavePatternHelpTagsEvent(
      _SavePatternHelpTagsEvent event, Emitter<HelpTagsState> emit) async {
    final name = event.name.trim();
    final patternStr = event.pattern.trim();
    if (name.isEmpty || patternStr.isEmpty) {
      return;
    }
    final pattern = PatternDao(
      name: event.name,
      patternStr: event.pattern,
    );
    await _isar.writeTxn(() async {
      await _isar.patternDaos.put(pattern);
    });
    await _updatePatterns(emit);
  }

  FutureOr<void> _onDeleteHelpTagsEvent(
      _DeleteHelpTagsEvent event, Emitter<HelpTagsState> emit) async {
    final id = event.id;
    await _isar.writeTxn(() async {
      await _isar.patternDaos.delete(id);
    });
    await _updatePatterns(emit);
  }
}
