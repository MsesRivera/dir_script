import 'dart:io';

Future<void> printDirectoryFiles(Directory dir, int level) async {
  final String indentation = '  ' * level;
  final List<FileSystemEntity> entities =
      await dir.list(recursive: false).toList();

  final List<Directory> directories = entities.whereType<Directory>().toList();
  directories.sort((a, b) => a.path.compareTo(b.path));

  await Future.forEach(directories, (entity) async {
    print('$indentation - ${entity.path}');
    await printDirectoryFiles(entity, level + 1);
  });

  final List<File> files = entities.whereType<File>().toList();
  files.sort((a, b) => a.path.compareTo(b.path));
  await Future.forEach(files, (entity) async {
    print('$indentation - ${entity.path}');
  });
}

Future<void> main() async {
  final Directory current = Directory.current;

  final List<FileSystemEntity> entities =
      await current.list(recursive: false).toList();

  final List<Directory> directories = entities.whereType<Directory>().toList();

  await Future.forEach(directories, (entity) async {
    print('- ${entity.path}');
    await printDirectoryFiles(entity,1);
  });

  final List<File> files = entities.whereType<File>().toList();

  files.sort((a, b) => a.path.compareTo(b.path));
  await Future.forEach(files, (entity) async {
    print('- ${entity.path}');
  });
}
