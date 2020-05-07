# Manufacturer
A Manufacturer is used to refer to the Airliner's manufacturer in the system.

#### AircraftTypes
This contains some basic information about an aircraft's type like name, description.

An AircraftType has_one Manufacturer associated with it.

### Validations

#### Creation
**User provided values:**
- `*name` the name of the manufacturer.
- `description` description of the manufacturer.

*Required fields:*
- `*name` must be provided for manufacturer.

*Duplicate validation:*
- `*name` must be unique one and should not duplicate with an existing manufacturer name.

#### Deletion

*Delete prevention validation:*
- Will not allow to delete a manufacturer if it has any associated aircrafttypes data.
