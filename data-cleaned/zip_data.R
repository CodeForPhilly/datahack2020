#Zip code analyses

library(tidyverse)

#Load data with zip codes
pp_refill_zipcode_metrics <- read_csv("pp_refill_zipcode_metrics.csv")
dph_dash_ems_naloxone_zip <- read_csv("dph_dash_ems_naloxone_zip.csv")
dph_od_incident_counts <- read_csv("dph_od_incident_counts.csv")
dph_od_resident_counts <- read_csv("dph_od_resident_counts.csv")
hf_physician_locator <- read_csv("hf_physician_locator.csv")
hf_samsha_programs <- read_csv("hf_samsha_programs.csv")
hf_samsha_providers <- read_csv("hf_samsha_providers.csv")

#Clean and rename
hf_physician_locator$PostalCode <- str_replace_all(hf_physician_locator$PostalCode, c("19104-4594" = "19104", "19107-0000" = "19107", "19107-4405" = "19107", "19115-2805" = "19115","19102-1121" = "19102", "19104-6178" = "19104", "191401" = "19140"))   
hf_physicians <- as.data.frame(table(hf_physician_locator$PostalCode))
hf_physicians <- rename(hf_physicians, ZipCode = Var1, hf_physicians_number = Freq)
hf_physicians$ZipCode <- as.character(hf_physicians$ZipCode)

hf_samsha_programs$Zipcode <- str_replace_all(hf_samsha_programs$Zipcode, c("19047-1806" = "19047", "18344-1033" = "18344", "19107-4220" = "19107", "18951-2634" = "18951", "19550-5000" = "19550", "191401" = "19140"))
hf_programs <- as.data.frame(table(hf_samsha_programs$Zipcode))
hf_programs <- rename(hf_programs, ZipCode = Var1, hf_programs_number = Freq)
hf_programs$ZipCode <- as.character(hf_programs$ZipCode)

hf_samsha_providers$Postal.Code <- str_replace_all(hf_samsha_providers$Postal.Code, c("19104-4594" = "19104", "19107-4405" = "19107", "19115-2805" = "19115", "19107-0000" = "19107", "19102-1121" = "19102", "19104-6178" = "19104", "191401" = "19140"))
hf_providers <- as.data.frame(table(hf_samsha_providers$Postal.Code))
hf_providers <- rename(hf_providers, ZipCode = Var1, hf_providers_number = Freq)
hf_providers$ZipCode <- as.character(hf_providers$ZipCode)

hf_samsha_providers <- hf_samsha_providers %>% mutate(Bup.More.Than.30 = Bup.Rx > 30)
hf_Bup <- as.data.frame(table(hf_samsha_providers$Postal.Code, hf_samsha_providers$Bup.More.Than.30))
hf_Bup <- hf_Bup %>% filter(Var2 == "TRUE") %>% rename(ZipCode = Var1, Bup.More.Than.30 = Freq) %>% select(ZipCode, Bup.More.Than.30)
hf_Bup$ZipCode <- as.character(hf_Bup$ZipCode)

colnames(dph_od_incident_counts) <- gsub("X", "Incident", colnames(dph_od_incident_counts))
dph_od_incident_counts <- rename(dph_od_incident_counts, ZipCode = ZIPCODE)
dph_od_incident_counts$ZipCode <- as.character(dph_od_incident_counts$ZipCode)

#Replacing "<6" with "1" -- may want to try a different strategy
dph_incident <- dph_od_incident_counts
for (i in 1:ncol(dph_incident)) {
  dph_incident[[i]] <- as.integer(gsub("<6", "1", dph_incident[[i]]))
}
colnames(dph_incident) <- paste(colnames(dph_incident), "integer", sep = ".")
dph_incident <- rename(dph_incident, ZipCode = ZipCode.integer)
dph_incident$ZipCode <- as.character(dph_incident$ZipCode)

colnames(dph_od_resident_counts) <- gsub("X", "Resident", colnames(dph_od_resident_counts))
dph_od_resident_counts <- rename(dph_od_resident_counts, ZipCode = Zip.Code)
dph_od_resident_counts$ZipCode <- as.character(dph_od_resident_counts$ZipCode)

#Replacing "<6" with "1" -- may want to try a different strategy
dph_resident <- dph_od_resident_counts
for (i in 1:ncol(dph_resident)) {
  dph_resident[[i]] <- as.integer(gsub("<6", "1", dph_resident[[i]]))
}
colnames(dph_resident) <- paste(colnames(dph_resident), "integer", sep = ".")
dph_resident <- rename(dph_resident, ZipCode = ZipCode.integer)
dph_resident$ZipCode <- as.character(dph_resident$ZipCode)

dph_dash_ems_naloxone_zip <- rename(dph_dash_ems_naloxone_zip, ZipCode = Pickup.Zip.Code, Naloxone.Pickups = Numebr.of.Records)
dph_dash_ems_naloxone_zip$ZipCode <- as.character(dph_dash_ems_naloxone_zip$ZipCode)

pp_refill_zipcode_metrics <- rename(pp_refill_zipcode_metrics, ZipCode = participant_zip)
pp_refill_zipcode_metrics$ZipCode <- as.character(pp_refill_zipcode_metrics$ZipCode)

#Merge by zip code
zip_data <- pp_refill_zipcode_metrics %>% full_join(dph_dash_ems_naloxone_zip) %>% full_join(dph_od_incident_counts) %>% full_join(dph_od_resident_counts) %>% full_join(hf_physicians) %>% full_join(hf_programs) %>% full_join(hf_providers) %>% full_join(hf_Bup) %>% full_join(dph_incident) %>% full_join(dph_resident)
zip_data <- subset(zip_data, is.na(zip_data$ZipCode) == F)

#Total overdose deaths 2016-2018 (residents)
zip_data$overdose_deaths <- vector("integer", nrow(zip_data))
for (i in 1:nrow(zip_data)) {
  zip_data$overdose_deaths[i] <- sum(zip_data[i,84:103])
}

#Total overdose deaths 2016-2018 (incidents)
zip_data$overdose_deaths2 <- vector("integer", nrow(zip_data))
for (i in 1:nrow(zip_data)) {
  zip_data$overdose_deaths2[i] <- sum(zip_data[i,64:83])
}

