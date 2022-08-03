import 'package:keuangan/repository/other_repository.dart';
import 'package:rxdart/rxdart.dart';

class OtherBloc {
  OtherRepository _otherRepository = OtherRepository();
  final BehaviorSubject<Object> _initAll = BehaviorSubject<Object>();

  getTrx() async {
    Object response = await _otherRepository.getInitData();
    _initAll.sink.add(response);
  }

  dispose() async {
    await _initAll.drain();
    _initAll.close();
  }

  BehaviorSubject<Object> get initAll => _initAll;
}

final otherBloc = OtherBloc();
