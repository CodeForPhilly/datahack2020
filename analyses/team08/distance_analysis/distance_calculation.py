from math import radians, sin, asin, sqrt, atan2, cos
import numpy as np
import requests
import os
import pandas as pd


class OverdoseLocation:

    def __init__(self, name, lat, long):
        self.latitude = lat
        self.longitude = long
        self.name = name
        self.provider_distance = dict()
        self.provider_within_distance_count = 0
        self.provider_within_distance_names = ""

    def calculate_provider_within_range(self, distance):
        for key, value in self.provider_distance.items():
            if value <= float(distance):
                self.provider_within_distance_count += 1
                self.provider_within_distance_names += key
                self.provider_within_distance_names += ","


class ProviderLocation:
    def __init__(self, name, zip, lat, long):
        self.latitude = lat
        self.longitude = long
        self.name = name
        self.zip_code = zip


def calculate_google_distance(api_key, overdose_location: OverdoseLocation, provider_location: ProviderLocation):
    URL = "https://maps.googleapis.com/maps/api/distancematrix/json?parameters"
    origins = str(overdose_location.latitude) + "," + str(overdose_location.longitude)
    destinations = str(provider_location.latitude) + "," + str(provider_location.longitude)
    PARAMS = {'origins': origins, 'destinations': destinations, 'units': 'imperial', 'mode': 'walking', 'key': api_key}
    r = requests.get(url=URL, params=PARAMS)
    data = r.json()
    if data['rows'][0]['elements'][0].get('distance') is not None:
        text = data['rows'][0]['elements'][0]['distance']['text']
        print(text)
        # if distance is given in miles
        if 'm' in text:
            index = text.index('m') - 1
            return float(text[:index])
        # if distance is given in feet
        else:
            index = text.index('f') - 1
            return round(float(text[:index]) * 0.000189394, 1)
    # if distance is too far to be walkable
    else:
        return float(9999)


# this distance method is superior when calculating distances within main philly. Cannot be used outside of main philly because of how
# the streets are designed differently
def calculate_manhattan_distance_for_philly(overdose_location: OverdoseLocation, provider_location: ProviderLocation):
    # convert decimal degrees to radians
    lat1, lon1, lat2, lon2 = map(radians,
                                 [overdose_location.latitude, overdose_location.longitude, provider_location.latitude,
                                  provider_location.longitude])
    i_hat = [0.9876883405958299, -0.15643446503586003]
    j_hat = [0.15643446503586003, 0.9876883405958299]
    a = np.array([[i_hat[0], j_hat[0]], [i_hat[1], j_hat[1]]])
    b = np.array([lon2 - lon1, lat2 - lat1])
    x = (np.linalg.solve(a, b)).tolist()
    mid_point = [i_hat[0] * x[0] + lon1, i_hat[1] * x[0] + lat1]
    return abs(haversine(lon1, lat1, mid_point[0], mid_point[1])) + abs(
        haversine(mid_point[0], mid_point[1], lon2, lat2))


def haversine(lon1, lat1, lon2, lat2):
    dlon = lon2 - lon1
    dlat = lat2 - lat1
    a = sin(dlat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dlon / 2) ** 2
    c = 2 * asin(sqrt(a))
    r = 3956
    return c * r


if __name__ == "__main__":
    api_key = os.environ['API_KEY']
    path = os.getcwd()
    census_tracts = pd.read_csv(
        path + "\\data\\distance_data\\fatal-overdoses_philadelphia-census-tracts_2017-01_2019-06.csv", index_col=False)
    mat_location = pd.read_csv(path + "\\data\\distance_data\\geocoded_dbhids_mat-locations_tad-2020-02-28.csv",
                               index_col=False)
    mat_location = mat_location[mat_location['Buprenorphine?'] == "Yes"]
    census_tract_list = []
    mat_location_list = []
    for index, row in census_tracts.iterrows():
        print(row['TractNum'])
        census_tract_list.append(OverdoseLocation(row['TractNum'], row['INTPTLAT10'], row['INTPTLON10']))
    for index, row in mat_location.iterrows():
        print(row['ProgramName'])
        mat_location_list.append(ProviderLocation(row['ProgramName'], row['Zip'], row['latitude'], row['longitude']))
    for tract in census_tract_list:
        for mat in mat_location_list:
            print(tract.name, mat.name)
            tract.provider_distance[mat.name + "_" + str(mat.zip_code)] = calculate_google_distance(api_key, tract, mat)
        tract.calculate_provider_within_range(1.0)
        print(tract.provider_within_distance_count, tract.provider_within_distance_names)
    distance_matrix = pd.DataFrame()
    distance_matrix['mat_bupe_names'] = [(x.name + "_" + str(x.zip_code)) for x in mat_location_list]
    print(distance_matrix.tail())
    for tract in census_tract_list:
        print(list(tract.provider_distance.values()))
        distance_matrix[tract.name] = list(tract.provider_distance.values())
    census_tract_provider_count = [x.provider_within_distance_count for x in census_tract_list]
    census_tract_provider_names = [x.provider_within_distance_names for x in census_tract_list]
    census_tracts['nearby_bupe_program_count'] = census_tract_provider_count
    census_tracts['nearby_bupe_program_names'] = census_tract_provider_names
    census_tracts.to_csv(path + "\\data\\distance_data\\distance_analysis.csv", index=False)
    distance_matrix.to_csv(path + "\\data\\distance_data\\distance_matrix.csv", index=False)
