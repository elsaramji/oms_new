import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:fpdart/fpdart.dart';
import 'package:oms_new/core/database/daos/consultation_draft_dao.dart';
import 'package:oms_new/core/database/daos/queue_dao.dart';
import 'package:oms_new/core/error/failures.dart';
import 'package:oms_new/features/clinical_consultation/data/datasources/simulated_ai_scribe_data_source.dart';
import 'package:oms_new/features/clinical_consultation/data/models/consultation_draft_model.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/ai_draft_note_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/entities/prescription_qr_entity.dart';
import 'package:oms_new/features/clinical_consultation/domain/repositories/consultation_repository.dart';

class ConsultationRepositoryImpl implements ConsultationRepository {
  final ConsultationDraftDao draftDao;
  final QueueDao queueDao;
  final SimulatedAiScribeDataSource scribeDataSource;

  ConsultationRepositoryImpl({
    required this.draftDao,
    required this.queueDao,
    required this.scribeDataSource,
  });

  @override
  Future<Either<Failure, Option<AiDraftNoteEntity>>> getActiveDraft(
    String patientId,
  ) async {
    try {
      final row = await draftDao.getDraftByPatientId(patientId);
      if (row == null) return const Right(None());
      final model = ConsultationDraftModel.fromRow(row);
      return Right(Some(model));
    } catch (e) {
      return Left(CacheFailure('Failed to load consultation draft: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveDraft(AiDraftNoteEntity draft) async {
    try {
      final model = ConsultationDraftModel.fromEntity(draft);
      await draftDao.insertOrUpdateDraft(model.toCompanion());
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure('Failed to save draft locally: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AiDraftNoteEntity>> generateSimulatedAiScribe(
    String patientId,
  ) async {
    try {
      final aiDraft = await scribeDataSource.generateSoapDraft(patientId);
      await draftDao.insertOrUpdateDraft(aiDraft.toCompanion());
      return Right(aiDraft);
    } catch (e) {
      return Left(ServerFailure('Simulated AI scribe failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, PrescriptionQrEntity>> commitConsultation({
    required AiDraftNoteEntity draft,
    required String patientName,
    required String doctorName,
  }) async {
    try {
      final prescriptionId = 'RX-${DateTime.now().millisecondsSinceEpoch}';
      final issuedAt = DateTime.now();

      // Mark queue item as completed
      final queueItems = await queueDao.getWaitingQueue();
      final matchingItem = queueItems.where((i) => i.patientId == draft.patientId);
      if (matchingItem.isNotEmpty) {
        await queueDao.updateQueueStatus(matchingItem.first.id, 'completed');
      }

      // Remove / archive draft from active cache
      await draftDao.deleteDraftByPatientId(draft.patientId);

      // Generate Cryptographic Verification Hash
      final rawPayload = jsonEncode({
        'prescriptionId': prescriptionId,
        'patientId': draft.patientId,
        'patientName': patientName,
        'doctorName': doctorName,
        'issuedAt': issuedAt.toIso8601String(),
        'medications': draft.prescriptions.map((p) => p.formattedRegimen).toList(),
      });
      final verificationHash = sha256.convert(utf8.encode(rawPayload)).toString();

      final qrPayload =
          'https://oms.clinic/verify/rx?id=$prescriptionId&hash=${verificationHash.substring(0, 16)}';

      final qrEntity = PrescriptionQrEntity(
        prescriptionId: prescriptionId,
        patientId: draft.patientId,
        patientName: patientName,
        doctorName: doctorName,
        issuedAt: issuedAt,
        medications: draft.prescriptions,
        verificationHash: verificationHash,
        qrPayload: qrPayload,
      );

      return Right(qrEntity);
    } catch (e) {
      return Left(CacheFailure('Failed to commit consultation: ${e.toString()}'));
    }
  }
}
