import 'dart:convert';

import 'package:chomoka/env.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

abstract class BaseModel {
  static Database? _database;
  // Use instance-level where clauses and args to avoid cross-instance
  // accumulation of WHERE conditions which previously caused queries
  // for one model to include conditions intended for another model.
  final List<String> _wheres = [];
  final List<Object?> _whereArgs = [];
  static bool _isInitializing = false;
  static Future<void>? _initializationFuture;

  String get tableName;

  Map<String, String> get columns;

  Map<String, dynamic> toMap();

  BaseModel fromMap(Map<String, dynamic> map);

  static Future<void> ensureDatabaseInitialized() async {
    if (_database != null) {
      return;
    }

    // If initialization is already in progress, wait for it to complete
    if (_isInitializing) {
      await _initializationFuture;
      return;
    }

    // Start initialization
    _isInitializing = true;
    _initializationFuture = _initDatabaseInternal();
    await _initializationFuture;
    _isInitializing = false;
  }

  static Future<void> _initDatabaseInternal() async {
    try {
      if (_database == null) {
        _database = await _initDatabase();
        print('Database initialized successfully');
      }
    } catch (e) {
      print('Error initializing database: $e');
      rethrow;
    }
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, Env.databaseName),
      onCreate: (db, version) async {
        await _createTables(db);
      },
      version: 1,
    );
  }

  static Future<void> _createTables(Database db) async {
    for (var model in _registeredModels) {
      await _createTableIfNotExists(db, model);
    }
  }

  static Future<void> _createTableIfNotExists(
      Database db, BaseModel model) async {
    final columnsDefinition = model.columns.entries.map((entry) {
      final isNullable =
          entry.value.toLowerCase().contains('nullable') ? '' : ' NOT NULL';
      return "${entry.key} ${entry.value.replaceAll('NULLABLE', '').trim()}$isNullable";
    }).join(', ');

    const metaColumns = "created_at TEXT, updated_at TEXT, synced_at TEXT";
    final createTableQuery =
        'CREATE TABLE IF NOT EXISTS ${model.tableName} ($columnsDefinition, $metaColumns)';
    await db.execute(createTableQuery);
  }

  static final List<BaseModel> _registeredModels = [];

  BaseModel() {
    if (!_registeredModels.any((model) => model.runtimeType == runtimeType)) {
      _registeredModels.add(this);
    }
  }

  Future<Database> get _db async {
    await ensureDatabaseInitialized();
    if (_database == null) {
      throw Exception(
          "Database is not initialized. Call initAppDatabase() first.");
    }
    return _database!;
  }

  BaseModel where(String column, String condition, Object? value) {
    _wheres.add('$column $condition ?');
    if (value != null) _whereArgs.add(value);
    return this;
  }

  BaseModel orWhere(String column, String condition, Object? value) {
    if (_wheres.isNotEmpty) {
      _wheres[_wheres.length - 1] =
          "(${_wheres[_wheres.length - 1]} OR $column $condition ?)";
    } else {
      _wheres.add('$column $condition ?');
    }
    if (value != null) _whereArgs.add(value);
    return this;
  }

  Future<BaseModel?> findOne() async {
    final results = await select(limit: 1);
    return results.isNotEmpty ? fromMap(results.first) : null;
  }

  Future<BaseModel?> first() async {
    return await findOne();
  }

  Future<List<BaseModel>> find() async {
    final results = await select();
    return results.map((row) => fromMap(row)).toList();
  }

  Future<List<Map<String, dynamic>>> select({int? limit}) async {
    try {
      final db = await _db;
      await ensureTableExists();
      final results = await db.query(
        tableName,
        where: _compiledWhere.isNotEmpty ? _compiledWhere : null,
        whereArgs: _compiledWhereArgs.isNotEmpty ? _compiledWhereArgs : null,
        limit: limit,
      );
      _clearQuery();
      return results;
    } catch (e) {
      _clearQuery();
      print('Error during select: $e');
      rethrow;
    }
  }

  String get _compiledWhere => _wheres.isNotEmpty ? _wheres.join(' AND ') : '';

  List<Object?> get _compiledWhereArgs => _whereArgs;

  Future<int> delete() async {
    try {
      final db = await _db;
      await ensureTableExists();
      if (_compiledWhere.isEmpty) {
        throw Exception(
            "Delete requires a where clause to prevent deleting all rows.");
      }
      final rowsDeleted = await db.delete(
        tableName,
        where: _compiledWhere,
        whereArgs: _compiledWhereArgs,
      );
      _clearQuery();
      return rowsDeleted;
    } catch (e) {
      _clearQuery();
      print('Error during delete: $e');
      rethrow;
    }
  }

  Future<int> create() async {
    try {
      final db = await _db;
      await ensureTableExists();
      final record = toMap();
      record['created_at'] = DateTime.now().toIso8601String();
      record['updated_at'] = DateTime.now().toIso8601String();
      return await db.insert(
        tableName,
        record,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error during create: $e');
      rethrow;
    }
  }

  Future<int> update(Map<String, dynamic> values) async {
    try {
      final db = await _db;
      await ensureTableExists();
      if (_compiledWhere.isEmpty) {
        throw Exception(
            "Update requires a where clause to prevent updating all rows.");
      }
      if (_wheres.isEmpty || _whereArgs.isEmpty) {
        throw Exception("No conditions provided for update operation.");
      }
      values['updated_at'] = DateTime.now().toIso8601String();
      values['synced_at'] = null;
      final rowsUpdated = await db.update(
        tableName,
        values,
        where: _compiledWhere,
        whereArgs: _compiledWhereArgs,
      );
      _clearQuery();
      return rowsUpdated;
    } catch (e) {
      _clearQuery();
      print('Error during update: $e');
      rethrow;
    }
  }

  Future<void> ensureTableExists() async {
    try {
      final db = await _db;
      final existingTables = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");
      if (existingTables.isEmpty) {
        await _createTableIfNotExists(db, this);
      }
    } catch (e) {
      _clearQuery();
      print('Error checking or creating table $tableName: $e');
      rethrow;
    }
  }

  void _clearQuery() {
    _wheres.clear();
    _whereArgs.clear();
  }

  Future<int> count() async {
    try {
      final db = await _db;
      await ensureTableExists();
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $tableName WHERE ${_compiledWhere.isNotEmpty ? _compiledWhere : '1=1'}',
        _compiledWhereArgs,
      );
      _clearQuery();
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      print('Error during count: $e');
      rethrow;
    }
  }

  static Future<void> initAppDatabase() async {
    await ensureDatabaseInitialized();
  }

  Future<void> syncAllTables() async {
    try {
      await ensureDatabaseInitialized();
      final db = await _db;
      final tables = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE 'android_%'");
      //fetch group identity
      final groups_identity = await db.query('groups_identity', limit: 1);
      if (groups_identity.isEmpty) {
        return;
      }
      //proceed with sync
      for (var table in tables) {
        final tableName = table['name'];
        if (tableName != null && tableName is String) {
          final rowsToSync = await db.query(
            tableName,
            where: 'synced_at IS NULL',
          );
          if (tableName == 'groups_identity') {
            continue;
          }
          if (rowsToSync.isNotEmpty) {
            final data_rows = {
              'data': {'table': tableName, 'result': rowsToSync},
              'groups_identity': groups_identity
            };

            var data_json = jsonEncode(data_rows);
            final response = await http.post(
              Uri.parse('https://vsla.chomokaplus.com/api/sync'),
              // Uri.parse('http://192.168.6.20:10000/api/sync'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: data_json,
            );

            if (response.statusCode == 200) {
              print('Data synced successfully for table $tableName');
              for (var row in rowsToSync) {
                await db.update(
                  tableName,
                  {'synced_at': formatForMySQL(DateTime.now().toUtc())},
                  where: 'id = ?',
                  whereArgs: [row['id']],
                );
              }
            } else {
              print(
                  'Failed to sync data for table $tableName: ${response.body}');
            }
          }
        }
      }
    } catch (e) {
      print('Error during syncing: $e');
    }
  }

  Future<BaseModel?> latest() async {
    try {
      final db = await _db;
      await ensureTableExists();
      final results = await db.query(
        tableName,
        where: _compiledWhere,
        whereArgs: _compiledWhereArgs,
        orderBy: 'created_at DESC',
        limit: 1,
      );
      _clearQuery();
      return results.isNotEmpty ? fromMap(results.first) : null;
    } catch (e) {
      _clearQuery();
      print('Error during latest: $e');
      rethrow;
    }
  }
}

String formatForMySQL(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}
