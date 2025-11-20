import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/screens/home.dart';
import 'package:torreyana_sample_app/screens/assignments.dart';
import 'package:torreyana_sample_app/screens/parent_home.dart';
import 'package:torreyana_sample_app/screens/schedule.dart';
import 'package:torreyana_sample_app/screens/student_home.dart';

final navigation = Navigation(
  homeScreen: Screen(
    name: '/',
    builder: (context, parameters) => const HomeScreen(),
  ),
  screens: [
    Screen(
      name: 'schedule',
      builder: (context, parameters) => const ScheduleScreen(),
    ),
    Screen(
      name: 'assignments',
      requiresRole: 'student',
      builder: (context, parameters) => const AssignmentsScreen(),
    ),
  ],
  homeScreenForRole: {
    'student': Screen(
      name: 'student-home',
      builder: (context, parameters) => const StudentHomeScreen(),
    ),
    'parent': Screen(
      name: 'parent-home',
      builder: (context, parameters) => const ParentHomeScreen(),
    )
  },
);
