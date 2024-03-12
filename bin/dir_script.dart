import 'dart:io';

Future<void> printDirectoryFiles(Directory dir, int level) async {
  final String indentation = '  ' * level;
  await Future.forEach(await dir.list(recursive: false).toList(),
      (entity) async {
    print('$indentation - ${entity.path}');
    if (entity is Directory) {
      await printDirectoryFiles(entity, level + 1);
    }
  });
}

Future<void> main() async {
  final Directory current = Directory.current;
  await Future.forEach(await current.list(recursive: false).toList(),
      (f) async {
    print('- ${f.path}');
    if (f is Directory) {
      await printDirectoryFiles(f, 1);
    }
  });
}
