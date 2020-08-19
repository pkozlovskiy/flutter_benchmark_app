import 'package:flutter_benchmark_app/main.dart' as app;
import 'package:flutter_driver/driver_extension.dart';

void main() {
  enableFlutterDriverExtension();
  app.main();
  //TODO select needed mode
//  app.mainCompute()
}
