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
  test("Major Body Ephemeris Data", (){
    String requestResponse = File("./test-files/ephemeris-data.txt").readAsStringSync();
    MajorBodyEphemerisData majorBodyEphemerisData = parseMajorBodyEphemeris(nasaHorizonsApiResponse: requestResponse);
    print("--- PHYSICAL DATA PARSED RESULTS ---");
    print("Mean Radius (km): ${majorBodyEphemerisData.meanRadius}");
    print("Density (g/cm^3): ${majorBodyEphemerisData.density}");
    print("Mass (x10^23 kg): ${majorBodyEphemerisData.mass}");
    print("Volume (x10^10 km^3): ${majorBodyEphemerisData.volume}");
    print("Sidereal Rot. Period (days): ${majorBodyEphemerisData.siderealRotPeriodDays}");
    print("Sid. Rot. Rate (rad/s): ${majorBodyEphemerisData.siderealRotRate}");
    print("Mean Solar Day (days): ${majorBodyEphemerisData.meanSolarDay}");
    print("Equatorial Gravity (m/s^2): ${majorBodyEphemerisData.equatorialGravity}");
    print("Moment of Inertia: ${majorBodyEphemerisData.momentOfInertia}");
    print("Core Radius (km): ${majorBodyEphemerisData.coreRadius}");
    print("Geometric Albedo: ${majorBodyEphemerisData.geometricAlbedo}");
    print("Potential Love # k2: ${majorBodyEphemerisData.potentialLoveK2}");
    print("GM (km^3/s^2): ${majorBodyEphemerisData.gm}");
    print("Equatorial Radius Re (km): ${majorBodyEphemerisData.equatorialRadius}");
    print("GM 1-sigma (km^3/s^2): ${majorBodyEphemerisData.gmSigma}");
    print("Mass Ratio (Sun/Body): ${majorBodyEphemerisData.massRatioSunToBody}");
    print("Atmos. Pressure (bar): ${majorBodyEphemerisData.atmosPressure}");
    print("Max. Angular Diam (\"): ${majorBodyEphemerisData.maxAngularDiam}");
    print("Mean Temperature (K): ${majorBodyEphemerisData.meanTemperature}");
    print("Visual Mag V(1,0): ${majorBodyEphemerisData.visualMagV10}");
    print("Obliquity to Orbit (deg): ${majorBodyEphemerisData.obliquityToOrbit}");
    print("Hill's Sphere Radius Rp: ${majorBodyEphemerisData.hillsSphereRad}");
    print("Sidereal Orb. Period (years): ${majorBodyEphemerisData.siderealOrbPeriodYears}");
    print("Orbit Speed (km/s): ${majorBodyEphemerisData.orbitSpeed}");
    print("Sidereal Orb. Period (days): ${majorBodyEphemerisData.siderealOrbPeriodDays}");
    print("Escape Speed (km/s): ${majorBodyEphemerisData.escapeSpeed}");
    print("Solar Constant Mean (W/m^2): ${majorBodyEphemerisData.solarConstantMean}");
    print("Max Planetary IR Mean (W/m^2): ${majorBodyEphemerisData.maxPlanetaryIR}");
    print("Min Planetary IR Mean (W/m^2): ${majorBodyEphemerisData.minPlanetaryIR}");
    print("Ephemeris Data: ${majorBodyEphemerisData.spatialTemporalData}");
    print("------------------------------------");
  });
}