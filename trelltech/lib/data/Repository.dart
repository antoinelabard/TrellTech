import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class Repository {
  Future<http.Response> fetchAlbum() {
    return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  }
}
Future<void> main() async {
  var repo = Repository();
  print(await repo.fetchAlbum().then((res) => res.body));
}