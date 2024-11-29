


function [S,I,R] = Periodic_SIR_Model(Initial_Susceptible,Initial_Infected,Initial_Recovered,Sim_Time,Time_Step,Recov_Rate,Initial_Transmission_Rate,Amplitude,Angular_Frequency)



Time = 0:Time_Step:Sim_Time;
Tran_Rate = Initial_Transmission_Rate.*(1 + Amplitude .* Angular_Frequency .* Time);

[S,I,R] = SIR_Model( Initial_Susceptible,Initial_Infected,Initial_Recovered,Sim_Time,Time_Step,Tran_Rate,Recov_Rate);

end