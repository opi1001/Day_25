import 'dart:math';
import 'package:practice_25/model/contract.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDbHelper {
  static Future<Database> initDb() async {
    var dbPath = await getDatabasesPath();
    var Path = join(dbPath, 'contract.db');

    return await openDatabase(Path, version: 1, onCreate: _onCreate);
  }

  static _onCreate(Database db, int Version) async {
    var sql =
        ''' _CREATE TABLE TBL_contact(id INTIGER PRIMARY KEY, name TEXT, phone TEXT) ''';

    db.execute(sql);
  }

  Future<int> creatContact(Contact contact) async {
    Database db = await MyDbHelper.initDb();

    return await db.insert('tbl_contact', contact.toMap());
  }

  static Future<List<Contact>> readContact() async {
    Database db = await MyDbHelper.initDb();
    var contact = await db.query(
      "tbl_contact",
    );

    List<Contact> contactList = contact.isNotEmpty
        ? contact.map((e) => Contact.fromMap(e)).toList()
        : [];

    return contactList;
  }

  static Future<int> updateContact(Contact contact) async {
    Database db = await MyDbHelper.initDb();
    return await db.update('tbl_contact ', contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  static Future<int> deleteContact(int id) async {
    Database db = await MyDbHelper.initDb();

    return db.delete('tbl_contact', where: 'id = ?', whereArgs: [id]);
  }
}
