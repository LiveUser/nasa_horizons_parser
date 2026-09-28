class MajorBody{
  MajorBody({
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
class MajorBodyEphemerisData {
  MajorBodyEphemerisData({
    this.meanRadius,
    this.density,
    this.mass,
    this.volume,
    this.siderealRotPeriodDays,
    this.siderealRotRate,
    this.meanSolarDay,
    this.equatorialGravity,
    this.momentOfInertia,
    this.coreRadius,
    this.geometricAlbedo,
    this.potentialLoveK2,
    this.gm,
    this.equatorialRadius,
    this.gmSigma,
    this.massRatioSunToBody,
    this.atmosPressure,
    this.maxAngularDiam,
    this.meanTemperature,
    this.visualMagV10,
    this.obliquityToOrbit,
    this.hillsSphereRad,
    this.siderealOrbPeriodYears,
    this.orbitSpeed,
    this.siderealOrbPeriodDays,
    this.escapeSpeed,
    this.solarConstantMean,
    this.maxPlanetaryIR,
    this.minPlanetaryIR,
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
  // Helper to safely parse a regex match into a double
  double? parseMatch(RegExp regExp) {
    RegExpMatch? match = regExp.firstMatch(nasaHorizonsApiResponse);
    if (match != null && match.group(1) != null) {
      return double.tryParse(match.group(1)!);
    }
    return null;
  }

  // Generic pattern for numbers (supports negative numbers, floats, approximate '~', and scientific notation)
  const String numPattern = r'[~+-]?\s*([+-]?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?)';

  // Vol. Mean Radius
  RegExp meanRadiusRegExp = RegExp(r'Vol\.\s*Mean\s*Radius\s*\(km\)\s*=\s*' + numPattern, caseSensitive: false);
  double? meanRadius = parseMatch(meanRadiusRegExp);

  // Density
  RegExp densityRegExp = RegExp(r'Density\s*\(g/cm\^3\)\s*=\s*' + numPattern, caseSensitive: false);
  double? density = parseMatch(densityRegExp);

  // Mass
  RegExp massRegExp = RegExp(r'Mass\s*x10\^\d+\s*\(kg\)\s*=\s*' + numPattern, caseSensitive: false);
  double? mass = parseMatch(massRegExp);

  // Volume
  RegExp volumeRegExp = RegExp(r'Volume\s*\(x10\^\d+\s*km\^3\)\s*=\s*' + numPattern, caseSensitive: false);
  double? volume = parseMatch(volumeRegExp);

  // Sidereal rotation period (days)
  RegExp siderealRotPeriodDaysRegExp = RegExp(r'Sidereal\s*rot\.\s*period\s*=\s*' + numPattern, caseSensitive: false);
  double? siderealRotPeriodDays = parseMatch(siderealRotPeriodDaysRegExp);

  // Sidereal rotation rate (rad/s)
  RegExp siderealRotRateRegExp = RegExp(r'Sid\.\s*Rot\.\s*Rate\s*\(rad/s\)=\s*' + numPattern, caseSensitive: false);
  double? siderealRotRate = parseMatch(siderealRotRateRegExp);

  // Mean solar day
  RegExp meanSolarDayRegExp = RegExp(r'Mean\s*solar\s*day\s*=\s*' + numPattern, caseSensitive: false);
  double? meanSolarDay = parseMatch(meanSolarDayRegExp);

  // Equatorial gravity
  RegExp equatorialGravityRegExp = RegExp(r'Equ\.\s*gravity\s*m/s\^2\s*=\s*' + numPattern, caseSensitive: false);
  double? equatorialGravity = parseMatch(equatorialGravityRegExp);

  // Moment of Inertia
  RegExp momentOfInertiaRegExp = RegExp(r'Mom\.\s*of\s*Inertia\s*=\s*' + numPattern, caseSensitive: false);
  double? momentOfInertia = parseMatch(momentOfInertiaRegExp);

  // Core radius
  RegExp coreRadiusRegExp = RegExp(r'Core\s*radius\s*\(km\)\s*=\s*' + numPattern, caseSensitive: false);
  double? coreRadius = parseMatch(coreRadiusRegExp);

  // Geometric Albedo
  RegExp geometricAlbedoRegExp = RegExp(r'Geometric\s*Albedo\s*=\s*' + numPattern, caseSensitive: false);
  double? geometricAlbedo = parseMatch(geometricAlbedoRegExp);

  // Potential Love # k2
  RegExp potentialLoveK2RegExp = RegExp(r'Potential\s*Love\s*#\s*k2\s*=\s*' + numPattern, caseSensitive: false);
  double? potentialLoveK2 = parseMatch(potentialLoveK2RegExp);

  // GM
  RegExp gmRegExp = RegExp(r'GM\s*\(km\^3/s\^2\)\s*=\s*' + numPattern, caseSensitive: false);
  double? gm = parseMatch(gmRegExp);

  // Equatorial Radius
  RegExp equatorialRadiusRegExp = RegExp(r'Equatorial\s*Radius,\s*Re\s*=\s*' + numPattern, caseSensitive: false);
  double? equatorialRadius = parseMatch(equatorialRadiusRegExp);

  // GM 1-sigma
  RegExp gmSigmaRegExp = RegExp(r'GM\s*1-sigma\s*\(km\^3/s\^2\)\s*=\s*' + numPattern, caseSensitive: false);
  double? gmSigma = parseMatch(gmSigmaRegExp);

  // Mass ratio (Sun / Target Body)
  RegExp massRatioSunToBodyRegExp = RegExp(r'Mass\s*ratio\s*\(Sun/[^)]+\)\s*=\s*' + numPattern, caseSensitive: false);
  double? massRatioSunToBody = parseMatch(massRatioSunToBodyRegExp);

  // Atmospheric pressure
  RegExp atmosPressureRegExp = RegExp(r'Atmos\.\s*pressure\s*\(bar\)\s*=\s*' + numPattern, caseSensitive: false);
  double? atmosPressure = parseMatch(atmosPressureRegExp);

  // Max angular diameter
  RegExp maxAngularDiamRegExp = RegExp(r'Max\.\s*angular\s*diam\.\s*=\s*' + numPattern, caseSensitive: false);
  double? maxAngularDiam = parseMatch(maxAngularDiamRegExp);

  // Mean Temperature
  RegExp meanTemperatureRegExp = RegExp(r'Mean\s*Temperature\s*\(K\)\s*=\s*' + numPattern, caseSensitive: false);
  double? meanTemperature = parseMatch(meanTemperatureRegExp);

  // Visual mag V(1,0)
  RegExp visualMagV10RegExp = RegExp(r'Visual\s*mag\.\s*V\(1,0\)\s*=\s*' + numPattern, caseSensitive: false);
  double? visualMagV10 = parseMatch(visualMagV10RegExp);

  // Obliquity to orbit
  RegExp obliquityToOrbitRegExp = RegExp(r'Obliquity\s*to\s*orbit\s*=\s*' + numPattern, caseSensitive: false);
  double? obliquityToOrbit = parseMatch(obliquityToOrbitRegExp);

  // Hill's sphere radius
  RegExp hillsSphereRadRegExp = RegExp(r'Hill\x27s\s*sphere\s*rad\.,Rp\s*=\s*' + numPattern, caseSensitive: false);
  double? hillsSphereRad = parseMatch(hillsSphereRadRegExp);

  // Sidereal orbital period (years)
  RegExp siderealOrbPeriodYearsRegExp = RegExp(r'Sidereal\s*orb\.\s*per\.,\s*y\s*=\s*' + numPattern, caseSensitive: false);
  double? siderealOrbPeriodYears = parseMatch(siderealOrbPeriodYearsRegExp);

  // Orbit speed
  RegExp orbitSpeedRegExp = RegExp(r'Orbit\s*speed,\s*km/s\s*=\s*' + numPattern, caseSensitive: false);
  double? orbitSpeed = parseMatch(orbitSpeedRegExp);

  // Sidereal orbital period (days)
  RegExp siderealOrbPeriodDaysRegExp = RegExp(r'Sidereal\s*orb\.\s*per\.,\s*d\s*=\s*' + numPattern, caseSensitive: false);
  double? siderealOrbPeriodDays = parseMatch(siderealOrbPeriodDaysRegExp);

  // Escape speed
  RegExp escapeSpeedRegExp = RegExp(r'Escape\s*speed,\s*km/s\s*=\s*' + numPattern, caseSensitive: false);
  double? escapeSpeed = parseMatch(escapeSpeedRegExp);

  // Solar Constant (Mean column)
  RegExp solarConstantMeanRegExp = RegExp(r'Solar\s*Constant\s*\(W/m\^2\)\s+\d+\s+\d+\s+' + numPattern, caseSensitive: false);
  double? solarConstantMean = parseMatch(solarConstantMeanRegExp);

  // Maximum Planetary IR (Mean column)
  RegExp maxPlanetaryIRRegExp = RegExp(r'Maximum\s*Planetary\s*IR\s*\(W/m\^2\)\s+\d+\s+\d+\s+' + numPattern, caseSensitive: false);
  double? maxPlanetaryIR = parseMatch(maxPlanetaryIRRegExp);

  // Minimum Planetary IR (Mean column)
  RegExp minPlanetaryIRRegExp = RegExp(r'Minimum\s*Planetary\s*IR\s*\(W/m\^2\)\s+\d+\s+\d+\s+' + numPattern, caseSensitive: false);
  double? minPlanetaryIR = parseMatch(minPlanetaryIRRegExp);

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
  );
}