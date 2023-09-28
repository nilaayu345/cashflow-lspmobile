import 'package:get_storage/get_storage.dart';
import 'package:cash_book_mobile/data/cashflow.dart';
import 'package:cash_book_mobile/utils/hash_password.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static const _databaseName = 'nila_database.db';
  static const _databaseVersion = 1;
  final box = GetStorage();

  Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // buat tabel pengguna
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    // buat tabel cashflow
    await db.execute('''
    CREATE TABLE cashflow (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      date DATE NOT NULL,
      nominal INTEGER NOT NULL,
      description TEXT,
      status TEXT NOT NULL
    )
    ''');
  }

  Future<void> addUser(String username, String password) async {
    final db = await instance.database;
    await db.insert(
      'users',
      {
        'username': username,
        'password': password,
      },
    );
  }

  Future<bool> login(String username, String password) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (users.isNotEmpty) {
      final storedPassword = users[0]['password'] as String;
      final hashedPassword = HashPassword(password);

      if (storedPassword == hashedPassword) {
        final id = users[0]['id'] as int; // Mengambil ID dari hasil query
        final box = GetStorage(); // Inisialisasi GetStorage

        // Menyimpan ID ke dalam GetStorage
        box.write("user_id", id);
        box.write("username", username);

        return true; // Login berhasil
      }
    }

    return false;
  }

  Future<int?> insertCashflow(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('cashflow', row);
  }

  Future<List<CashFlow>> getCashflows() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cashflow',
      where: 'user_id = ?',
      whereArgs: [box.read('user_id')],
    );

    return List.generate(maps.length, (i) {
      return CashFlow(
        id: maps[i]['id'],
        user_id: maps[i]['user_id'],
        date: maps[i]['date'],
        nominal: maps[i]['nominal'],
        description: maps[i]['description'],
        status: maps[i]['status'], // Konversi dari integer ke boolean
      );
    });
  }

  Future<List<CashFlow>> getCashflowsByMonth() async {
    final db = await instance.database;
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    final List<Map<String, dynamic>> maps = await db.query(
      'cashflow',
      where: 'user_id = ? AND date LIKE ?',
      whereArgs: [box.read('user_id'), "%-$currentMonth-$currentYear"],
    );
    return List.generate(maps.length, (i) {
      return CashFlow(
        id: maps[i]['id'],
        user_id: maps[i]['user_id'],
        date: maps[i]['date'],
        nominal: maps[i]['nominal'],
        description: maps[i]['description'],
        status: maps[i]['status'], // Konversi dari integer ke boolean
      );
    });
  }
}
