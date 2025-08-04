part of 'providers/navigation.dart';

final navigation = Navigation(
  homeScreen: Screen(
    name: 'home',
    builder: (context, parameters, _) => const HomeScreen(),
  ),
  screens: [
    Screen(
      name: 'schedule',
      builder: (context, parameters, _) => ScheduleScreen(),
    ),
    Screen(
      name: 'assignments',
      requiresRole: 'student',
      builder: (context, parameters, _) => AssignmentsScreen(),
    ),
  ],
  homeScreenForRole: {
    'student': Screen(
      name: 'student-home',
      builder: (context, parameters, _) => const StudentHomeScreen(),
    ),
    'parent': Screen(
      name: 'parent-home',
      builder: (context, parameters, _) => ParentHomeScreen(),
    )
  },
);
