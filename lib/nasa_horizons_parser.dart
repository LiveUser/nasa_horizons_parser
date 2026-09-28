import 'package:any_date/any_date.dart';

class MajorBody{
  new({
    required this.id,
    required this.name,
    required this.designation,
    required this.iau,
  });
  final int id;
  final String name;
  final String designation;
  final String iau;
}
class Vector3{
  new({
    required this.x,
    required this.y,
    required this.z,
  });
  final double x;
  final double y;
  final double z;
}
class SpatialTemporalData{
  new({
    required this.position,
    required this.velocity,
  });
  final Vector3 position;
  final Vector3 velocity;
}
class MajorBodyEphemerisData {
  new({
    required this.meanRadius,
    required this.density,
    required this.mass,
    required this.volume,
    required this.siderealRotPeriodDays,
    required this.siderealRotRate,
    required this.meanSolarDay,
    required this.equatorialGravity,
    required this.momentOfInertia,
    required this.coreRadius,
    required this.geometricAlbedo,
    required this.potentialLoveK2,
    required this.gm,
    required this.equatorialRadius,
    required this.gmSigma,
    required this.massRatioSunToBody,
    required this.atmosPressure,
    required this.maxAngularDiam,
    required this.meanTemperature,
    required this.visualMagV10,
    required this.obliquityToOrbit,
    required this.hillsSphereRad,
    required this.siderealOrbPeriodYears,
    required this.orbitSpeed,
    required this.siderealOrbPeriodDays,
    required this.escapeSpeed,
    required this.solarConstantMean,
    required this.maxPlanetaryIR,
    required this.minPlanetaryIR,
    required this.spatialTemporalData,
  });

