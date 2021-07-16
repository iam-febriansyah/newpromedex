import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
part 'db.g.dart';

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);

@SqfEntityBuilder(dbModel)
const dbModel = SqfEntityModel(
    modelName: 'dbModel',
    databaseName: 'promedex.db',
    databaseTables: [],
    sequences: [seqIdentity],
    bundledDatabasePath: null);

// const TableSearch = SqfEntityTable(
//     tableName: 'tbl_search',
//     primaryKeyName: 'ROWID',
//     primaryKeyType: PrimaryKeyType.integer_auto_incremental,
//     useSoftDeleting: false,
//     modelName: null,
//     fields: [
//       SqfEntityField("id", DbType.integer),
//       SqfEntityField("kategori", DbType.text),
//       SqfEntityField("jenis", DbType.text),
//     ]);
