import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oms_new/core/di/injection.dart';
import 'package:oms_new/core/localization/app_localizations.dart';
import 'package:oms_new/core/responsive/responsive_layout.dart';
import 'package:oms_new/features/assistant_intake/presentation/cubit/intake_cubit.dart';
import 'package:oms_new/features/assistant_intake/presentation/pages/assistant_intake_page.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:oms_new/features/auth/presentation/cubit/auth_state.dart';
import 'package:oms_new/features/auth/presentation/pages/login_page.dart';
import 'package:oms_new/features/clinical_consultation/presentation/cubit/consultation_cubit.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/cubit/doctor_queue_cubit.dart';
import 'package:oms_new/features/doctor_queue_ehr/presentation/pages/doctor_master_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const OmsClinicPortalApp());
}

class OmsClinicPortalApp extends StatelessWidget {
  const OmsClinicPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => getIt<AuthCubit>()),
        BlocProvider<IntakeCubit>(create: (_) => getIt<IntakeCubit>()),
        BlocProvider<DoctorQueueCubit>(create: (_) => getIt<DoctorQueueCubit>()),
        BlocProvider<ConsultationCubit>(create: (_) => getIt<ConsultationCubit>()),
      ],
      child: ResponsiveAppWrapper(
        child: MaterialApp(
          title: 'One Medical System - Clinic Portal',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF0284C7),
              primary: const Color(0xFF0284C7),
              surface: Colors.white,
            ),
            fontFamily: 'Roboto',
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Authenticated) {
                if (authState.user.isDoctor) {
                  return DoctorMasterDetailScreen(
                    currentDoctor: authState.user,
                  );
                } else {
                  return AssistantIntakePage(
                    currentUser: authState.user,
                  );
                }
              }

              return const LoginPage();
            },
          ),
        ),
      ),
    );
  }
}
