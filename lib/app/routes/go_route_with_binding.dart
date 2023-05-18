import 'package:go_router/go_router.dart';
import 'package:soon_sak/app/di/custom_binding.dart';
import 'package:soon_sak/utilities/index.dart';

class GoRouteWithBinding extends GoRoute {
  GoRouteWithBinding({
    required this.newBuilder,
    required this.binding,
    required String path,
    List<RouteBase> routes = const <RouteBase>[],
    String? prevPath,
  }) : super(
          path: path,
          builder: (context, state) {
            final goRouter = GoRouter.of(context).routeInformationProvider;
            print(
                "[${path}] prevPath : ${prevPath} <--> RouterLocation ${goRouter.value.location}");
            if (prevPath == goRouter.value.location) {
              binding.dependencies();
              final arg = state.extra;
              if (arg.hasData) {
                binding.argument = arg;
              }
            }
            if (goRouter.value.location == path &&
                binding.isDependenciesDeleted == false) {
              binding.unRegisterDependencies();
            }
            return newBuilder(context, state);
          },
          routes: routes,
        );

  final CustomBindings binding;
  final GoRouterWidgetBuilder newBuilder;
}

class GoReplaceRouteWithBinding extends GoRoute {
  GoReplaceRouteWithBinding({
    required this.newBuilder,
    required this.binding,
    required String path,
    List<RouteBase> routes = const <RouteBase>[],
    String? prevPath,
  }) : super(
          path: path,
          builder: (context, state) {
            binding.dependencies();
            return newBuilder(context, state);
          },
          routes: routes,
        );

  final CustomBindings binding;
  final GoRouterWidgetBuilder newBuilder;
}
