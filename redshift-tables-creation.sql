-- CREATE DATABASE flood_analytics;
-- Use flood_analytics;

CREATE TABLE date(
   date varchar(255), 
   year int, 
   PRIMARY KEY (date, year)
);

CREATE TABLE county(
   fips_code int, 
   county_name varchar(255),
   PRIMARY KEY (fips_code)
);

CREATE TABLE flood_events(
    event_id int PRIMARY KEY,
    date varchar(255),
    year int,
    fips_code int REFERENCES county(fips_code),
    location varchar(255), 
    lat float, 
    lng float,
    event_type varchar(255), 
    flood_cause varchar(255), 
    flood_impact_days int,
    FOREIGN KEY (date, year) REFERENCES date(date, year)
);


CREATE TABLE weather_stations(
    fips_code int REFERENCES county(fips_code),
    stationID varchar(255) PRIMARY KEY,
    lat float,
    lng float
);

CREATE TABLE weather(
   stationID varchar(255) REFERENCES weather_stations(stationID),
   date varchar(255),
   year int,
   PRCP float,
   SNOW float,
   SNWD float,
   TMAX float,
   TMIN float,
   FOREIGN KEY (date, year) REFERENCES date(date, year)
);

CREATE TABLE ca_county_yearly_insurance_stats(
    fips_code int REFERENCES county(fips_code),
    year int,
    log_insured float,
    log_cost float,
    policy_count int
);

CREATE TABLE county_daily_flood_weather(
    fw_id int PRIMARY KEY,
    date varchar(255),
    year int,
    fips_code int REFERENCES county(fips_code),
    flood_count int,
    PRCP_mean int,
    TEMP_mean int,
    SNOW_mean int,
    SNWD_mean int,
    FOREIGN KEY (date, year) REFERENCES date(date, year)
);


CREATE TABLE insurance(
   fima_record_id varchar(255),
   policy_date varchar(255), 
   year int,
   fips_code int REFERENCES county(fips_code),
   zip_code int, 
   flood_zone varchar(255),
   lat float, 
   lng float,
   occupancy_type varchar(255), 
   floors float,
   policy_cost int,
   total_building_insurance_coverage float,
   total_contents_insurance_coverage float,
   PRIMARY KEY (fima_record_id)
);


Copy county from 's3://data228-redshift/COUNTY.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."county";

Copy date from 's3://data228-redshift/DATE.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."date";
SELECT COUNT (*) FROM "dev"."public"."date";

Copy flood_events from 's3://data228-redshift/FLOOD_EVENTS.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."flood_events";
SELECT COUNT (*) FROM "dev"."public"."flood_events";


Copy weather_stations from 's3://data228-redshift/WEATHER_STATIONS.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."weather_stations";
SELECT COUNT (*) FROM "dev"."public"."weather_stations";

Copy weather from 's3://data228-redshift/WEATHER.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."weather";
SELECT COUNT (*) FROM "dev"."public"."weather";


Copy ca_county_yearly_insurance_stats from 's3://data228-redshift/CA_COUNTY_YEARLY_INSURANCE_STATS.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."ca_county_yearly_insurance_stats";
SELECT COUNT (*) FROM "dev"."public"."ca_county_yearly_insurance_stats";


Copy county_daily_flood_weather from 's3://data228-redshift/COUNTY_DAILY_FLOOD_WEATHER.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."county_daily_flood_weather";
SELECT COUNT (*) FROM "dev"."public"."county_daily_flood_weather";

Copy insurance from 's3://data228-redshift/INSURANCE.csv'
iam_role 'arn:aws:iam::482217000970:role/s3toredshift'
ignoreheader 1
delimiter ',';
SELECT * FROM "dev"."public"."insurance";
SELECT COUNT (*) FROM "dev"."public"."insurance";

-- SELECT * FROM information_schema.columns WHERE table_name = 'your_table_name';
-- SELECT table_name, column_name, data_type
-- FROM information_schema.columns
-- WHERE table_schema = 'public';