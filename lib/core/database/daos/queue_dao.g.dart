// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_dao.dart';

// ignore_for_file: type=lint
mixin _$QueueDaoMixin on DatabaseAccessor<AppDatabase> {
  $QueueItemsTableTable get queueItemsTable => attachedDatabase.queueItemsTable;
  QueueDaoManager get managers => QueueDaoManager(this);
}

class QueueDaoManager {
  final _$QueueDaoMixin _db;
  QueueDaoManager(this._db);
  $$QueueItemsTableTableTableManager get queueItemsTable =>
      $$QueueItemsTableTableTableManager(
        _db.attachedDatabase,
        _db.queueItemsTable,
      );
}
