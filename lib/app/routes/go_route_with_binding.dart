import 'package:go_router/go_router.dart';
import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/utilities/index.dart';

class GoRouteWithBinding extends GoRoute {
  GoRouteWithBinding({
    required this.newBuilder,
    required this.binding,
    required String path,
    List<RouteBase> routes = const <RouteBase>[],
    required List<String> prevPath,
  }) : super(
          path: path,
          builder: (context, state) {
            final prevLocation =
                GoRouter.of(context).routeInformationProvider.value.location;
            final currentLocation = GoRouter.of(context).location;
            if (currentLocation.contains(path) &&
                binding.isDependenciesDeleted == true) {
              binding.dependencies();
              if (state.extra.hasData) {
                final Map<String, dynamic> arg =
                    state.extra as Map<String, dynamic>;
                binding.arg1 = arg['arg1'];
                binding.arg2 = arg['arg2'];
              }

              return newBuilder(context, state);
            }

            if (prevLocation!.contains(path) &&
                prevPath.any(currentLocation.contains)) {
              binding.unRegisterDependencies();
            }
            return newBuilder(context, state);
          },
          routes: routes,
        );

  final Bindings binding;
  final GoRouterWidgetBuilder newBuilder;
}

// class GoReplaceRouteWithBinding extends GoRoute {
//   GoReplaceRouteWithBinding({
//     required this.newBuilder,
//     required this.binding,
//     required String path,
//     List<RouteBase> routes = const <RouteBase>[],
//     String? prevPath,
//   }) : super(
//           path: path,
//           builder: (context, state) {
//             final currentLocation = GoRouter.of(context).location;
//
//             print(
//                 "====> CURRENTLOCATION : ${currentLocation} / PATH : ${path}");
//             print(
//                 "binding.isDependenciesDeleted ==> ${binding.isDependenciesDeleted}");
//             if (currentLocation.contains(path) &&
//                 binding.isDependenciesDeleted == true) {
//               print("발동동");
//               binding.dependencies();
//               final arg = state.extra;
//               if (arg.hasData) {
//                 binding.arg1 = arg;
//               }
//             }
//
//             return newBuilder(context, state);
//           },
//           routes: routes,
//         );
//
//   final CustomBindings binding;
//   final GoRouterWidgetBuilder newBuilder;
// }

// class GoGenerateRoute extends GoRoute {
//   GoGenerateRoute({
//     required this.newBuilder,
//     required this.binding,
//     required String path,
//     List<RouteBase> routes = const <RouteBase>[],
//   }) : super(
//     path: path,
//     builder: (context, state) {
//       final goRouter = GoRouter.of(context).routeInformationProvider;
//       print("AKKK ARAANG ${path} == ${goRouter.value.location}");
//       if (path == goRouter.value.location) {
//         print("AKKK ARAANG ${path} == ${goRouter.value.location}");
//         binding.dependencies();
//         final arg = state.extra;
//         if (arg.hasData) {
//           binding.argument = arg;
//         }
//       }
//       if (goRouter.value.location!.contains(path) &&
//           binding.isDependenciesDeleted == false) {
//         binding.unRegisterDependencies();
//       }
//       return newBuilder(context, state);
//     },
//     routes: routes,
//   );
//
//   final CustomBindings binding;
//   final GoRouterWidgetBuilder newBuilder;
// }
