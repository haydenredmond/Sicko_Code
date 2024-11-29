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
    - S: Susceptible popluation, one dimensional maxtix of dimensions (Sim_Time,1)
    - I: Infected population, one dimensional maxtix of dimensions (Sim_Time,1)
    - R: Recovered population, one dimensional maxtix of dimensions (Sim_Time,1)
- Arguments
    - Initial_Susceptible: Initial susceptible population, positive integer value
    - Initial_Infected: Initial infected popluation, positive integer value
    - Initial_Recovered: Initial recovered population, positive integer value
    - Sim_Time: Number of days to run simulation, positive non-zero integer value
    - Time_Step: Size of each time step, positive non-zero integer value
    - Tran_Rate: Rate of disease transmission, positive non-zero float value
    - Recov_Rate: Rate of recovery from disease, positive non-zero float value
- Notes
    - Tran_Rate may be changed to a vector quantity
    - Additional arugment may be added (use for calling a specific index of Tran_Rate vector)
    - When plotting, independent axis must contain the same number of elements as the function invocation 