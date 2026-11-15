import 'package:drift/drift.dart';
import 'package:oms_new/core/database/app_database.dart';
import 'package:oms_new/core/database/tables/tables.dart';

part 'queue_dao.g.dart';

@DriftAccessor(tables: [QueueItemsTable])
class QueueDao extends DatabaseAccessor<AppDatabase> with _$QueueDaoMixin {
  QueueDao(super.db);

  Future<int> insertQueueItem(QueueItemsTableCompanion item) {
    return into(queueItemsTable).insertOnConflictUpdate(item);
  }

  Stream<List<QueueItemRow>> watchWaitingQueue() {
    return (select(queueItemsTable)
          ..where((tbl) => tbl.status.equals('waiting') | tbl.status.equals('inConsultation'))
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.queueNumber, mode: OrderingMode.asc)
          ]))
        .watch();
  }

  Future<List<QueueItemRow>> getWaitingQueue() {
    return (select(queueItemsTable)
          ..where((tbl) => tbl.status.equals('waiting') | tbl.status.equals('inConsultation'))
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.queueNumber, mode: OrderingMode.asc)
          ]))
        .get();
  }

  Future<int> updateQueueStatus(String id, String newStatus) {
    return (update(queueItemsTable)..where((tbl) => tbl.id.equals(id)))
        .write(QueueItemsTableCompanion(status: Value(newStatus)));
  }

  Future<QueueItemRow?> getQueueItemById(String id) {
    return (select(queueItemsTable)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }
}
