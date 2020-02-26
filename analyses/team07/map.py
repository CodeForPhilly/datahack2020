import streamlit as st
import pandas as pd

st.header('data hack 2020')


DATA_PREFIX = '../../data/' 
zipcode_to_latlong_path = 'zipcode-to-latlong.csv'

zipcode_to_latlong = pd.read_csv(zipcode_to_latlong_path)

physician_location = pd.read_csv(f'{DATA_PREFIX}hf_physician_locator.csv') 
physician_location = physician_location.assign(PostalCode = physician_location.PostalCode.apply(lambda x: int(x[:5])))
physician_location = physician_location.merge(
        zipcode_to_latlong, how='inner', left_on='PostalCode', right_on='ZIP'
        ).rename(columns={'LAT': 'lat', 'LNG': 'lon'})


st.dataframe(physician_location)

st.map(physician_location[['lat', 'lon']])

st.write(physician_location.dtypes, zoom=13)



