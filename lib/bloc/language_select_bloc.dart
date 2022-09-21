/*
import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/language_select_model.dart';
import 'package:rxdart/rxdart.dart';

class LangauageSelectbloc {
  final _langauageslot = PublishSubject<LanguageSelectModel>();
  final _repository = Repository();

  Stream<LanguageSelectModel> get getlangauageselectstream =>
      _langauageslot.stream;

  Future getLangaugeSelectsink() async {
    final LanguageSelectModel Model = await _repository.languasemethod();
    _langauageslot.sink.add(Model);
  }

  void dispose() {
    _langauageslot.close();
  }
}

final langauageSelectbloc = LangauageSelectbloc();
*/
