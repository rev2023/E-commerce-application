import 'package:e_commerce_application/models/cart.dart';
import 'package:e_commerce_application/models/product_price.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();
  static Database? _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path,
        version: 10, onCreate: _createDB, onUpgrade: _onUpgrade);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const integerType = 'INTEGER';
    const stringType = 'STRING';
    const doubleType = 'DOUBLE NOT NULL';

    await db.execute('''
CREATE TABLE $cartTable(
${CartFields.id} $idType,
${CartFields.sku} $integerType,
${CartFields.name} $stringType,
${CartFields.brandName} $stringType,
${CartFields.mainImage} $stringType,
${CartFields.price} $doubleType,
${CartFields.currency} $stringType,
${CartFields.sizes} $stringType,  
${CartFields.color} $stringType,
${CartFields.stockStatus} $stringType,
${CartFields.description} $stringType,
${CartFields.quantity} $integerType,
${CartFields.selectedSize} $stringType
)
''');
  }

  Future<void> createEntry(Product product, int quantity, String size) async {
    final db = await database;
    product.selectedSize = size;
    try {
      final existingProduct = await readEntry(int.parse(product.id));
      final newQuantity = existingProduct.quantity! + quantity;
      if(product.selectedSize == existingProduct.selectedSize) {

        await db.update(
        cartTable,
        product.toMap(newQuantity),
        where: '${CartFields.id} = ?',
        whereArgs: [product.id],
      );
      }
      else{
        product.incrementID();
        await db.insert(cartTable, product.toMap(quantity));
      }

    } catch (e) {
        await db.insert(cartTable, product.toMap(quantity));

    }
  }

  Future<Product> readEntry(int id,) async {
    final db = await database;
    final maps = await db.query(
      cartTable,
      where: '${CartFields.id} = ?',
      whereArgs: [id,],
    );
    if (maps.isNotEmpty) {
      return Product.fromMap(maps.first);
    }
    return Product(
        name: '',
        brandName: '',
        id: '',
        mainImage: '',
        SKU: '',
        price: ProductPrice(amount: '', currency: ''),
        sizes: [],
        color: '',
        description: '',
        stockStatus: ''); // Return a default or empty Product if not found
  }

  Future<void> deleteEntry(int id) async {
    final db = await database;
    db.delete(
      cartTable,
      where: '${CartFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllEntries() async {
    final db = await database;
    await db.delete(cartTable);
  }

  Future<List<Product>> readAllEntries() async {
    final db = await database;
    final maps = await db.query(cartTable);
    return List.generate(maps.length, (index) {
      return Product.fromMap(maps[index]);
    });
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle the upgrade logic here
    if (oldVersion < newVersion) {
      // Drop the existing tables
      await db.execute('DROP TABLE IF EXISTS $cartTable');
      // Recreate the tables with the updated schema
      await _createDB(db, newVersion);
    }
  }
}
