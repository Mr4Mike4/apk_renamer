import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../internal/localiz.dart';
import '../../model/tag_info.dart';
import 'help_tags.dart';

part 'help_tags_bloc.freezed.dart';
part 'help_tags_event.dart';
part 'help_tags_state.dart';

class HelpTagsBloc extends Bloc<HelpTagsEvent, HelpTagsState> {
  HelpTagsBloc() : super(const HelpTagsState.initial()) {
    on<_StartedHelpTagsEvent>(_onStartedHelpTagsEvent);
    Localiz.l10n.then((l10n) {
      _S = l10n;
    });
  }

  late final AppLocalizations _S;
  final HelpTags _helpTags = HelpTags();

  FutureOr<void> _onStartedHelpTagsEvent(_StartedHelpTagsEvent event, Emitter<HelpTagsState> emit) {
    _helpTags.init(_S);
    emit.call(HelpTagsState.load(
      dateTimeHelp: _helpTags.dateTimeHelp,
      apkHelp: _helpTags.apkHelp,
    ));
  }
}
