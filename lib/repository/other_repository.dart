import 'package:keuangan/provider/other_provider.dart';

class OtherRepository {
  final OtherProvider _otherProvider = OtherProvider();

  Future<Object> getInitData() {
    return _otherProvider.getInitData();
  }
}
