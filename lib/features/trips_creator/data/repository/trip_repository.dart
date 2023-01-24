import 'package:drone_service/features/trips_creator/data/datasources/trip_datasource.dart';

import '../../DTOs/input_file_dto.dart';

class TripRepository {
  TripRepository() : _dataSource = TripDataSource();

  final TripDataSource _dataSource;
  Future<InputFileDTO> getInputFileData(String inputFilePath) async =>
      await _dataSource.getInputFileData(inputFilePath);
}
