import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

class JsonDbService {
  static final JsonDbService _instance = JsonDbService._internal();
  factory JsonDbService() => _instance;
  JsonDbService._internal();

  File? _file;
  Map<String, dynamic> _cache = {};

  Future<void> init({String fileName = 'data.json'}) async {
    // 1. Get the path of the running executable (e.g., C:/MyGames/MyApp/myapp.exe)
    String exePath = Platform.resolvedExecutable;
    
    // 2. Get the directory of the executable (e.g., C:/MyGames/MyApp/)
    String appDir = p.dirname(exePath);

    // 3. Define your custom sub-folder: "app/db/"
    String dbFolderPath = p.join(appDir, 'app', 'db');
    
    // 4. Create the directory if it doesn't exist
    final directory = Directory(dbFolderPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true); // Creates 'app' and 'db' folders
    }

    // 5. Create the full file path
    final filePath = p.join(dbFolderPath, fileName);
    _file = File(filePath);

    // 6. Create or Load the file
    if (!await _file!.exists()) {
      await _file!.create();
      await _file!.writeAsString(jsonEncode({}));
    } else {
      await _loadFile();
    }
  }

  // --- The rest of the code remains exactly the same ---

  Future<void> _loadFile() async {
    try {
      final content = await _file!.readAsString();
      if (content.isEmpty) {
        _cache = {};
      } else {
        _cache = jsonDecode(content);
      }
    } catch (e) {
      _cache = {};
    }
  }

  Future<void> _saveFile() async {
    try {
      final encoder = JsonEncoder.withIndent('  ');
      await _file!.writeAsString(encoder.convert(_cache));
    } catch (e) {
      // Handle error if needed
    }
  }

  Future<void> write(String key, dynamic value) async {
    _cache[key] = value;
    await _saveFile();
  }

  dynamic read(String key) => _cache[key];

  Map<String, dynamic> getAll() => _cache;

  Future<void> remove(String key) async {
    _cache.remove(key);
    await _saveFile();
  }

  Future<void> clear() async {
    _cache.clear();
    await _saveFile();
  }
}