import 'package:keuangan/repository/trx_repository.dart';
import 'package:rxdart/rxdart.dart';

class TrxBloc {
  final TrxRepository _trxRepository = TrxRepository();
  final BehaviorSubject<Object> _trxAll = BehaviorSubject<Object>();

  getTrx() async {
    Object response = await _trxRepository.getTrx();
    _trxAll.sink.add(response);
  }

  dispose() async {
    await _trxAll.drain();
    _trxAll.close();
  }

  BehaviorSubject<Object> get trxAll => _trxAll;
}

final trxBloc = TrxBloc();
