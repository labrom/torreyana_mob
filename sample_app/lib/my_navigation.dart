import 'package:torreyana_mob/providers/navigation.dart';
import 'package:torreyana_mob/screens/home.dart';
import 'package:torreyana_mob_sample_app/screens/assignments.dart';
import 'package:torreyana_mob_sample_app/screens/parent_home.dart';
import 'package:torreyana_mob_sample_app/screens/schedule.dart';
import 'package:torreyana_mob_sample_app/screens/student_home.dart';

final navigation = Navigation(
  homeScreen: Screen(
    name: 'home',
    builder: (context, parameters, _) => const HomeScreen(),
  ),
  screens: [
    Screen(
      name: 'schedule',
      builder: (context, parameters, _) => const ScheduleScreen(),
    ),
    Screen(
      name: 'assignments',
      requiresRole: 'student',
      builder: (context, parameters, _) => const AssignmentsScreen(),
    ),
  ],
  homeScreenForRole: {
    'student': Screen(
      name: 'student-home',
      builder: (context, parameters, _) => const StudentHomeScreen(),
    ),
    'parent': Screen(
      name: 'parent-home',
      builder: (context, parameters, _) => const ParentHomeScreen(),
    )
  },
);
