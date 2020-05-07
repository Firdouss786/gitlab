Seats
=========
An AircraftConfig has many seats. Each seat contains some basic information about its position on the aircraft.

Endpoints:

- [Get seats](#get-seats)

Get seats
-------------

* `GET /fleets/:id/seats.json`

###### Example JSON Response
```json
[
  {
    "name": "29J",
    "col": "J",
    "row": 29,
    "deck": 1,
    "travel_class": "4"
  },
  {
    "name": "31F",
    "col": "F",
    "row": 31,
    "deck": 1,
    "travel_class": "4"
  },
  {
    "name": "30E",
    "col": "E",
    "row": 30,
    "deck": 1,
    "travel_class": "4"
  },
  {
    "name": "14K",
    "col": "K",
    "row": 14,
    "deck": 1,
    "travel_class": "2"
  }
]
```
