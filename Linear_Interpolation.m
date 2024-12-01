function [S_Interp,I_Interp,R_Interp] = LinearNewton(Susceptible,Infected,Recovered)

    function [Interpolated_Data] = Interpolate(Pop_Type)
        Rough_Time = 0:2:100;       % Time steps using steps of 2 days
        Precise_Time = 0:1:100;     % Time steps using steps of 1 day
        Interpolated_Data = zeros(1,length(Precise_Time));        % Preallocating 
        Interpolated_Points = zeros(1,length(Rough_Time)-1);      % Preallocating
        Interpolated_Data(1) = Pop_Type(1);
                
        for i = 2:length(Pop_Type) - 1        
            Interpolated_Points(i-1) = Pop_Type(i-1) + ((Pop_Type(i)-Pop_Type(i-1))/(Rough_Time(i)-Rough_Time(i-1))) * (Precise_Time(i-1)-Rough_Time(i-1)); 
        end            
        Interpolated_Data(1:2:end) = Pop_Type;
        Interpolated_Data(2:2:end-1) = Interpolated_Points;    
    end
    S_Interp = Interpolate(Susceptible);
    I_Interp = Interpolate(Infected);
    R_Interp = Interpolate(Recovered);
end