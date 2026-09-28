# NASA Horizons Parser
A parser for NASA Horizons API request responses. Hecho en Puerto Rico por Radamés Jomuel Valentín Reyes

# Note:
Regular Expressions used to parse the data made using AI (Gemini).

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
## Major Body Ephemeris Data
Request URL:
~~~
https://ssd.jpl.nasa.gov/api/horizons.api?format=text&COMMAND=299&EPHEM_TYPE=VECTORS&START_TIME=2026-01-01&STOP_TIME=2026-01-20&STEP_SIZE=1 d&MAKE_EPHEM=YES
~~~
Response Parser Function:
~~~dart
MajorBodyEphemerisData majorBodyEphemerisData = parseMajorBodyEphemeris(nasaHorizonsApiResponse: requestResponse);
~~~