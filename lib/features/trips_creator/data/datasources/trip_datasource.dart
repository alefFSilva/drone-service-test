import 'dart:io';

import '../../DTOs/input_file_dto.dart';
import '../models/drone_model.dart';
import '../models/location_model.dart';

class TripDataSource {
  Future<InputFileDTO> getInputFileData(String inputFilePath) async {
    List<String> fileContent = await File(inputFilePath).readAsLines();

    List<DroneModel> droneList = [];
    List<LocationModel> locationList = [];
    for (String line in fileContent) {
      bool isDroneLine = line.contains('Drone');

      if (isDroneLine) {
        String droneName = '';
        _getLineData(
          line: line,
          keyToFind: 'Drone',
          onKeyFound: (String keyValue) => droneName = keyValue,
          orElse: (String droneCapacity) => droneList.add(
            DroneModel(
              name: droneName,
              capacity: int.parse(droneCapacity),
            ),
          ),
        );
      } else {
        String locationName = '';
        _getLineData(
          line: line,
          keyToFind: 'Location',
          onKeyFound: (String keyValue) => locationName = keyValue,
          orElse: (String locationOrderWeight) => locationList.add(
            LocationModel(
              name: locationName,
              orderWeight: int.parse(locationOrderWeight),
            ),
          ),
        );
      }
    }

    return InputFileDTO(
      dronesList: droneList,
      locationsList: locationList,
    );
  }

  void _getLineData({
    required String line,
    required String keyToFind,
    required Function(String) onKeyFound,
    required Function(String) orElse,
  }) {
    List<String> lineData = line.split(',');

    for (String data in lineData) {
      bool isKeyData = data.contains(keyToFind);
      String sanitizedData =
          data.trim().replaceAll('[', '').replaceAll(']', '');

      isKeyData ? onKeyFound(sanitizedData) : orElse(sanitizedData);
    }
  }
}
