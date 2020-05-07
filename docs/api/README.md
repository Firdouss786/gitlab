The Servo 2.X API
==================
Welcome to the Servo 2.X API! This new API has been completely redesigned, and so both the API endpoints and authentication method are not backwards compatible with Servo 1.X.

The Servo 2.X API is organized around REST. Our API has predictable resource-oriented URLs, returns JSON-encoded responses, and uses standard HTTP response codes, authentication, and verbs.


Authentication
--------------

Servo provides API authentication via an access token. A user may request an access token via their Servo profile page.

You can then pass this token in with every request to the API within the header:
`curl -s -H "Authorization: Bearer token=your_token" https://firefly.staging.topcareife.com/airlines.json`


Making a request
----------------

URLs are HTTPS only. All URL's should be appended with the `.json` extension, for example `https://firefly.staging.topcareife.com/airlines.json`

Also before making any request your account must active that is not locked.  All locked user request will result in a 404 error.

Resources & Collections
----------
Resources are expressed in the singular - ie "Airline", with a resource collection being plural – "Airlines".


Expanding resources
----------
Many resources contain the ID of a related resource in their response properties. For example, an `Aircraft` may have an associated `Airline`. In many cases, we will automatically expand the associated resource, nesting it inside the response body. If the nested resource is not expanded, you can use the included URL to fetch the additional data. Here is an example of this:

`GET /aircraft/35.json`

###### Example JSON Response
```json
[
  {
    "id": 35,
    "registration": "G-STBA",
    "msn": "0891",
    "airline": {
      "id": 2,
      "icao_code": "BAW",
      "name": "British Airways",
      "url": "http://firefly.staging.topcareife.com/airlines/2.json"
    }
  }
]
```


Pagination
----------

Most resource collection APIs paginate their results. We follow the [RFC5988 convention](https://tools.ietf.org/html/rfc5988) of using the `Link` header to provide URLs for the `next` page.

```
Link: <https://firefly.staging.topcareife.com/airlines.json?page=2>; rel="next"
```

If the `Link` header is blank, that's the last page.


Handling errors
---------------

### [5xx server errors](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#5xx_Server_errors)

You will get a 5xx status code indicating a server error if Servo is having problems. 500 (Internal Server Error), 502 (Bad Gateway), 503 (Service Unavailable), and 504 (Gateway Timeout) may be retried with [exponential backoff](https://en.wikipedia.org/wiki/Exponential_backoff).

### 404 Not Found

API requests may 404 due to missing data, such as a deleted record, inactive account etc.

API endpoints
-------------
- [Airlines](./sections/airlines.md)
- [Aircraft Configurations](./sections/fleets.md)
- [Aircrafts](./sections/aircrafts.md)
- [Comments](./sections/comments.md)
- [Faults](./sections/faults.md)
- [Seats](./sections/seats.md)