# Code for calculating powder mass flow within a given timeframe
# Created: 06-14-2024
# Modified: 05-23-2024


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import linregress


# Function for calculating mass time derivative
def getMassFlow(data, RPM, start_time, end_time):
    mdot = np.zeros(len(start_time))

    fig, axs = plt.subplots(2, 3, figsize=(15, 10))

    for i in range(len(start_time)):
        # Segment data into chunks for a single RPM
        start_RPM = np.argmin(np.abs(data['Time'] - start_time[i]))
        end_RPM = np.argmin(np.abs(data['Time'] - end_time[i]))

        time_RPM = data['Time'][start_RPM:end_RPM]
        mass_RPM = data['Mass'][start_RPM:end_RPM]

        # Fit linear model
        slope, intercept, _, _, _ = linregress(time_RPM, mass_RPM)
        mdot[i] = slope


        # Plot fitted line
        axs[i // 3, i % 3].plot(time_RPM, mass_RPM, label='Data')
        axs[i // 3, i % 3].plot(time_RPM, intercept + slope * time_RPM, 'r-', label='Fit')
        axs[i // 3, i % 3].set_title(f'Range {start_time[i]} to {end_time[i]}')
        axs[i // 3, i % 3].legend()

    mdot_per_min = mdot * 60
    mass_flow = pd.DataFrame(np.column_stack([RPM, mdot_per_min]), columns=['RPM', 'Mass Flow [g/min]'])

    # Plot RPM vs mdot
    plt.subplot(2, 3, 6)
    plt.plot(RPM, mdot * 60, 'o-')
    plt.xlabel('RPM')
    plt.ylabel('mdot (g/min)')
    plt.grid(True)

    plt.tight_layout()
    plt.show()

    return mass_flow


# Extract and clean time and mass columns from exported APW-Link data
def cleanData(df):
    clean_data = pd.DataFrame(columns=['Time', 'Mass'])

    # Extract relevant data from csv file
    # Drop first 14 rows and columns after second
    data = df.iloc[13: ,0:2]
    data = data.apply(pd.to_numeric, errors='coerce')

    # Extract columns
    data.columns = ['Time', 'Mass']
    data.dropna(inplace=True)

    # Find max difference and index of max difference (start)
    # Find max value and index of max value (end)
    start_index = np.argmax(np.diff(data['Mass']))
    #start_index = 100
    end_index = np.argmax(data['Mass'])

    clean_data['Time'] = data['Time'][start_index:end_index] - data['Time'][start_index]
    clean_data['Mass'] = data['Mass'][start_index:end_index] - data['Mass'][start_index]

    return clean_data


#def plotMassFlow()


#def getDelay()



#def getTimeConstant()

