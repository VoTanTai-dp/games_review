import 'package:pocketbase/pocketbase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

PocketBase? _pocketbase;

Future<PocketBase> getPocketbaseInstance() async {
  if (_pocketbase != null) {
    return _pocketbase!;
  }

  final baseUrl = dotenv.env['POCKETBASE_URL'] ?? 'http://10.0.2.2:8090';
  _pocketbase = PocketBase(baseUrl);

  return _pocketbase!;
}
