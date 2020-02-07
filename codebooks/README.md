Codebooks
=========

Acronyms:

* PP: Prevention Point
* SEP: Syringe Exchange Program
* HF: Health Federation
* DPH: Department of Public Health


| data | description |
| ---- | ----------- |
| pp_refill_events | Information collected at time of naloxone refills of Naloxone at PP. [(info)](#refills-pp_refill) |
| pp_refill_zipcode_metrics | pp_refill_events measures aggregated by participant zipcode. [(info)](#refills-pp_refill) |
| pp_sep_site_exchanges | Counts of needles exchanged/received at PP sites [(info)](#syringe-exchanges-pp_sep).
| pp_sep_site_participants | Counts of participants that have exchanged syringes at PP sites [(info)](#syringe-exchanges-pp_sep).
| hf_physician_locator | Contact information of physicians in Philly, for clarifying who can prescribe Buprenorphine [(info)](#physicians-hf_physician) |
| residentzipcodecounts | overdose mortality by residential zip. [(info)](#overdose-data-dph_od) |
| incidentzipcodecounts | overdose mortality by incident zip [(info)](#overdose-data-dph_od) |
| n_EDtransfer_postNaloxone_byHospital | Number of ED Transfers After Naloxone Administrations by Hospital (2014-2019). [(source)](https://public.tableau.com/profile/pdph#!/vizhome/NaloxoneAdministrationsbyFirstResponders/NumberofNaloxoneAdministrationsbyLawEnforcementandFirstRespondersbyQuarter) |
| n_indiv_recNaloxone_LawEnfFirstResp | Number of Individuals Receiving a Naloxone Administration by Law Enforcement and First Responders by Quarter. [(source)](https://public.tableau.com/profile/pdph#!/vizhome/NaloxoneAdministrationsbyFirstResponders/NumberofNaloxoneAdministrationsbyLawEnforcementandFirstRespondersbyQuarter) |
| ems_NaloxoneByAge | EMS Naloxone Administrations by Age. [(source)](https://public.tableau.com/profile/pdph#!/vizhome/NaloxoneAdministrationsbyFirstResponders/EMSNaloxoneAdministrationsbyAge) |
| ems_NaloxoneBySex | EMS Naloxone Administrations by Sex. [(source)](https://public.tableau.com/profile/pdph#!/vizhome/NaloxoneAdministrationsbyFirstResponders/EMSNaloxoneAdministrationsbySex) |
| ems_NaloxoneByZip | Location of EMS Naloxone Administration. [(source)](https://public.tableau.com/profile/pdph#!/vizhome/NaloxoneAdministrationsbyFirstResponders/LocationofEMSNaloxoneAdministrations) |

Data Providers and Details
==========================

## Prevention Point

### Refills (pp_refill)

#### Naloxone refill_events
In many states, individuals must receive a prescription to carry overdose reversal drugs like Narcan (Naloxone). In 2014, Pennsylvania passed legislation allowing any citizen who could be in the position to administer overdose reversal drugs to receive, carry, and administer such drugs. Prevention Point, among other locations, trains and hands out refills for Narcan (Naloxone).  Narcan is an overdose reversal drug administered either intravenously or intranalasally. 

Individuals receiving training or refills through Prevention Point are required to fill out a questionnaire about their experiences with overdoses and related demographic information. 

<!-- | data | description |
| age | participant age at time of refill |
| gender | participant identified gender | 
| race | particpant race | 
| n_pp_refill | number of naloxone refills received at PP | 
| n_o_refill | number of refills from other locations | 
| n_ods | number of overdoses witnessed by participant |
| n_admins | number of individuals given narcan by participant |
| n_revivals | number of individuals revived by narcan adminstered by participant | 
| used_narcan_type | form of narcan used by participant | 
| ml_naloxone | amount of naloxone used by participant | 
| cpr_used | rescue breathing was employed at time of narcan use | 
| outcome | events following narcan administration | 
| outcome_ems | was EMS called at time of narcan use | 
| outcome_police | were police called at time of narcan use | 
| outcome_ed | was individual taken to emergency room |
| outcome_death | did individual die after narcan use |
| outcome_unk | outcome of narcan use unknown |
| outcome_ok | individual was revived and well after narcan administration |
| od_drug | drug used at time of overdose | 
| od_drug_heroin | was heroin in individual's system at time of narcan administration |
| od_drug_cocaine | was cocaine in individual's system at time of narcan administration |
| od_drug_fentanyl | was fentanyl in individual's system at time of narcan administration |
| od_drug_unknown | was drug in individual's system at time of narcan administration unknown |
| od_drug_other | were drugs not listed above in individual's system at time of narcan administration |
| od_present | method of identifying overdose in individual |
| od_present_breath | OD identified by irregular or lack of breath |
| od_present_unresponsive | OD identified: individual was unresponsive or unconcious |
| od_present_coloring | OD identified by skin color (blue or purple) |
| od_present_other | OD identified through other means |
| data_date_range | quarters of 2019 in which refills occurred | -->


### Syringe exchanges (pp_sep)
#### Data collected through the Prevention Point Syringe Exchange Program (SEP)
Prevention Point is the only syringe exchange program in Philadelphia, serving a wide range of participants through programming at their main headquarters (in Kensington), mobile units, and partner programs. As of 2020, Prevention Point is the only resource for individuals seeking clean syringes who may not be able to purchase them safely.

We (the organizers) have the event data at a lower grain but due to HIPAA concerns and the concerns of SEP participants, we are only releasing aggregated forms of this data.  If there is a different aggregation you think would be useful, feel free to submit an issue (as early as possible).

<!-- sep_participants_month_site
|data | description | 
| site_id | site at which syringes were received/exchanged |
| visit_month | month in which syringes were received/exchanged |
| count_distinct_participants | number of distinct participants at that site during that month | 

sep_ -->

## Health Federation

### Physicians (hf_physician)
Since October 2002 when the Food and Drug Administration (FDA) approved buprenorphine for clinical use in treating opioid dependency, SAMHSA has worked with practitioners to help them obtain waivers to meet the requirements of the Drug Addiction Treatment Act of 2000 (DATA 2000). DATA 2000 sets eligibility and certification requirements as well as an interagency notification review process for practitioners who apply.

Physicians with active Bupernorphine waivers are listed on the [SAMHSA](https://www.samhsa.gov/medication-assisted-treatment/practitioner-program-data/treatment-practitioner-locator) website. We manually searched for these physicians using the [Bupernorphine Pharmacy Lookup](https://www.samhsa.gov/bupe/lookup-form) form. Physicians can only have 30, 100, or 275 active patients receiving Bupernorphine at any given time. Because the form uses only the last name of the physician and pulls from a national database, it oftentimes returned a different practitioner.  These values were coded to `30`.

## Department of Public Health

### Overdose Mortality Rates (dph_od)

These datasets were received as two separate excel files, by submitting a [Health Data Request Form](https://www.phila.gov/services/mental-physical-health/medical-professionals/request-health-data/). Requests are reviewed by the Philadelphia Department of Health.  Any clarifications on the request needed are then obtained and data is then generated and delivered to the recipient. Anyone can request health data from the PDPH, including members of the public.

This dataset includes quarterly overdose mortality rates by resident zip code ()

### Tableau dashboards (dph_dash)

[Dashboards overview](https://public.tableau.com/profile/pdph#!/)

[Main dashboard page](https://public.tableau.com/profile/pdph#!/vizhome/SummaryPage_0/SummaryPage)


Contributing to this README
===========================


**Table names** should be formatted `{provider}_{domain}_{details}`. Eg. `pp_refill_events`.

**Table descriptions** should include one or two short sentences, and a link to the source data. If the source data is private, link to the section of this readme that provides additional information.
 
**Additional information** should be included in the Data Providers section, with two levels of headings:

* Section with their name. Eg. `## Prevention Point`
* Section for each domain. Eg. `### Refills (pp_refill)`

This information should be a short, high-level overview! You can include additional links to resources, for those who want to know more :).
