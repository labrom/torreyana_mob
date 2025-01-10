import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analytics.g.dart';

@riverpod
FirebaseAnalytics analytics(AnalyticsRef ref) => FirebaseAnalytics.instance;
