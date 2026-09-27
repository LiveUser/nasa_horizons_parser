import 'package:nasa_horizons_parser/nasa_horizons_parser.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  test('Major Bodies list parsing', () {
    String requestResponse = File("./test-files/major-bodies-list.txt").readAsStringSync();
    List<MajorBody> majorBodies = parseMajorBodiesList(nasaHorizonsApiResponse: requestResponse);
    for(MajorBody majorBody in majorBodies){
      print("Id:${majorBody.id} Name:${majorBody.name} Designation:${majorBody.designation} IAU:${majorBody.iau}");
    }
  });
}