  final double? meanRadius;
  final double? density;
  final double? mass;
  final double? volume;
  final double? siderealRotPeriodDays;
  final double? siderealRotRate;
  final double? meanSolarDay;
  final double? equatorialGravity;
  final double? momentOfInertia;
  final double? coreRadius;
  final double? geometricAlbedo;
  final double? potentialLoveK2;
  final double? gm;
  final double? equatorialRadius;
  final double? gmSigma;
  final double? massRatioSunToBody;
  final double? atmosPressure;
  final double? maxAngularDiam;
  final double? meanTemperature;
  final double? visualMagV10;
  final double? obliquityToOrbit;
  final double? hillsSphereRad;
  final double? siderealOrbPeriodYears;
  final double? orbitSpeed;
  final double? siderealOrbPeriodDays;
  final double? escapeSpeed;
  final double? solarConstantMean;
  final double? maxPlanetaryIR;
  final double? minPlanetaryIR;
  final Map<DateTime,SpatialTemporalData> spatialTemporalData;
}
List<MajorBody> parseMajorBodiesList({
  required String nasaHorizonsApiResponse,
}){
  List<MajorBody> majorBodies = [];
  //Split response per each line
  List<String> lines = nasaHorizonsApiResponse.split("\n");
  //Try to parse each line and add it if parsing was succesful
  for(String line in lines){
    try{
      int id = int.parse(line.substring(0,10));
      String name = line.substring(11,46).trim();
      String designation = line.substring(46,56).trim();
      String iau = line.substring(57,line.length).trim();
      majorBodies.add(MajorBody(
        id: id, 
        name: name, 
        designation: designation, 
        iau: iau,
      ));
    }catch(error){
      //Do nothing
    }
  }
  return majorBodies;
}
MajorBodyEphemerisData parseMajorBodyEphemeris({
  required String nasaHorizonsApiResponse,
}) {
  // Helper to safely parse a regex match into a double and apply key scale exponent if present
  double? parseScaledMatch(RegExp regExp) {
    RegExpMatch? match = regExp.firstMatch(nasaHorizonsApiResponse);
    if (match != null) {
      double scaleFactor = 1.0;
      
      // Group 1 captures integer exponent inside 10^N if present
      if (match.groupCount >= 1 && match.group(1) != null && match.group(1)!.isNotEmpty) {
        int? exponent = int.tryParse(match.group(1)!);
        if (exponent != null) {
          scaleFactor = double.parse('1e$exponent');
        }
      }

      // Group 2 captures the target numeric value
      if (match.groupCount >= 2 && match.group(2) != null) {
        double? baseValue = double.tryParse(match.group(2)!);
        if (baseValue != null) {
          return baseValue * scaleFactor;
        }
      }
    }
    return null;
  }

  // Base regex pattern matching standard floats, scientific notation, and optional approximation prefix
  const String numPattern = r'[~+-]?\s*([+-]?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?)';
  
  // Scale pattern specifically matching x10^23, *10^10, or (x10^10 ...)
  const String scalePattern = r'(?:(?:\(?[x*]?10\^(\d+)\)?[^\n=]*=)|=)';

  // Physical parameters
  double? meanRadius = parseScaledMatch(RegExp(r'Vol\.\s*Mean\s*Radius\s*\(km\)\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? density = parseScaledMatch(RegExp(r'Density\s*\(g/cm\^3\)\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? mass = parseScaledMatch(RegExp(r'Mass\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? volume = parseScaledMatch(RegExp(r'Volume\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? siderealRotPeriodDays = parseScaledMatch(RegExp(r'Sidereal\s*rot\.\s*period\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? siderealRotRate = parseScaledMatch(RegExp(r'Sid\.\s*Rot\.\s*Rate\s*\(rad/s\)\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? meanSolarDay = parseScaledMatch(RegExp(r'Mean\s*solar\s*day\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? equatorialGravity = parseScaledMatch(RegExp(r'Equ\.\s*gravity\s*m/s\^2\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? momentOfInertia = parseScaledMatch(RegExp(r'Mom\.\s*of\s*Inertia\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? coreRadius = parseScaledMatch(RegExp(r'Core\s*radius\s*\(km\)\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? geometricAlbedo = parseScaledMatch(RegExp(r'Geometric\s*Albedo\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? potentialLoveK2 = parseScaledMatch(RegExp(r'Potential\s*Love\s*#\s*k2\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? gm = parseScaledMatch(RegExp(r'GM\s*\(km\^3/s\^2\)\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? equatorialRadius = parseScaledMatch(RegExp(r'Equatorial\s*Radius,\s*Re\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? gmSigma = parseScaledMatch(RegExp(r'GM\s*1-sigma\s*\(km\^3/s\^2\)\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? massRatioSunToBody = parseScaledMatch(RegExp(r'Mass\s*ratio\s*\(Sun/[^)]+\)\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? atmosPressure = parseScaledMatch(RegExp(r'Atmos\.\s*pressure\s*\(bar\)\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? maxAngularDiam = parseScaledMatch(RegExp(r'Max\.\s*angular\s*diam\.\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? meanTemperature = parseScaledMatch(RegExp(r'Mean\s*Temperature\s*\(K\)\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? visualMagV10 = parseScaledMatch(RegExp(r'Visual\s*mag\.\s*V\(1,0\)\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? obliquityToOrbit = parseScaledMatch(RegExp(r'Obliquity\s*to\s*orbit\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? hillsSphereRad = parseScaledMatch(RegExp(r'Hill\x27s\s*sphere\s*rad\.,Rp\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? siderealOrbPeriodYears = parseScaledMatch(RegExp(r'Sidereal\s*orb\.\s*per\.,\s*y\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? orbitSpeed = parseScaledMatch(RegExp(r'Orbit\s*speed,\s*km/s\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? siderealOrbPeriodDays = parseScaledMatch(RegExp(r'Sidereal\s*orb\.\s*per\.,\s*d\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? escapeSpeed = parseScaledMatch(RegExp(r'Escape\s*speed,\s*km/s\s*' + scalePattern + r'\s*' + numPattern, caseSensitive: false));
  double? solarConstantMean = parseScaledMatch(RegExp(r'Solar\s*Constant\s*\(W/m\^2\)\s+' + scalePattern + r'?(?:\s+[^\s]+){2}\s*' + numPattern, caseSensitive: false));
  double? maxPlanetaryIR = parseScaledMatch(RegExp(r'Maximum\s*Planetary\s*IR\s*\(W/m\^2\)\s+' + scalePattern + r'?(?:\s+[^\s]+){2}\s*' + numPattern, caseSensitive: false));
  double? minPlanetaryIR = parseScaledMatch(RegExp(r'Minimum\s*Planetary\s*IR\s*\(W/m\^2\)\s+' + scalePattern + r'?(?:\s+[^\s]+){2}\s*' + numPattern, caseSensitive: false));

  // --- PARSE EPHEMERIS DATA ($$SOE to $$EOE) ---
  Map<DateTime, SpatialTemporalData> spatialTemporalData = {};

  final String ephemerisSection = nasaHorizonsApiResponse.substring(
    nasaHorizonsApiResponse.indexOf(r'$$SOE') + 5,
    nasaHorizonsApiResponse.indexOf(r'$$EOE'),
  );

  final vectorBlockRegex = RegExp(
    r'[\d\.]+\s*=\s*A\.D\.\s*([\d]{4}-[A-Za-z]{3}-[\d]{2}\s*[\d:]+\.[\d]+)\s*[A-Z]+\s*\n'
    r'\s*X\s*=\s*([^\s]+)\s+Y\s*=\s*([^\s]+)\s+Z\s*=\s*([^\s]+)\s*\n'
    r'\s*VX\s*=\s*([^\s]+)\s+VY\s*=\s*([^\s]+)\s+VZ\s*=\s*([^\s]+)',
    multiLine: true,
  );

  for (final match in vectorBlockRegex.allMatches(ephemerisSection)) {
    final dateStr = match.group(1)!;
    final x = double.parse(match.group(2)!);
    final y = double.parse(match.group(3)!);
    final z = double.parse(match.group(4)!);
    final vx = double.parse(match.group(5)!);
    final vy = double.parse(match.group(6)!);
    final vz = double.parse(match.group(7)!);

    AnyDate anyDate = AnyDate();
    spatialTemporalData[anyDate.parse(dateStr)] = SpatialTemporalData(
      position: Vector3(x: x, y: y, z: z),
      velocity: Vector3(x: vx, y: vy, z: vz),
    );
  }

  return MajorBodyEphemerisData(
    meanRadius: meanRadius,
    density: density,
    mass: mass,
    volume: volume,
    siderealRotPeriodDays: siderealRotPeriodDays,
    siderealRotRate: siderealRotRate,
    meanSolarDay: meanSolarDay,
    equatorialGravity: equatorialGravity,
    momentOfInertia: momentOfInertia,
    coreRadius: coreRadius,
    geometricAlbedo: geometricAlbedo,
    potentialLoveK2: potentialLoveK2,
    gm: gm,
    equatorialRadius: equatorialRadius,
    gmSigma: gmSigma,
    massRatioSunToBody: massRatioSunToBody,
    atmosPressure: atmosPressure,
    maxAngularDiam: maxAngularDiam,
    meanTemperature: meanTemperature,
    visualMagV10: visualMagV10,
    obliquityToOrbit: obliquityToOrbit,
    hillsSphereRad: hillsSphereRad,
    siderealOrbPeriodYears: siderealOrbPeriodYears,
    orbitSpeed: orbitSpeed,
    siderealOrbPeriodDays: siderealOrbPeriodDays,
    escapeSpeed: escapeSpeed,
    solarConstantMean: solarConstantMean,
    maxPlanetaryIR: maxPlanetaryIR,
    minPlanetaryIR: minPlanetaryIR,
    spatialTemporalData: spatialTemporalData,
  );
}