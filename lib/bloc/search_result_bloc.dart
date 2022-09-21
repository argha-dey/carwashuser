import 'package:famous_steam_user/Repository/repository.dart';
import 'package:famous_steam_user/model/search_result_model.dart';
import 'package:rxdart/rxdart.dart';

class SearchResultbloc {
  final _searchResultlist = PublishSubject<SearchResultModel>();
  final _repository = Repository();

  Stream<SearchResultModel> get searchResultstream => _searchResultlist.stream;

  Future searchResultsink(String keyword, String lang) async {
    final SearchResultModel Model =
        await _repository.onsearchResultApi(keyword, lang);
    _searchResultlist.sink.add(Model);
  }

  void dispose() {
    _searchResultlist.close();
  }
}

final searchResultbloc = SearchResultbloc();

