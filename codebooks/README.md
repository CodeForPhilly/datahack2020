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
| pp_sep_ | TODO Marieke fill in. [(info)](#syringe-exchanges-pp_sep).
| hf_physician_locator | Contact information of physicians in Philly, for clarifying who can prescribe Buprenorphine [(info)](#physicians-hf_physician) |
| residentzipcodecounts | overdose mortality by residential zip |
| incidentzipcodecounts | overdose mortality by incident zip |
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
| data | description |
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
| data_date_range | quarters of 2019 in which refills occurred |


### Syringe exchanges (pp_sep)
#### Data collected through the Prevention Point Syringe Exchange Program (SEP)
Prevention Point is the only syringe exchange program in Philadelphia, serving a wide range of participants through programming at their main headquarters (in Kensington), mobile units, and partner programs. As of 2020, Prevention Point is the only resource for individuals seeking clean syringes who may not be able to purchase them safely.

| site_id | site at which syringes were received/exchanged |
| 



## Health Federation

### Physicians (hf_physician)



## Department of Public Health Tableau

[Dashboards overview](https://public.tableau.com/profile/pdph#!/)

### Opioid summary dashboard (dph_main)

[Main dashboard page](https://public.tableau.com/profile/pdph#!/vizhome/SummaryPage_0/SummaryPage)


Contributing to this README
===========================


**Table names** should be formatted `{provider}_{domain}_{details}`. Eg. `pp_refill_events`.

**Table descriptions** should include one or two short sentences, and a link to the source data. If the source data is private, link to the section of this readme that provides additional information.
 
**Additional information** should be included in the Data Providers section, with two levels of headings:

* Section with their name. Eg. `## Prevention Point`
* Section for each domain. Eg. `### Refills (pp_refill)`

This information should be a short, high-level overview! You can include additional links to resources, for those who want to know more :).
