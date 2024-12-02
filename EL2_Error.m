function [S_EL2,I_EL2,R_EL2] = EL2_Error(S_Interp,I_Interp,R_Interp,S_Model,I_Model,R_Model)
    
    function [EL2] = Error(Interpolated_Data,Modeled_Data)
        N = 50;     % Number of interpolated data points
        V_Interp = zeros(1,50);
        V_Model = zeros(1,50);
        Interpolated_Data(2:2:end) = V_Interp;
        Modeled_Data(2:2:end-1) = V_Model;
        Numerator = 0;

        for i = 1:N
            Numer = (V_Interp(i) - V_Model(i)).^2;
            Numerator = Numerator + Numer;
        end
        EL2 = sqrt(Numerator / N);
    end
    S_EL2 = Error(S_Interp,S_Model);
    I_EL2 = Error(I_Interp,I_Model);
    R_EL2 = Error(R_Interp,R_Model);
end