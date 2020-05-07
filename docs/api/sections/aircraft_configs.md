Aircraft Configs
=========
An AircraftConfig contains some basic information about the configuration

Endpoints:

- [Get Aircraft Configs](#get-aircraft-configs)
- [Get An Aircraft Config](#get-an-aircraft-config)

Get Aircraft Configs
-------------

* `GET /airlines/:id/fleets.json`

###### Example JSON Response
```json
[
  {
    "id": 432519556,
    "name": "BA B772R-A I5 CONFIG",
    "description": null,
    "install_type": "Retrofit",
    "lopa_path": null,
    "aircraft_type": {
      "id": 923410199,
      "name": "B777-200",
      "description": null,
      "manufacturer_id": 214608420,
      "created_at": "2019-02-26T19:27:59.000Z",
      "updated_at": "2019-02-26T19:27:59.000Z"
    },
    "software_platform": {
      "id": 980190962,
      "name": "i5000",
      "description": "i5000",
      "created_at": "2019-02-26T19:28:00.000Z",
      "updated_at": "2019-02-26T19:28:00.000Z"
    },
    "airline": {
      "id": 110458917,
      "iata_code": "BA",
      "icao_code": "BAW",
      "name": "British Airways",
      "alias": null,
      "callsign": "SPEEDBIRD",
      "country": "United Kingdom",
      "customer": true,
      "description": null,
      "created_at": "2019-02-26T19:27:59.000Z",
      "updated_at": "2019-02-26T19:27:59.000Z",
      "state": "active"
    },
    "created_at": "2019-02-26T19:27:59.000Z",
    "updated_at": "2019-02-26T19:27:59.000Z",
    "url": "http://firefly.staging.topcareife.com/fleets/432519556.json"
  },
  {
    "id": 538726323,
    "name": "BA B772R-B I5 CONFIG",
    "description": null,
    "install_type": "Retrofit",
    "lopa_path": null,
    "aircraft_type": {
      "id": 923410199,
      "name": "B777-200",
      "description": null,
      "manufacturer_id": 214608420,
      "created_at": "2019-02-26T19:27:59.000Z",
      "updated_at": "2019-02-26T19:27:59.000Z"
    },
    "software_platform": {
      "id": 980190962,
      "name": "i5000",
      "description": "i5000",
      "created_at": "2019-02-26T19:28:00.000Z",
      "updated_at": "2019-02-26T19:28:00.000Z"
    },
    "airline": {
      "id": 110458917,
      "iata_code": "BA",
      "icao_code": "BAW",
      "name": "British Airways",
      "alias": null,
      "callsign": "SPEEDBIRD",
      "country": "United Kingdom",
      "customer": true,
      "description": null,
      "created_at": "2019-02-26T19:27:59.000Z",
      "updated_at": "2019-02-26T19:27:59.000Z",
      "state": "active"
    },
    "created_at": "2019-02-26T19:27:59.000Z",
    "updated_at": "2019-02-26T19:27:59.000Z",
    "url": "http://firefly.staging.topcareife.com/fleets/538726323.json"
  }
]
```

Get An Aircraft Config
-------------

* `GET /airlines/:id/fleets/538726323.json`

###### Example JSON Response
```json
{
  "id": 538726323,
  "name": "BA B772R-B I5 CONFIG",
  "description": null,
  "install_type": "Retrofit",
  "lopa_path": null,
  "aircraft_type": {
    "id": 923410199,
    "name": "B777-200",
    "description": null,
    "manufacturer_id": 214608420,
    "created_at": "2019-02-26T19:27:59.000Z",
    "updated_at": "2019-02-26T19:27:59.000Z"
  },
  "software_platform": {
    "id": 980190962,
    "name": "i5000",
    "description": "i5000",
    "created_at": "2019-02-26T19:28:00.000Z",
    "updated_at": "2019-02-26T19:28:00.000Z"
  },
  "airline": {
    "id": 110458917,
    "iata_code": "BA",
    "icao_code": "BAW",
    "name": "British Airways",
    "alias": null,
    "callsign": "SPEEDBIRD",
    "country": "United Kingdom",
    "customer": true,
    "description": null,
    "created_at": "2019-02-26T19:27:59.000Z",
    "updated_at": "2019-02-26T19:27:59.000Z",
    "state": "active"
  },
  "created_at": "2019-02-26T19:27:59.000Z",
  "updated_at": "2019-02-26T19:27:59.000Z",
  "url": "http://firefly.staging.topcareife.com/fleets/538726323.json"
}
```
