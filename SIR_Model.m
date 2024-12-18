function [S,I,R] = SIR_Model(Initial_Susceptible,Initial_Infected,Initial_Recovered,Sim_Time,Time_Step,Tran_Rate,Recov_Rate)

    Initial_Counts = [Initial_Susceptible,Initial_Infected,Initial_Recovered];
    Time = 0:Time_Step:Sim_Time;
    N = sum(Initial_Counts);

    Solution = zeros(length(Time),3);
    Solution(1,:) = Initial_Counts;
    
    SIR_System = @(Time,Solution_Array) [
        -(Tran_Rate / N) * Solution_Array(1) * Solution_Array(2);
        (Tran_Rate / N) * Solution_Array(1) * Solution_Array(2) - Recov_Rate * Solution_Array(2);
        Recov_Rate * Solution_Array(2);
    ];

    for i = 1:(length(Time) - 1)
        Solution_Transposed = Solution(i,:)';

        k1 = SIR_System(Time(i),Solution_Transposed) * Time_Step;
        k2 = SIR_System(Time(i) + (Time_Step / 2), Solution_Transposed + (k1 / 2)) * Time_Step;
        k3 = SIR_System(Time(i) + (Time_Step / 2), Solution_Transposed + (k2 / 2)) * Time_Step;
        k4 = SIR_System(Time(i) + Time_Step, Solution_Transposed + k3) * Time_Step;
        
        Solution(i+1,:) = (Solution_Transposed + (k1 + 2*k2 + 2*k3 + k4) / 6)';
    end
    S = Solution(:,1);
    I = Solution(:,2);
    R = Solution(:,3);
end