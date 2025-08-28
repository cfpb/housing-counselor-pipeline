# Housing counselor pipeline

Pipeline to keep data fresh for https://www.consumerfinance.gov/find-a-housing-counselor/

Mainly consists of two management commands:
 - `hud_generate_json` to make per-zipcode json files from HUD housing counselor data
 - `hud_generate_html` which ingests the above json and creates html files from it

Internally, we pass these html files to a pdf generator so that pdfs are easily downloadable at stable endpoints.

There is also a third, rarely run, management command `hud_geocode_zipcodes` which geocodes all zipcodes if a mapbox access token is set.
