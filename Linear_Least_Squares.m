% % MATLAB Code for Part III: Least Squares
function [ln_I, Initial_Infected_est, Tran_Rate_est, k_est, t_data, X, theta] = Linear_Least_Squares(Initial_Susceptible,Initial_Infected,Initial_Recovered,Sim_Time,Time_Step,Tran_Rate,Recov_Rate)





%% Constants and Initial Conditions
N = 1000;                  % Total population
% Initial_Susceptible = 990;                  % Initial susceptible population
% Initial_Infected = 10;                   % Initial infected population
% Initial_Recovered = 0;                    % Initial recovered population
% Tran_Rate = 0.3;           % Transmission rate
% Recov_Rate = 0.1;               % Recovery rate
% Time_Step = 1;                     % Time step (days)
% Sim_Time = 30;                    % Total time (days)
t = 0:Time_Step:Sim_Time;                 % Time vector
num_steps = length(t);

%% Runge-Kutta 4th-order Method for SIR Model (Non-linear)
S = zeros(1, num_steps);   % Susceptible population
I = zeros(1, num_steps);   % Infected population
R = zeros(1, num_steps);   % Recovered population

% Initial conditions
S(1) = Initial_Susceptible;
I(1) = Initial_Infected;
R(1) = Initial_Recovered;

% RK4 Loop
for n = 1:num_steps-1
    % Calculate derivatives
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

    % Update values
    S(n+1) = S(n) + Time_Step * (dS1 + 2*dS2 + 2*dS3 + dS4) / 6;
    I(n+1) = I(n) + Time_Step * (dI1 + 2*dI2 + 2*dI3 + dI4) / 6;
    R(n+1) = R(n) + Time_Step * (dR1 + 2*dR2 + 2*dR3 + dR4) / 6;
end

%% Linear Least Squares
% Transform to log scale
ln_I = log(I(2:end)); % Exclude I(0) as log(0) is undefined
t_data = t(2:end);    % Corresponding time values

% Perform least squares fitting
X = [ones(length(t_data), 1), t_data']; % Design matrix [1, t]
theta = X \ ln_I';                     % Solve linear least squares
ln_Initial_Infected_est = theta(1);                  % Intercept: ln(I0)
k_est = theta(2);                      % Slope: k

% Back-calculate parameters
Initial_Infected_est = exp(ln_Initial_Infected_est);               % Estimated I(0)
Tran_Rate_est = (N * (k_est + Recov_Rate)) / Initial_Susceptible; % Estimated Tran_Rate

%% Results
% disp('Estimated Parameters:');
% fprintf('I(0) (Estimated): %.2f\n', Initial_Infected_est);
% fprintf('k (Estimated): %.4f\n', k_est);
% fprintf('Tran_Rate (Estimated): %.4f\n', Tran_Rate_est);

%% Plot Results
% figure;
% scatter(t_data, ln_I, 'co', 'DisplayName', 'True ln(I(t))');
% hold on;
% plot(t_data, X * theta, 'g-', 'LineWidth', 1.5, 'DisplayName', 'Fitted Line');
% xlabel('Time (days)');
% ylabel('ln(I(t))');
% title('Linear Least Squares Fit for ln(I(t))');
% legend;
% grid on;
end
