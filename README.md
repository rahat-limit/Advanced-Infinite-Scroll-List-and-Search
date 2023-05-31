# Infinite Scroll List and Search
<p align="center">
<img src="https://mobx.netlify.app/mobx.svg" with=200>
</p>

<p align="center">
  <img src = "https://github.com/rahat-limit/Advanced-Infinite-Scroll-List-and-Search/blob/master/git_assets/main.png" width=200>
   <img src = "https://github.com/rahat-limit/Advanced-Infinite-Scroll-List-and-Search/blob/master/git_assets/search.png" width=200>
</p>

# Packages

```yaml
dependencies:
  flutter:
    sdk: flutter
  mobx: ^2.1.4
  flutter_mobx: ^2.0.6+5
  dio: ^5.1.2
  provider: ^6.0.5
  synchronized: ^3.1.0
  equatable: ^2.0.5
  
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.3.3
  mobx_codegen: ^2.2.0

  flutter_lints: ^2.0.0
```

# Main Screen
## Synchronized request and Track of max Scroll Load

```dart
final ScrollController _controller = ScrollController();
  var lock = Lock();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data_controller = Provider.of<SiProvider>(context);
    when((p0) => data_controller!.getData.isEmpty, () async {
      // Request Data from api
      await data_controller!.requestData();
    });
    _controller.addListener(() async {
      await lock.synchronized(() async {
        if (_controller.position.pixels >
            _controller.position.maxScrollExtent) {
          if (data_controller!.getSearch.isEmpty) {
            await Future.delayed(const Duration(seconds: 2), () {
              data_controller!.requestData();
            });
          }
        }
      });
    });
  }
```
## Priority of list presentation

* Search
* List Data
```dart
if (search.isEmpty) {
  currentData = data;
} else {
  currentData = search;
}
```
## List View

```dart
return ListView.builder(
    controller: _controller,
    itemCount: currentData.length + 1,
    // (search.isEmpty ? data.length : search.length) + 1,
    itemBuilder: (context, index) {
      // final def_data = search.isEmpty ? data : search;
      if (index == currentData.length) {
        return loading
            ? const Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const SizedBox();
      } else {
        return ListItem(user: currentData[index]);
      }
    },
  );
```

## API Service

```dart

const String path = 'https://dummyjson.com/users';

class ApiService {
  final dio = Dio();
  List<User> list = [];
  getData({required int page, int posts_per_page = 20}) async {
    final res = await dio.get(path);
    final int pages = page * posts_per_page;
    List<dynamic> data = res.data['users'];

    if (res.statusCode == 200) {
      if (pages > data.length) {
        if (pages - data.length > 0 && pages - posts_per_page <= data.length) {
          // Some elements still in ApiServer
          for (var elem
              in data.sublist(max(pages - posts_per_page, 0), data.length)) {
            final user = User.fromJson(elem as Map<String, dynamic>);
            list.add(user);
          }
          return list;
        } else {
          // No elements left in ApiServer
          return null;
        }
      } else {
        for (var elem
            in data.sublist(max(posts_per_page * (page - 1), 0), pages)) {
          final user = User.fromJson(elem as Map<String, dynamic>);
          list.add(user);
        }
        return list;
      }
    } else {
      return null;
    }
  }
}
```

## Provider

```dart

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
```
