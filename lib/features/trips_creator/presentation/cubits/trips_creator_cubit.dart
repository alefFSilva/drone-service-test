import 'dart:io';

import 'package:drone_service/features/trips_creator/data/repository/trip_repository.dart';
import 'package:drone_service/features/trips_creator/domain/entities/location.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../DTOs/input_file_dto.dart';
import '../../domain/entities/drone.dart';
import 'trips_creator_state.dart';

class TripsCreatorCubit extends Cubit<TripsCreatorState> {
  TripsCreatorCubit()
      : _repository = TripRepository(),
        _pathToSave = '',
        _filePath = '',
        super(
          TripsCreatorState.initial(),
        );

  late final TripRepository _repository;
  String _pathToSave;
  String _filePath;

  final Map<String, List<Trip>> _droneTripsMap = {};

  Future<void> pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null && result.paths.isNotEmpty) {
      String path = result.paths.first!;
      _filePath = path;
      emit(state.copyWith(isLoading: false, fileToLoad: path));
    }
  }

  Future<void> pickDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    _pathToSave = selectedDirectory!;
    emit(state.copyWith(isLoading: false, pathToSave: selectedDirectory));
  }

  Future<void> createTrips() async {
    InputFileDTO inputFileDTO = await _repository.getInputFileData(_filePath);

    _setTrips(
      inputFileDTO,
      inputFileDTO.dronesList,
      inputFileDTO.locationsList,
    );
    _writeTripsToFile();
  }

  void _setTrips(
    InputFileDTO inputFileDTO,
    List<Drone> droneList,
    List<Location> locationList,
  ) {
    locationList = _sortLocationsByOrderWeight(locationList);
    droneList = _sortDronesByCapacity(droneList);

    while (locationList.isNotEmpty) {
      if (droneList.isEmpty) {
        _setTrips(inputFileDTO, inputFileDTO.dronesList, locationList);
        return;
      }

      Trip newTrip = Trip();
      Drone drone = droneList.first;
      int droneCapacityRemain = drone.capacity;
      bool currentDroneIsAvaliable = true;

      while (currentDroneIsAvaliable && locationList.isNotEmpty) {
        Location location = locationList.first;
        bool droneHaveAvaliableCapacity =
            droneCapacityRemain >= location.orderWeight;

        if (!droneHaveAvaliableCapacity) {
          Location? locationFound = _findAWeightCompatibleLocation(
            locationList,
            maximumWeigth: droneCapacityRemain,
          );

          if (locationFound != null) {
            droneHaveAvaliableCapacity = true;
            location = locationFound;
          }
        }

        if (droneHaveAvaliableCapacity) {
          newTrip.locations.add(location);
          locationList.remove(location);
          droneCapacityRemain = droneCapacityRemain - location.orderWeight;
        } else {
          _addTripToMap(drone, newTrip);
          droneList.remove(drone);
          currentDroneIsAvaliable = false;
        }

        if (locationList.isEmpty) {
          _addTripToMap(drone, newTrip);
        }
      }
    }
  }

  void _addTripToMap(Drone drone, Trip newTrip) {
    if (!_droneTripsMap.containsKey(drone.name)) {
      _droneTripsMap[drone.name] = [newTrip];
    } else {
      final deliveries = _droneTripsMap[drone.name];
      deliveries!.add(newTrip);
    }
  }

  Location? _findAWeightCompatibleLocation(
    List<Location> locationList, {
    required int maximumWeigth,
  }) {
    Location? result;
    predicate(Location location) => location.orderWeight <= maximumWeigth;
    bool compatibleLocationFound = locationList.any(predicate);
    if (compatibleLocationFound) {
      result = locationList.where(predicate).first;
    }
    return result;
  }

  List<Location> _sortLocationsByOrderWeight(List<Location> listToSort) {
    locationComparator(Location a, Location b) => a.orderWeight.compareTo(
          b.orderWeight,
        );
    listToSort.sort(locationComparator);
    return listToSort.reversed.toList();
  }

  List<Drone> _sortDronesByCapacity(List<Drone> listToSort) {
    droneComparator(Drone a, Drone b) => a.capacity.compareTo(b.capacity);
    listToSort.sort(droneComparator);
    return listToSort.reversed.toList();
  }

  void _writeTripsToFile() {
    var fileToSave = File(
      '$_pathToSave/Output.txt',
    );
    final writer = fileToSave.openWrite();

    _droneTripsMap.forEach((
      String droneName,
      List<Trip> trips,
    ) {
      writer.writeln('[$droneName]');

      for (Trip trip in trips) {
        int tripNumber = trips.indexOf(trip) + 1;
        writer.writeln('Trip #$tripNumber');

        for (Location location in trip.locations) {
          String comma = trip.locations.last == location ? '' : ',';
          writer.write('[${location.name}]$comma');
        }
        writer.writeln();
      }
      writer.writeln();
    });
  }
}

class DroneDelivery {
  DroneDelivery({
    required this.drone,
    required this.trips,
  });
  Drone drone;
  List<Trip> trips;
}

class Trip {
  Trip() : locations = [];
  List<Location> locations;
}
