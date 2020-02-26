import streamlit as st
from functools import reduce 
product = lambda xs: reduce(lambda x,y: x*y, xs)

rate_of_new_prescription = st.slider('rate of new prescription', 0., 1., value=0.7, step=0.01)

rate_of_addiction_per_prescription = st.slider('rate of addiction per prescription', 0., 1., step=0.01)

rate_of_overdose_per_addiction = st.slider('rate of overdose per addiction', 0., 1., step=0.01)

rate_of_death_per_overdose = st.slider('rate of death per overdose', 0., 1., step=0.1)

economic_cost_per_death = st.slider('economic cost per death (in billions)', -1000., 0., step=1., value=-0.85 * 504)

economic_cost_of_new_prescription_per_person_in_billions = product(
        (
            rate_of_new_prescription, 
            rate_of_addiction_per_prescription,
            rate_of_overdose_per_addiction,
            rate_of_death_per_overdose,
            economic_cost_per_death
        )
    )

st.write(f'ECONOMIC COST (in billions) per american: {economic_cost_of_new_prescription_per_person_in_billions}')
