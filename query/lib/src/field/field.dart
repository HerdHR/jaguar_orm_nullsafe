library jaguar_query.field;

import 'package:jaguar_query/jaguar_query.dart';

class Range<ValType> {
  final ValType low;

  final ValType high;

  const Range(this.low, this.high);
}

Range<ValType> range<ValType>(ValType low, ValType high) =>
    new Range(low, high);

/// Field is a convenience DSL used to construct queries in a concise and
/// understandable way.
class Field<ValType> {
  /// Name of the field
  final String name;

  const Field(this.name);

  /// Returns an "is equal to" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> author = new Field<int>('age');
  ///     find.where(age.eq(20));
  Cond<ValType> eq(ValType value, {String tableAlias}) =>
      Cond.eq<ValType>(new Col<ValType>(name, tableAlias), value);

  /// Returns a "not equal to" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.ne(20));
  Cond<ValType> ne(ValType value, {String tableAlias}) =>
      Cond.ne<ValType>(new Col<ValType>(name, tableAlias), value);

  /// Returns a "greater than" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.gt(20));
  Cond<ValType> gt(ValType value, {String tableAlias}) =>
      Cond.gt<ValType>(new Col<ValType>(name, tableAlias), value);

  /// Returns a "greater than equal to" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.gtEq(20));
  Cond<ValType> gtEq(ValType value, {String tableAlias}) =>
      Cond.gtEq<ValType>(new Col<ValType>(name, tableAlias), value);

  /// Returns a "less than equal to" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.ltEq(20));
  Cond<ValType> ltEq(ValType value, {String tableAlias}) =>
      Cond.ltEq<ValType>(new Col<ValType>(name, tableAlias), value);

  /// Returns a "less than" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.lt(20));
  Cond<ValType> lt(ValType value, {String tableAlias}) =>
      Cond.lt<ValType>(new Col<ValType>(name, tableAlias), value);

  /// Returns an "in between" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.between(20, 30));
  Between<ValType> between(ValType low, ValType high, {String tableAlias}) =>
      Cond.between<ValType>(new Col<ValType>(name, tableAlias), low, high);

  Col<ValType> asCol([String tableAlias]) => new Col<ValType>(name, tableAlias);

  /// Returns an "is equal to" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.eqCol(col('age', 'employee')));
  CondCol<ValType> eqCol(Col<ValType> rhs, {String tableAlias}) =>
      CondCol.eq<ValType>(new Col<ValType>(name, tableAlias), rhs);

  /// Returns a "not equal to" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.neCol(col('age', 'employee')));
  CondCol<ValType> neCol(Col<ValType> rhs, {String tableAlias}) =>
      CondCol.ne<ValType>(new Col<ValType>(name, tableAlias), rhs);

  /// Returns a "greater than" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.gtCol(col('age', 'employee')));
  CondCol<ValType> gtCol(Col<ValType> rhs, {String tableAlias}) =>
      CondCol.gt<ValType>(new Col<ValType>(name, tableAlias), rhs);

  /// Returns a "greater than equal to" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.gtEqCol(col('age', 'employee')));
  CondCol<ValType> gtEqCol(Col<ValType> rhs, {String tableAlias}) =>
      CondCol.gtEq<ValType>(new Col<ValType>(name, tableAlias), rhs);

  /// Returns a "less than equal to" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.ltEqCol(col('age', 'employee')));
  CondCol<ValType> ltEqCol(Col<ValType> rhs, {String tableAlias}) =>
      CondCol.ltEq<ValType>(new Col<ValType>(name, tableAlias), rhs);

  /// Returns a "less than" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     find.where(age.ltCol(col('age', 'employee')));
  CondCol<ValType> ltCol(Col<ValType> rhs, {String tableAlias}) =>
      CondCol.lt<ValType>(new Col<ValType>(name, tableAlias), rhs);

  /// Returns an "in between" condition
  InBetweenCol<ValType> inBetweenCol(Col<ValType> low, Col<ValType> high,
          {String tableAlias}) =>
      CondCol.between<ValType>(new Col<ValType>(name, tableAlias), low, high);

  /// Returns a "set column" clause
  ///
  ///     UpdateStatement update = new UpdateStatement();
  ///     Field<int> age = new Field<int>('age');
  ///     update.set(age.set(20));
  SetColumn<ValType> set(ValType value) =>
      new SetColumn<ValType>().column(name).set(value);

  Cond<ValType> operator <(ValType other) {
    return lt(other);
  }

  Cond<ValType> operator >(ValType other) {
    return gt(other);
  }

  Cond<ValType> operator <=(ValType other) {
    return ltEq(other);
  }

  Cond<ValType> operator >=(ValType other) {
    return gtEq(other);
  }
}

class IntField extends Field<int> {
  IntField(String name) : super(name);

  /// Adds the field to create statement
  void create(Create statement,
      {bool autoIncrement: false,
      bool primary: false,
      bool isNullable: false,
      String foreignTable,
      String foreignCol,
      String uniqueGroup}) {
    statement.addInt(name,
        isNullable: isNullable,
        autoIncrement: autoIncrement,
        primary: primary,
        foreignTable: foreignTable,
        foreignCol: foreignCol,
        uniqueGroup: uniqueGroup);
  }
}

class DoubleField extends Field<double> {
  DoubleField(String name) : super(name);

  /// Adds the field to create statement
  void create(Create statement,
      {bool isNullable: false,
      bool primary: false,
      String foreignTable,
      String foreignCol,
      String uniqueGroup}) {
    statement.addDouble(name,
        isNullable: isNullable,
        primary: primary,
        foreignTable: foreignTable,
        foreignCol: foreignCol,
        uniqueGroup: uniqueGroup);
  }
}

class StrField extends Field<String> {
  StrField(String name) : super(name);

  /// This is actually 'like' operator
  Cond<String> operator %(String other) {
    return like(other);
  }

  /// Returns a "like" condition
  ///
  ///     FindStatement find = new FindStatement();
  ///     Field<String> author = new Field<String>('author');
  ///     find.where(author.like('%Mark%'));
  Cond<String> like(String value, {String tableAlias}) =>
      Cond.like(new Col<String>(name, tableAlias), value);

  /// Adds the field to create statement
  void create(Create statement,
      {bool isNullable: false,
      int length: 20,
      bool primary: false,
      String foreignTable,
      String foreignCol,
      String uniqueGroup}) {
    statement.addStr(name,
        isNullable: isNullable,
        length: length,
        primary: primary,
        foreignTable: foreignTable,
        foreignCol: foreignCol,
        uniqueGroup: uniqueGroup);
  }
}

class DateTimeField extends Field<DateTime> {
  DateTimeField(String name) : super(name);

  /// Adds the field to create statement
  void create(Create statement, {bool isNullable, String uniqueGroup}) {
    statement.addDateTime(name,
        isNullable: isNullable, uniqueGroup: uniqueGroup);
  }
}

class BoolField extends Field<bool> {
  BoolField(String name) : super(name);

  /// Adds the field to create statement
  void create(Create statement, {bool isNullable: false, String uniqueGroup}) {
    statement.addBool(name, isNullable: isNullable, uniqueGroup: uniqueGroup);
  }
}
