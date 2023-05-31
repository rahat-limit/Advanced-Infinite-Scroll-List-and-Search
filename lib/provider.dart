import 'package:mobx/mobx.dart';
import 'package:search_and_infinite_list/api_service.dart';
import 'package:search_and_infinite_list/user_model.dart';
part 'provider.g.dart';

class SiProvider = _SiProviderBase with _$SiProvider;

abstract class _SiProviderBase with Store {
  @observable
  ObservableList<User> stateData = ObservableList<User>.of([]);
  @observable
  bool isLoading = false;
  @observable
  int page = 1;

  @observable
  bool isCategory = false;

  // Constant Variables
  final api = ApiService();

  // Computed
  @computed
  List<User> get getData => stateData;

  @computed
  List<User> get getSearch =>
      stateData.where((element) => element.priority == 1).toList();

  // Actions
  @action
  requestData() async {
    isLoading = true;
    var request = await api.getData(page: page);
    if (request is List<User>) {
      stateData.clear();
      stateData.addAll(request);
    }
    page++;
    isLoading = false;
  }

  @action
  search(String key) {
    // To enable isCategories
    // isCategory = !isCategory;
    for (var element in stateData) {
      var newElem = element;
      newElem.priority = 0;
      if (element.name.toLowerCase().contains(key)) {
        newElem.priority = 1;
      }
      int index = stateData.indexOf(element);
      stateData.remove(element);
      stateData.insert(index, newElem);
    }
  }

  @action
  delete(User user) {
    stateData.remove(user);
  }
}
