# NASA Horizons Parser
A parser for NASA Horizons API request responses. Hecho en Puerto Rico por Radamés Jomuel Valentín Reyes

# Requests and parser functions
## List Major Bodies
Request URL:
~~~
https://ssd.jpl.nasa.gov/api/horizons.api?format=text&COMMAND='MB'
~~~
Response Parser Function:
~~~dart
List<MajorBody> majorBodies = parseMajorBodiesList(nasaHorizonsApiResponse: requestResponse);
~~~