part of fennec;

///[IsolateTaskHandler] is an abstract class that will handle different Task of isolates.
abstract class IsolateTaskHandler {
  FutureOr<void> onStart(IsolateContext context) {}

  FutureOr<void> onStop(IsolateContext context) {}

  FutureOr<void> onPause(IsolateContext context) {}

  FutureOr<void> onResume(IsolateContext context) {}

  FutureOr<void> onDispose(IsolateContext context) {}
}
