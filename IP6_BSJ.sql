USE crime_data;

#1
SELECT COUNT(DISTINCT(crime_type)) AS unique_crimes
FROM incident_reports;

#2
SELECT crime_type, COUNT(crime_type) AS num_crimes
FROM incident_reports
GROUP BY crime_type
ORDER BY crime_type;

#3
SELECT COUNT(date_reported)
FROM incident_reports
WHERE date_reported LIKE date_occured;

#4
SELECT date_reported, date_occured, crime_type, TIMESTAMPDIFF(year, date_occured, date_reported) AS report_diff
FROM incident_reports
WHERE TIMESTAMPDIFF(year, date_occured, date_reported) NOT LIKE 0
ORDER BY TIMESTAMPDIFF(year, date_occured, date_reported) DESC;

#5
SELECT YEAR(date_occured) AS year, COUNT(date_occured) AS num_incidents
FROM incident_reports
WHERE YEAR(date_occured)-2012>=0
GROUP BY YEAR(date_occured)
ORDER BY YEAR(date_occured) DESC;

#6
SELECT *
FROM incident_reports
WHERE crime_type LIKE 'robbery';

#7
SELECT lmpd_division, incident_number, date_occured
FROM incident_reports
WHERE crime_type LIKE 'robbery'
AND att_comp LIKE 'attempted';

#8
SELECT date_occured, crime_type
FROM incident_reports
WHERE zip_code LIKE 40202
ORDER BY crime_type,date_occured;

#9
SELECT zip_code, COUNT(zip_code) AS num_thefts
FROM incident_reports
WHERE crime_type LIKE 'motor vehicle theft'
GROUP BY zip_code
ORDER BY COUNT(zip_code) DESC;
#There were 41 zip codes with vehicle thefts, with 40214 having the most at 4566 thefts.

#10
SELECT COUNT(DISTINCT(city))
FROM incident_reports;

#11
SELECT city, COUNT(city) AS num_incidents
FROM incident_reports
GROUP BY city
ORDER BY COUNT(city) DESC;
#Assuming LVIL is also Louisville, Lyndon has the second highest number of incidents at 4898. There is also a surprising amount of rows where the city column is left blank.alter

#12
SELECT uor_desc, crime_type
FROM incident_reports
WHERE crime_type NOT LIKE 'other'
GROUP BY uor_desc, crime_type
ORDER BY uor_desc, crime_type;
#The uor_desc column seems to either denote the severity ofthe crime or the offense count, indicating different charges for different crime_types

#13
SELECT COUNT(DISTINCT(lmpd_beat))
FROM incident_reports;

#14
SELECT COUNT(DISTINCT(offense_code))
FROM nibrs_codes;

#15
SELECT COUNT(DISTINCT(nibrs_code))
FROM incident_reports;

#16
SELECT date_occured, block_address, zip_code, offense_description
FROM incident_reports, nibrs_codes
WHERE incident_reports.nibrs_code=nibrs_codes.offense_code
AND nibrs_code IN (240,250,270,280)
ORDER BY block_address;

#17
SELECT zip_code, offense_against
FROM incident_reports, nibrs_codes
WHERE incident_reports.nibrs_code = nibrs_codes.offense_code
AND nibrs_code NOT LIKE 999
AND LENGTH(zip_code)>=5
ORDER BY zip_code;

#18
SELECT offense_against,COUNT(offense_against)
FROM incident_reports, nibrs_codes
WHERE incident_reports.nibrs_code = nibrs_codes.offense_code
AND offense_against NOT LIKE ''
GROUP BY offense_against
ORDER BY offense_against;

#19
SELECT city, COUNT(att_comp)
FROM incident_reports
WHERE att_comp LIKE 'attempted'
GROUP BY city
HAVING COUNT(att_comp)>40
ORDER BY COUNT(att_comp) DESC;

#20
SELECT city, offense_against
FROM incident_reports, nibrs_codes
WHERE incident_reports.nibrs_code = nibrs_codes.offense_code
AND att_comp LIKE 'attempted'
AND city NOT LIKE ''
AND offense_against NOT LIKE ''
ORDER BY city, offense_against;