# Sicko_Code
MAE 384 Group Project

Available Function Files:

    Part 1: 
    - SIR Model

    Part 2:
    - Linear Interpolation
    - Quadratic Interpolation
    - EL2 Error

    Part 3:
    - Linear Least Squares

    Part 4:
    - Periodic SIR Model
    - Fast Fourier Transform

# FUNCTIONS

SIR_Model(Initial_Susceptible,Initial_Infected,Initial_Recovered,Sim_Time,Time_Step,Tran_Rate,Recov_Rate)
- Output [S,I,R]
    - S: Susceptible population, one dimensional matrix of dimensions (Sim_Time,1)
    - I: Infected population, one dimensional matrix of dimensions (Sim_Time,1)
    - R: Recovered population, one dimensional matrix of dimensions (Sim_Time,1)
- Arguments
    - Initial_Susceptible: Initial susceptible population, positive integer value
    - Initial_Infected: Initial infected population, positive integer value
    - Initial_Recovered: Initial recovered population, positive integer value
    - Sim_Time: Number of days to run simulation, positive non-zero integer value
    - Time_Step: Size of each time step in days, positive non-zero integer value
    - Tran_Rate: Rate of disease transmission, positive non-zero float value
    - Recov_Rate: Rate of recovery from disease, positive non-zero float value
- Notes
    - Tran_Rate may be changed to a vector quantity
    - Additional arugment may be added (use for calling a specific index of Tran_Rate vector)
    - When plotting, independent axis must contain the same number of elements as the function invocation 

LinearInterpolation(Susceptible,Infected,Recovered)
- Output [S_Interp,I_Interp,R_Interp]
    - S_Interp: Interpolated susceptible population data spliced with calculated data, array of dimensions 1x101
    - I_Interp: Interpolated infected population data spliced with calculated data, array of dimensions 1x101
    - R_Interp: Interpolated recovered population data spliced with calculated data, array of dimensions 1x101
- Arguments
    - Susceptible: Calculated susceptible population from SIR model w/ step size of 2 days, array of dimensions 51x1
    - Infected: Calculated infected population from SIR model w/ step size of 2 days, array of dimensions 51x1
    - Recovered: Calculated recovered population from SIR model w/ step size of 2 days, array of dimensions 51x1

Periodic_SIR_Model(Initial_Susceptible,Initial_Infected,Initial_Recovered,Sim_Time,Time_Step,Recov_Rate,Initial_Transmission_Rate,Amplitude,Angular_Frequency)
- Output [S,I,R,Time]
    - S:Susceptible population, one dimensional matrix of dimensions (Sim_Time,1)
    - I: Infected population, one dimensional matrix of dimensions (Sim_Time,1)
    - R: Recovered population, one dimensional matrix of dimensions (Sim_Time,1)
    - Time: Time vector used to plot the S,I,R outputs with, vector with length Sim_Time/ Time_Step
- Arguments
    - Initial_Susceptible: Initial susceptible population, positive integer value
    - Initial_Infected: Initial infected population, positive integer value
    - Initial_Recovered: Initial recovered population, positive integer value
    - Sim_Time: Number of days to run simulation, positive non-zero integer value
    - Time_Step: Size of each time step in days, positive non-zero integer value
    - Recov_Rate: Rate of recovery from disease, positive non-zero float value
    - Initial_Transmission_Rate: Initial Rate of disease transmission, positive non-zero float value
    - Amplitude: Amplitude of the transmission rate oscillation, non-zero float value
    - Angular_Frequency: periodicity of the transmission rate that corresponds to variations in the spread cycle, positive non-zero float value
- Notes
    - This function uses much of the same code as the periodic SIR model 
    - The primary changes include: Modifying the function to accept a vector input for the transmission rate, and the addition of a time vector to the output for use in plotting the outputs. 






 