| column_name | description |
|-------------|-------------|
| incident_id | Key that identifies a unique record containing the details of a single incident (identified by date, time and location) |
| incident_date | The date that the incident occurred |
| incident_time | The time the incident occurred utulizing a 24-hour clock |
| day | The day of the week the incident occurred |
| incident_county_name | The name of the county in Pennsylvania where the incident occurred. If a County doesn't exist in the data set then nothing was reported for an Incident in that county. |
| incident_state | The state where the incident occurred |
| victim_id | Key that identifies a unique record for a victim. |
| gender_desc | Victim Gender. Possible values include: Male, Female, Unknown |
| age_range | Age range of the victim |
| race | Victim Race. Possible values: American Indian or Alaskan Native, Asian or Pacific Islander, Black, Unknown, White |
| ethnicity_desc | Victim ethnicity. Possible values: Hispanic, Mongolian, Not Hispanic, Unknown |
| victim_state | The state of the victim's home address if provided |
| victim_county | The county of the victim's home address if provided. If a County doesn't not exist in the data set then nothing was reported for a Victim or lives in that County. |
| accidental_exposure | Identifies an incident where a first responder was accidentally exposed to an opioid. Possible values: Y, N |
| victim_od_drug_id | Unique identifier for each suspected drug causing the overdose. Value will not appear on different incidents. Value is assigned by the system. |
| susp_od_drug_desc | Suspected drug causing the overdose. Possible values: OTHER, BATH SALTS, BENZODIAZEPINES (I.E.VALIUM, XANAX, ATIVAN, ETC), COCAINE/CRACK, FENTANYL, FENTANYL ANALOG/OTHER SYNTHETIC OPIOID, HEROIN, UNKNOWN, MARIJUANA, METHADONE, METHAMPHETAMINE, PHARMACEUTICAL OPIOID, PHARMACEUTICAL OTHER, SUBOXONE, SYNTHETIC MARIJUANA, ALCOHOL, PHARMACEUTICAL STIMULANT, CARFENTANIL, BARBITURATES (I.E. AMYTAL, NEMBUTAL, ETC) |
| naloxone_administered | Field identifying whether or not naloxone was administered. Possible values: Y, N |
| administration_id | Unique key identifying a single agency's administration of naloxone to an overdose victim. The ID will only repeat itself within an incident. Null will be present in the field if there was an overdose incident but naloxone was not administered. |
| dose_count | Number of doses of naloxone administered. Multiple doses can be administered to a single victim |
| dose_unit | Numeric field indicating the number of milligrams in the dose of naloxone administered. 0 Means Unknown. Null value means either no administration of naloxone or none reported. |
| dose_desc | Measurement unit (MG) or Unknown. |
| response_time_desc | Describes the amount of time it took for the victim to respond after receiving naloxone. Null value means either no administration of naloxone or none reported. Possible values: <1, 1-3, 3-5, >5, Don’t Know, Did not work |
| survive | Describes if the victim survived the incident. Possible values: Y, N, U. (U=Unknown is a value assigned by the person entering the data. In some cases the responder may not know if the victim survived.) |
| response_desc | Describes the victim's response to naloxone. Possible values: Combative, No Response to naloxone, Responsive and Alert, Responsive and Angry, Responsive but sedated |
| revive_action_desc | Describes the action taken if the victim received naloxone and survived. Possible values: Arrest, Hospital Conscious, Hospital Unconscious, Other, Released, Transported to treatment, Verbally referred to treatment |
| third_party_admin_desc | Description of who administered naloxone if the administration occurred by someone other than the responding agency entering the incident. Null value means Non Third Party Administration or no administration of naloxne. |
| incident_county_fips_code | The FIPS code of the county where the incident occurred. The FIPS county code is a five-digit Federal Information Processing Standard (FIPS) code (FIPS 6-4) which uniquely identifies counties and county equivalents in the United States, certain U.S. possessions, and certain freely associated states. This is the 3-digit part of the 5-digit county FIPS code specifically standing for the county. |
| incident_county_lat | Incident County Latitude |
| incident_county_long | Incident County Longitude |
| victim_county_fips_code | The FIPS code for the county of the victim. The FIPS county code is a five-digit Federal Information Processing Standard (FIPS) code (FIPS 6-4) which uniquely identifies counties and county equivalents in the United States, certain U.S. possessions, and certain freely associated states. This is the 3-digit part of the 5-digit county FIPS code specifically standing for the county. |
| victim_county_lat | Victim County Latitude |
| victim_county_long | Victim County Longitude |
| geocoded_column | Georeferenced column for use in creating mapping visualizations with both latitude and longitude of the Incident county |
| geocoded_column_1 | Georeferenced column for use in creating mapping visualizations with both latitude and longitude of the victim county |