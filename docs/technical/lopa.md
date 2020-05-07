# Overview
LOPA (Layout of Passenger Accommodation). This is the term used to describe both the widget (for the user to select seats) and the backend code to support the data model and parsing.

### Data model

#### AircraftConfig
This contains some basic information about the aircraft configuration such as line fit type, seat counts, and platform.

The AircraftConfig has_one ConfigFile.

#### ConfigFile
This model represents the attached source file which will be used to populate the seats table.

The config file could either be a seat.dat (file taken from the IFE system itself) or an excel template.

 - fleet_id
 - file_type
 - uploaded_by
 - file

#### Seats
The seats contain the majority of the information. They are associated directly with the aircraft config. The index page for seats will be the LOPA, which is extracted to a partial for re-use in different pages.

 - lopa_id
 - name
 - col
 - row
 - travel_class
 - deck
 - dsu_primary
 - dsu_secondary


### Parsing
Thales legacy systems come with a seat.dat file which can be easily parsed. However there is no such file for the LTV systems. Therefore we need to provide a template which will be filed out by a support personnel and consumed by Firefly.

This section will describe how the parsing mechanism works.
