import 'package:keuangan/model/response_init_data.dart';

import '../provider/trx_provider.dart';

class TrxRepository {
  final TrxApiProvider _trxApiProvider = TrxApiProvider();

  Future<Object> getTrx() {
    return _trxApiProvider.getTrx();
  }
}
