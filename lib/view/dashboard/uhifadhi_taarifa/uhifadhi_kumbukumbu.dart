import 'dart:io';
import 'package:chomoka/env.dart';
import 'package:chomoka/view/dashboard/uhifadhi_taarifa/chagua_njia.dart';
import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class UhifadhiKumbukumbuPage extends StatefulWidget {
  @override
  _UhifadhiKumbukumbuPageState createState() => _UhifadhiKumbukumbuPageState();
}

class _UhifadhiKumbukumbuPageState extends State<UhifadhiKumbukumbuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.uhifadhiKumbukumbu,
        showBackArrow: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[300],
          indicatorWeight: 3,
          tabs: [
            Tab(text: AppLocalizations.of(context)!.tumaTaarifa),
            Tab(text: AppLocalizations.of(context)!.hifadhiNakala),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSmsBackupTab(),
          _buildDatabaseBackupTab(),
        ],
      ),
    );
  }

  Widget _buildSmsBackupTab() {
    return Column(
      children: [
        Image.asset(
          'assets/images/img1.png',
          width: double.infinity,
          height: 400,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChaguaNjiaPage(),
              ),
            );
          },
          icon:
              Icon(Icons.send, color: const Color.fromARGB(255, 255, 255, 255)),
          label: Text(
            AppLocalizations.of(context)!.tumaTaarifa,
            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            backgroundColor: Colors.blue, // Set background color to blue
            shape: null, // No border radius
            minimumSize:
                Size(MediaQuery.of(context).size.width * 0.9, 50), // 90% width
          ),
        )
      ],
    );
  }

  Widget _buildDatabaseBackupTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EnhancedBackupCard(
              icon: Icons.archive,
              title: AppLocalizations.of(context)!.uhifadhiKumbukumbu,
              description:
                  AppLocalizations.of(context)!.uhifadhiKumbukumbuDescription,
              buttonText: AppLocalizations.of(context)!.chaguaMahaliNaHifadhi,
              buttonColor: Colors.blueAccent,
              onPressed: () async {
                try {
                  String? filePath = await exportDatabaseAsSqlDump();
                  if (filePath != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('SQL dump saved to: $filePath')));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(AppLocalizations.of(context)!
                          .errorSharingBackup(e.toString()))));
                }
                //redirect to this page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => dashboard(),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            EnhancedBackupCard(
              icon: Icons.share,
              title: AppLocalizations.of(context)!.hifadhiNakalaRafiki,
              description:
                  AppLocalizations.of(context)!.hifadhiNakalaRafikiDescription,
              buttonText: AppLocalizations.of(context)!.hifadhiNakala,
              buttonColor: Colors.orangeAccent,
              onPressed: () {
                _handleShareBackup();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleShareBackup() async {
    await shareBackupSql();
  }

  Future<String?> exportDatabaseAsSqlDump() async {
    try {
      String databasesPath = await getDatabasesPath();
      String dbName = Env.databaseName; // Your database name
      String dbPath = path.join(databasesPath, dbName);

      File dbFile = File(dbPath);
      if (!await dbFile.exists()) {
        throw Exception('Database file does not exist.');
      }

      Database db = await openDatabase(dbPath);

      List<Map<String, Object?>> tables = await db
          .rawQuery('SELECT name FROM sqlite_master WHERE type="table";');

      StringBuffer sqlDumpBuffer = StringBuffer();

      for (var tableRow in tables) {
        String tableName = tableRow['name'] as String;

        if (tableName == 'sqlite_sequence') {
          continue;
        }

        sqlDumpBuffer.writeln('DROP TABLE IF EXISTS $tableName;');
        List<Map<String, Object?>> createTableResult =
            await db.rawQuery('PRAGMA table_info($tableName);');
        StringBuffer createTableSQL = StringBuffer('CREATE TABLE $tableName (');

        bool isFirstColumn = true;
        for (var column in createTableResult) {
          String columnName = column['name'] as String;
          String columnType = column['type'] as String;

          columnType = columnType.trim();
          if (columnType.isEmpty || columnType == 'L') {
            continue;
          }

          if (!isFirstColumn) {
            createTableSQL.write(', ');
          }
          createTableSQL.write('$columnName $columnType');
          isFirstColumn = false;
        }

        if (createTableSQL.toString().endsWith('(')) {
          continue;
        }

        createTableSQL.write(');');
        sqlDumpBuffer.writeln(createTableSQL);

        List<Map<String, Object?>> rows =
            await db.rawQuery('SELECT * FROM $tableName;');
        for (var row in rows) {
          List<String> columns = row.keys.toList();
          List<String> values =
              columns.map((col) => row[col].toString()).toList();

          String columnsStr = columns.join(', ');
          String valuesStr = values
              .map((value) => value == null ? 'NULL' : "'$value'")
              .join(', ');
          sqlDumpBuffer.writeln(
              'INSERT INTO $tableName ($columnsStr) VALUES ($valuesStr);');
        }
      }

      String? exportDirectory = await FilePicker.platform.getDirectoryPath();
      if (exportDirectory != null) {
        String dumpPath = path.join(exportDirectory,
            'database_backup_${DateTime.now().millisecondsSinceEpoch}.sql');
        File dumpFile = File(dumpPath);
        await dumpFile.writeAsString(sqlDumpBuffer.toString());
        return dumpPath;
      }

      throw Exception("Failed to select directory for saving SQL dump.");
    } catch (e) {
      throw Exception("Error exporting database for MQL: $e");
    }
  }

  Future<void> shareBackupSql() async {
    try {
      String? sqlDumpPath = await exportDatabaseAsSqlDump();
      if (sqlDumpPath == null) {
        throw Exception('Failed to create SQL dump.');
      }

      await Share.shareXFiles(
        [XFile(sqlDumpPath)],
        text: 'Here is my database backup.',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing backup: $e')),
      );
    }
  }
}

class EnhancedBackupCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onPressed;

  const EnhancedBackupCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color gradientStart = buttonColor.withOpacity(0.15);
    final Color gradientEnd = buttonColor.withOpacity(0.05);

    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [gradientStart, gradientEnd],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(
                icon,
                size: 36,
                color: buttonColor,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 20,
                        ),
                      ),
                      onPressed: onPressed,
                      child: Text(
                        buttonText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSmsListItem({
  required int id,
  required String title,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    elevation: 2,
    child: ListTile(
      leading: const Icon(
        Icons.send,
        color: Colors.blueAccent,
        size: 40,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}
