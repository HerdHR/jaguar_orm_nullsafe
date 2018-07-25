// Copyright (c) 2016, Ravi Teja Gudapati. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_query_postgres/composer.dart';

main() {
  Find find = Sql.find('posts')
      .sel('message')
      .where(Col('likes').eq(10) & Col.int('replies').eq(5))
      .where(eq('author', 'teja') | like('author', 'kleak*'))
      .orderBy('author', true)
      .limit(10)
      .groupByMany(['message', 'likes']);
  print(composeFind(find));

  Find colCompare = Sql.find('posts')
      .where(new Col('author').eq(new Col('id', 'authors')))
      .orderBy('author', true)
      .limit(10)
      .groupByMany(['message', 'likes']);
  print(composeFind(colCompare));
}
