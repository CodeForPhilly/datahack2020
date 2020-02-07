Prevention Point refill events codebook
=======================================

**HELP WANTED:** this document contains rough descriptions for each column of data.
A description using a tool like [codebook](https://rubenarslan.github.io/codebook/) would be nice to have!

## Data overview

### Acronyms

* SEP - Syringe exchange program
* PP - Prevention Point

### Variables: Individual

These variables are for **participants**, people who are obtaining a refill:

* age
* gender
* race
* participant_zip
* pp_id

These variables describe participants at the time of a refill event:

* n_pp_refill - "How many times have you received Naloxone at PP?"
* n_o_refill - "How many times have you received Naloxone from a pharmacy?"
* n_ods - "How many overdoses have you seen?"
* n_admins - TODO: I don't see a question of many times someone has administered in questionairre
* n_revivals - "How many people did you successfully revive with Naloxone?"


These variables are for **users**, people who received naloxone:

* use_zip


### Variables: Refill event

Administration prior to refill:

* used_narcan_type - "What form of naloxone did you use?"
* ml_naloxone - milliliters naloxone administered
* cpr_used - 
* use_person - maybe response to "on whom did you administer naloxone?" 
* self_type - "what category best describes you?" Used to code...
  - self_user, self_inrecovery, self_parent, etc..
* outcome - free text used to code outcome_{specific}
  - outcome_ems, outcome_police, outcome_death, etc..
* od_drug - free text used to code od_drug_{specific}
  - od_dug_heroin, od_drug_cocain, etc..
* od_present - free text used to code od_present_{specific}
  - od_present_breath, od_present_unresponsive, etc..

Refill event:

* refill_date
* refill_reason

### Columns missing from data sources

The data was provided in separate files for each quarter.

* The quarter 3 and 4 data is missing the open text fields self_type, outcome, od_drug, od_present. Note that we DO have the columns they are used to code, eg od_drug_heroin, od_drug_cocain, etc.. 
* I've added a `data_date_range` column to indicate whether it was taken from the spreadsheet corresponding to quarters 1 and 2 (2018-q1-q2) or 3 and 4 (2018-q3-q4).
