import 'package:famous_steam_user/Repository/repository.dart';

import 'package:famous_steam_user/model/category_list_model.dart';
import 'package:rxdart/rxdart.dart';

class CategoryListbloc {
  final _categorylist = PublishSubject<CategoryListModel>();
  final _repository = Repository();

  Stream<CategoryListModel> get categoryliststream => _categorylist.stream;

  Future categorylistsink(String lang) async {
    final CategoryListModel model = await _repository.oncategorylistApi(lang);
    _categorylist.sink.add(model);
  }

  void dispose() {
    _categorylist.close();
  }
}

final categoryListbloc = CategoryListbloc();
