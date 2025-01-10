part of 'providers/navigation.dart';

final navigation = Navigation(
  homeScreen: Screen(
    name: 'home',
    builder: (context, parameters) => const HomeScreen(),
  ),
  screens: [
    Screen(
      name: 'schedule',
      builder: (context, parameters) => ScheduleScreen(),
    ),
    Screen(
      name: 'assignments',
      requiresRole: 'student',
      builder: (context, parameters) => AssignmentsScreen(),
    ),
  ],
  homeScreenForRole: {
    'student': Screen(
      name: 'student-home',
      builder: (context, parameters) => const StudentHomeScreen(),
    ),
    'parent': Screen(
      name: 'parent-home',
      builder: (context, parameters) => ParentHomeScreen(),
    )
  },
);
