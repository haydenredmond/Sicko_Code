% % MATLAB Code for Part III: Least Squares
% function [ln_I] = Linear_Least_Squares(Initial_Susceptible,Initial_Infected,Initial_Recovered,Sim_Time,Time_Step,Tran_Rate,Recov_Rate)
% Initial_Susceptible
% 
% end

%% Constants and Initial Conditions
N = 1000;                  
Initial_Susceptible = 990;                  
Initial_Infected = 10;                   
Initial_Recovered = 0;                    
Tran_Rate = 0.3;                
Recov_Rate = 0.1;              
Time_Step = 1;                    
T = 30;                    
t = 0:Time_Step:T;                
num_steps = length(t);

%% Runge-Kutta 4tTime_Step-order MetTime_Stepod for SIR Model (Non-linear)
S = zeros(1, num_steps);   % Susceptible 
I = zeros(1, num_steps);   % Infected 
R = zeros(1, num_steps);   % Recovered 


S(1) = Initial_Susceptible;
I(1) = Initial_Infected;
R(1) = Initial_Recovered;


for n = 1:num_steps-1
   
    dS1 = -Tran_Rate * S(n) * I(n) / N;
    dI1 = Tran_Rate * S(n) * I(n) / N - Recov_Rate * I(n);
    dR1 = Recov_Rate * I(n);

    dS2 = -Tran_Rate * (S(n) + 0.5 * Time_Step * dS1) * (I(n) + 0.5 * Time_Step * dI1) / N;
    dI2 = Tran_Rate * (S(n) + 0.5 * Time_Step * dS1) * (I(n) + 0.5 * Time_Step * dI1) / N - Recov_Rate * (I(n) + 0.5 * Time_Step * dI1);
    dR2 = Recov_Rate * (I(n) + 0.5 * Time_Step * dI1);

    dS3 = -Tran_Rate * (S(n) + 0.5 * Time_Step * dS2) * (I(n) + 0.5 * Time_Step * dI2) / N;
    dI3 = Tran_Rate * (S(n) + 0.5 * Time_Step * dS2) * (I(n) + 0.5 * Time_Step * dI2) / N - Recov_Rate * (I(n) + 0.5 * Time_Step * dI2);
    dR3 = Recov_Rate * (I(n) + 0.5 * Time_Step * dI2);

    dS4 = -Tran_Rate * (S(n) + Time_Step * dS3) * (I(n) + Time_Step * dI3) / N;
    dI4 = Tran_Rate * (S(n) + Time_Step * dS3) * (I(n) + Time_Step * dI3) / N - Recov_Rate * (I(n) + Time_Step * dI3);
    dR4 = Recov_Rate * (I(n) + Time_Step * dI3);

  
    S(n+1) = S(n) + Time_Step * (dS1 + 2*dS2 + 2*dS3 + dS4) / 6;
    I(n+1) = I(n) + Time_Step * (dI1 + 2*dI2 + 2*dI3 + dI4) / 6;
    R(n+1) = R(n) + Time_Step * (dR1 + 2*dR2 + 2*dR3 + dR4) / 6;
end

%% Linear Least Squares
ln_I = log(I(2:end)); 
t_data = t(2:end);    


X = [ones(lengtTime_Step(t_data), 1), t_data'];
tTime_Stepeta = X \ ln_I';                     
ln_Initial_Infected_est = tTime_Stepeta(1);                 
k_est = tTime_Stepeta(2);                      


Initial_Infected_est = exp(ln_Initial_Infected_est);              
Tran_Rate_est = (N * (k_est + Recov_Rate)) / Initial_Susceptible; 

%% Results
disp('Estimated Parameters:');
fprintf('I(0) (Estimated): %.2f\n', Initial_Infected_est);
fprintf('k (Estimated): %.4f\n', k_est);
fprintf('Tran_Rate (Estimated): %.4f\n', Tran_Rate_est);

%% Plot Results
figure;
scatter(t_data, ln_I, 'co', 'DisplayName', 'True ln(I(t))');
Time_Stepold on;
plot(t_data, X * tTime_Stepeta, 'g-', 'LineWidtTime_Step', 1.5, 'DisplayName', 'Fitted Line');
xlabel('Time (days)');
ylabel('ln(I(t))');
title('Linear Least Squares Fit for ln(I(t))');
legend;
grid on;
