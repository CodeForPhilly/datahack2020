Codebooks
=========

Acronyms:

* PP: Prevention Point
* SEP: Syringe Exchange Program
* HF: Health Federation
* DPH: Department of Public Health


| data | description |
| ---- | ----------- |
| pp_refill_events | Individual refills of Naloxone from PP |
| pp_refill_zipcode_metrics | pp_refill_events measures aggregated by participant zipcode |
| hf_physician_locator | Contact information of physicians in Philly, for clarifying who can prescribe Buprenorphine |
| residentzipcodecounts | overdose mortality by residential zip |
| incidentzipcodecounts | overdose mortality by incident zip |
| n_EDtransfer_postNaloxone_byHospital | Number of ED Transfers After Naloxone Administrations by Hospital (2014-2019) |
| n_indiv_recNaloxone_LawEnfFirstResp | Number of Individuals Receiving a Naloxone Administration by Law Enforcement and First Responders by Quarter |
| ems_NaloxoneByAge | EMS Naloxone Administrations by Age |
| ems_NaloxoneBySex | EMS Naloxone Administrations by Sex |
| ems_NaloxoneByZip | Location of EMS Naloxone Administration |

Data Providers and Details
==========================

## Prevention Point (PP)

### Refills (pp_refill)

### Syringe exchanges (pp_sep)

## Health Federation (HF)

## Department of Public Health (DPH) Tableau Data

https://public.tableau.com/profile/pdph#!/

### Summary dashboard


Contributing to this README
===========================


**Table names** should be formatted `{provider}_{domain}_{details}`.

* eg. `pp_refill_events` is Prevention Point refills, at the individual refill event level.
* eg. `hf_physician_locator` is Health Federation physician data.
 
**Additional information** should be included in the Data Providers section, with two levels of headings:

* Section with their name. Eg. `## Prevention Point`
* Section for each domain. Eg. `### Refills (pp_refill)`

This information should be a short, high-level overview! You can include additional links to resources, for those who want to know more :).
