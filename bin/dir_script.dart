import 'dart:io';

Future<void> printDirectoryFiles(Directory dir, int level) async {
  final String indentation = '  ' * level;
  await Future.forEach(await dir.list(recursive: false).toList(),
      (entity) async {
    if (entity is Directory) {
      print('$indentation - ${entity.path}');
      await printDirectoryFiles(entity, level+1);
    } else {
      print('$indentation - ${entity.path}');
    }
  });
}

Future<void> main() async {
  final Directory current = Directory.current;
  await Future.forEach(await current.list(recursive: false).toList(),
      (f) async {
    if (f is Directory) {
      print('- ${f.path}');
      await printDirectoryFiles(f,1);
    }
  });
}
