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