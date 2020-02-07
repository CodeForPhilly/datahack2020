Codebooks
=========

Acronyms:

* PP: Prevention Point
* SEP: Syringe Exchange Program
* HF: Health Federation
* DPH: Department of Public Health


| data | description |
| ---- | ----------- |
| pp_refill_events | Individual refills of Naloxone from PP. [(info)](#refills-pp_refill) |
| pp_refill_zipcode_metrics | pp_refill_events measures aggregated by participant zipcode. [(info)](#refills-pp_refill) |
| pp_sep_ | TODO Marieke fill in. [(info)](#syringe-exchanges-pp_sep).
| hf_physician_locator | Contact information of physicians in Philly, for clarifying who can prescribe Buprenorphine [(info)](#physicians-hf_physician) |
| residentzipcodecounts | overdose mortality by residential zip. [(info)](overdose-data-dph_od) |
| incidentzipcodecounts | overdose mortality by incident zip [(info)](overdose-data-dph_od) |
| n_EDtransfer_postNaloxone_byHospital | Number of ED Transfers After Naloxone Administrations by Hospital (2014-2019). [(source)](https://public.tableau.com/profile/pdph#!/vizhome/NaloxoneAdministrationsbyFirstResponders/NumberofNaloxoneAdministrationsbyLawEnforcementandFirstRespondersbyQuarter) |
| n_indiv_recNaloxone_LawEnfFirstResp | Number of Individuals Receiving a Naloxone Administration by Law Enforcement and First Responders by Quarter. [(source)](https://public.tableau.com/profile/pdph#!/vizhome/NaloxoneAdministrationsbyFirstResponders/NumberofNaloxoneAdministrationsbyLawEnforcementandFirstRespondersbyQuarter) |
| ems_NaloxoneByAge | EMS Naloxone Administrations by Age. [(source)](https://public.tableau.com/profile/pdph#!/vizhome/NaloxoneAdministrationsbyFirstResponders/EMSNaloxoneAdministrationsbyAge) |
| ems_NaloxoneBySex | EMS Naloxone Administrations by Sex. [(source)](https://public.tableau.com/profile/pdph#!/vizhome/NaloxoneAdministrationsbyFirstResponders/EMSNaloxoneAdministrationsbySex) |
| ems_NaloxoneByZip | Location of EMS Naloxone Administration. [(source)](https://public.tableau.com/profile/pdph#!/vizhome/NaloxoneAdministrationsbyFirstResponders/LocationofEMSNaloxoneAdministrations) |

Data Providers and Details
==========================

## Prevention Point

### Refills (pp_refill)

### Syringe exchanges (pp_sep)

TODO Marieke: a couple sentences. What is this data? Why is PP interested in it? From discussion it sounds like PP would benefit from estimating IV drug users--so we should answer, "how will this estimate allow PP to support their community?".

## Health Federation

### Physicians (hf_physician)



## Department of Public Health

### Overdose data (dph_od)

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
