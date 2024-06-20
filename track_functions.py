# Code for calculating powder mass flow within a given timeframe
# Created: 06-14-2024
# Modified: 05-23-2024


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import linregress
from scipy.stats import ttest_ind
import scipy.signal 


# Function for calculating mass time derivative
def getSteadyMassFlow(data, RPM, start_time, end_time):
    mdot = np.zeros(len(start_time))

    fig, axs = plt.subplots(2, 3, figsize=(15, 10))

    for i in range(len(start_time)):
        # Segment data into chunks for a single RPM
        start_deposition = np.argmin(np.abs(data['Time'] - start_time[i]))
        end_deposition = np.argmin(np.abs(data['Time'] - end_time[i]))


        time_RPM = data['Time'][start_deposition:end_deposition]
        mass_RPM = data['Height'][start_deposition:end_deposition]

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
    plt.ylabel('mdot [g/min]')
    plt.grid(True)

    plt.tight_layout()
    plt.show()

    return mass_flow


# Extract and clean time and mass columns from exported APW-Link data
def cleanData(df, overestimate_delay):
    clean_data = pd.DataFrame(columns=['Time', 'Height'])
    clean_with_delay = pd.DataFrame(columns=['Time', 'Height'])

    # Extract relevant data from csv file
    # Drop first 14 rows and columns after second
    #data = df.iloc[2: ,0]
    #data = data.apply(pd.to_numeric, errors='coerce')

    # Extract columns
    data = df*1000
    data.columns = ['Time', 'Height']
    data.dropna(inplace=True)

    data['Height'][data['Height'] < -0.05] = -0.05

    # Find index of max difference (start)
    # Find index of max value (end)
    start_index = np.argmax(np.diff(data['Height'].iloc[:overestimate_delay]))
    #end_index = np.argmax(data['Height'])

    delay = data['Time'].iloc[start_index]

    print("Track begins at row index " + str(start_index))
    print("The delay is " + str(delay) + " mm")
    print()


    clean_data['Time'] = (data['Time'][start_index:] - data['Time'][start_index])
    clean_data['Height'] = data['Height'][start_index:] - data['Height'][start_index]

    clean_with_delay['Time'] = data['Time'][0:] - data['Time'].iloc[0]
    clean_with_delay['Height'] = data['Height'][0:] - data['Height'].iloc[0]

    return clean_data, clean_with_delay, delay


def gradient(clean_with_delay, dwell):
    gradient_data = pd.DataFrame(columns=['Time', 'Mdot','Input'])

    gradient_data['Time'] = clean_with_delay['Time']

    mdot = np.gradient(clean_with_delay['Height'], clean_with_delay['Time'])
    mdot_median_filt = scipy.signal.medfilt(mdot, kernel_size=51)
    mdot_df = pd.DataFrame(mdot_median_filt)
    #gradient_data['Mdot'] = np.ma.average(mdot_median_filt, axis=None, weights=None, returned=False)
    gradient_data['Mdot'] = mdot_df.rolling(100).mean()
    #gradient_data.dropna(inplace=True)


    gradient_data['Input'] = np.where(gradient_data['Time'].gt(dwell), 1, 0)

    return gradient_data


#def plotMassFlow()


#def getDelay()



#def getTimeConstant()

