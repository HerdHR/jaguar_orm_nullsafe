// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complex.dart';

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _ProductItemsBean implements Bean<ProductItems> {
  final id = new StrField('id');
  final name = new StrField('name');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        name.name: name,
      };
  ProductItems fromMap(Map map) {
    ProductItems model = ProductItems();
    model.id = adapter.parseValue(map['id']);
    model.name = adapter.parseValue(map['name']);

    return model;
  }

  List<SetColumn> toSetColumns(ProductItems model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(name.set(model.name));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(name.name)) ret.add(name.set(model.name));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addStr(id.name, primary: true, isNullable: false);
    st.addStr(name.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(ProductItems model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await adapter.insert(insert);
    if (cascade) {
      ProductItems newModel;
      if (model.items != null) {
        newModel ??= await find(model.id);
        for (final child in model.items) {
          await productBean.insert(child);
          await productItemsPivotBean.attach(model, child);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<ProductItems> models,
      {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data =
          models.map((model) => toSetColumns(model)).toList();
      final InsertMany insert = inserters.addAll(data);
      await adapter.insertMany(insert);
      return;
    }
  }

  Future<dynamic> upsert(ProductItems model, {bool cascade: false}) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    var retId = await adapter.upsert(upsert);
    if (cascade) {
      ProductItems newModel;
      if (model.items != null) {
        newModel ??= await find(model.id);
        for (final child in model.items) {
          await productBean.upsert(child);
          await productItemsPivotBean.attach(model, child);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<ProductItems> models,
      {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(upsert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(toSetColumns(model).toList());
      }
      final UpsertMany upsert = upserters.addAll(data);
      await adapter.upsertMany(upsert);
      return;
    }
  }

  Future<int> update(ProductItems model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      ProductItems newModel;
      if (model.items != null) {
        for (final child in model.items) {
          await await productBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<ProductItems> models,
      {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = [];
      final List<Expression> where = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(toSetColumns(model).toList());
        where.add(this.id.eq(model.id));
      }
      final UpdateMany update = updaters.addAll(data, where);
      await adapter.updateMany(update);
      return;
    }
  }

  Future<ProductItems> find(String id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final ProductItems model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(String id, [bool cascade = false]) async {
    if (cascade) {
      final ProductItems newModel = await find(id);
      if (newModel != null) {
        await productItemsPivotBean.detachProductItems(newModel);
      }
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<ProductItems> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<ProductItems> preload(ProductItems model,
      {bool cascade: false}) async {
    model.items = await productItemsPivotBean.fetchByProductItems(model);
    return model;
  }

  Future<List<ProductItems>> preloadAll(List<ProductItems> models,
      {bool cascade: false}) async {
    for (ProductItems model in models) {
      var temp = await productItemsPivotBean.fetchByProductItems(model);
      if (model.items == null)
        model.items = temp;
      else {
        model.items.clear();
        model.items.addAll(temp);
      }
    }
    return models;
  }

  ProductItemsPivotBean get productItemsPivotBean;

  ProductBean get productBean;
}

abstract class _ProductItemsPivotBean implements Bean<ProductItemsPivot> {
  final productId = new StrField('product_id');
  final productListId = new StrField('product_list_id');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        productId.name: productId,
        productListId.name: productListId,
      };
  ProductItemsPivot fromMap(Map map) {
    ProductItemsPivot model = ProductItemsPivot();
    model.productId = adapter.parseValue(map['product_id']);
    model.productListId = adapter.parseValue(map['product_list_id']);

    return model;
  }

  List<SetColumn> toSetColumns(ProductItemsPivot model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(productId.set(model.productId));
      ret.add(productListId.set(model.productListId));
    } else {
      if (only.contains(productId.name))
        ret.add(productId.set(model.productId));
      if (only.contains(productListId.name))
        ret.add(productListId.set(model.productListId));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addStr(productId.name,
        foreignTable: productBean.tableName,
        foreignCol: 'id',
        isNullable: false);
    st.addStr(productListId.name,
        foreignTable: productItemsBean.tableName,
        foreignCol: 'id',
        isNullable: false);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(ProductItemsPivot model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return adapter.insert(insert);
  }

  Future<void> insertMany(List<ProductItemsPivot> models) async {
    final List<List<SetColumn>> data =
        models.map((model) => toSetColumns(model)).toList();
    final InsertMany insert = inserters.addAll(data);
    await adapter.insertMany(insert);
    return;
  }

  Future<dynamic> upsert(ProductItemsPivot model) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    return adapter.upsert(upsert);
  }

  Future<void> upsertMany(List<ProductItemsPivot> models) async {
    final List<List<SetColumn>> data = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
    }
    final UpsertMany upsert = upserters.addAll(data);
    await adapter.upsertMany(upsert);
    return;
  }

  Future<void> updateMany(List<ProductItemsPivot> models) async {
    final List<List<SetColumn>> data = [];
    final List<Expression> where = [];
    for (var i = 0; i < models.length; ++i) {
      var model = models[i];
      data.add(toSetColumns(model).toList());
      where.add(null);
    }
    final UpdateMany update = updaters.addAll(data, where);
    await adapter.updateMany(update);
    return;
  }

  Future<List<ProductItemsPivot>> findByProduct(String productId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.productId.eq(productId));
    return findMany(find);
  }

  Future<List<ProductItemsPivot>> findByProductList(List<Product> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Product model in models) {
      find.or(this.productId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByProduct(String productId) async {
    final Remove rm = remover.where(this.productId.eq(productId));
    return await adapter.remove(rm);
  }

  void associateProduct(ProductItemsPivot child, Product parent) {
    child.productId = parent.id;
  }

  Future<int> detachProduct(Product model) async {
    final dels = await findByProduct(model.id);
    await removeByProduct(model.id);
    final exp = new Or();
    for (final t in dels) {
      exp.or(productItemsBean.id.eq(t.productListId));
    }
    return await productItemsBean.removeWhere(exp);
  }

  Future<List<ProductItems>> fetchByProduct(Product model) async {
    final pivots = await findByProduct(model.id);
    final exp = new Or();
    for (final t in pivots) {
      exp.or(productItemsBean.id.eq(t.productListId));
    }
    return await productItemsBean.findWhere(exp);
  }

  Future<List<ProductItemsPivot>> findByProductItems(String productListId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.productListId.eq(productListId));
    return findMany(find);
  }

  Future<List<ProductItemsPivot>> findByProductItemsList(
      List<ProductItems> models,
      {bool preload: false,
      bool cascade: false}) async {
    final Find find = finder;
    for (ProductItems model in models) {
      find.or(this.productListId.eq(model.id));
    }
    return findMany(find);
  }

  Future<int> removeByProductItems(String productListId) async {
    final Remove rm = remover.where(this.productListId.eq(productListId));
    return await adapter.remove(rm);
  }

  void associateProductItems(ProductItemsPivot child, ProductItems parent) {
    child.productListId = parent.id;
  }

  Future<int> detachProductItems(ProductItems model) async {
    final dels = await findByProductItems(model.id);
    await removeByProductItems(model.id);
    final exp = new Or();
    for (final t in dels) {
      exp.or(productBean.id.eq(t.productId));
    }
    return await productBean.removeWhere(exp);
  }

  Future<List<Product>> fetchByProductItems(ProductItems model) async {
    final pivots = await findByProductItems(model.id);
    final exp = new Or();
    for (final t in pivots) {
      exp.or(productBean.id.eq(t.productId));
    }
    return await productBean.findWhere(exp);
  }

  Future<dynamic> attach(ProductItems one, Product two) async {
    final ret = new ProductItemsPivot();
    ret.productListId = one.id;
    ret.productId = two.id;
    return insert(ret);
  }

  ProductBean get productBean;
  ProductItemsBean get productItemsBean;
}

abstract class _ProductBean implements Bean<Product> {
  final id = new StrField('id');
  final sku = new StrField('sku');
  final name = new StrField('name');
  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        sku.name: sku,
        name.name: name,
      };
  Product fromMap(Map map) {
    Product model = Product();
    model.id = adapter.parseValue(map['id']);
    model.sku = adapter.parseValue(map['sku']);
    model.name = adapter.parseValue(map['name']);

    return model;
  }

  List<SetColumn> toSetColumns(Product model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(sku.set(model.sku));
      ret.add(name.set(model.name));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(sku.name)) ret.add(sku.set(model.sku));
      if (only.contains(name.name)) ret.add(name.set(model.name));
    }

    return ret;
  }

  Future<void> createTable() async {
    final st = Sql.create(tableName);
    st.addStr(id.name, primary: true, isNullable: false);
    st.addStr(sku.name, isNullable: false);
    st.addStr(name.name, isNullable: true);
    return adapter.createTable(st);
  }

  Future<dynamic> insert(Product model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await adapter.insert(insert);
    if (cascade) {
      Product newModel;
      if (model.lists != null) {
        newModel ??= await find(model.id);
        for (final child in model.lists) {
          await productItemsBean.insert(child);
          await productItemsPivotBean.attach(child, model);
        }
      }
    }
    return retId;
  }

  Future<void> insertMany(List<Product> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(insert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data =
          models.map((model) => toSetColumns(model)).toList();
      final InsertMany insert = inserters.addAll(data);
      await adapter.insertMany(insert);
      return;
    }
  }

  Future<dynamic> upsert(Product model, {bool cascade: false}) async {
    final Upsert upsert = upserter.setMany(toSetColumns(model));
    var retId = await adapter.upsert(upsert);
    if (cascade) {
      Product newModel;
      if (model.lists != null) {
        newModel ??= await find(model.id);
        for (final child in model.lists) {
          await productItemsBean.upsert(child);
          await productItemsPivotBean.attach(child, model);
        }
      }
    }
    return retId;
  }

  Future<void> upsertMany(List<Product> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(upsert(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(toSetColumns(model).toList());
      }
      final UpsertMany upsert = upserters.addAll(data);
      await adapter.upsertMany(upsert);
      return;
    }
  }

  Future<int> update(Product model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = adapter.update(update);
    if (cascade) {
      Product newModel;
      if (model.lists != null) {
        for (final child in model.lists) {
          await await productItemsBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<void> updateMany(List<Product> models, {bool cascade: false}) async {
    if (cascade) {
      final List<Future> futures = [];
      for (var model in models) {
        futures.add(update(model, cascade: cascade));
      }
      await Future.wait(futures);
      return;
    } else {
      final List<List<SetColumn>> data = [];
      final List<Expression> where = [];
      for (var i = 0; i < models.length; ++i) {
        var model = models[i];
        data.add(toSetColumns(model).toList());
        where.add(this.id.eq(model.id));
      }
      final UpdateMany update = updaters.addAll(data, where);
      await adapter.updateMany(update);
      return;
    }
  }

  Future<Product> find(String id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Product model = await findOne(find);
    if (preload && model != null) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(String id, [bool cascade = false]) async {
    if (cascade) {
      final Product newModel = await find(id);
      if (newModel != null) {
        await productItemsPivotBean.detachProduct(newModel);
      }
    }
    final Remove remove = remover.where(this.id.eq(id));
    return adapter.remove(remove);
  }

  Future<int> removeMany(List<Product> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return adapter.remove(remove);
  }

  Future<Product> preload(Product model, {bool cascade: false}) async {
    model.lists = await productItemsPivotBean.fetchByProduct(model);
    return model;
  }

  Future<List<Product>> preloadAll(List<Product> models,
      {bool cascade: false}) async {
    for (Product model in models) {
      var temp = await productItemsPivotBean.fetchByProduct(model);
      if (model.lists == null)
        model.lists = temp;
      else {
        model.lists.clear();
        model.lists.addAll(temp);
      }
    }
    return models;
  }

  ProductItemsPivotBean get productItemsPivotBean;

  ProductItemsBean get productItemsBean;
}
