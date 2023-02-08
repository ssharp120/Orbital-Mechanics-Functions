function C_ECI_LVLH = rotationMatrixLVLHtoECI(vr_ECI, vv_ECI)

    % Steven Sharp
    % AERO 560
    % Dr. Mehiel
    % 13 October 2022

    if (size(vr_ECI) ~= [3, 1] | size(vv_ECI) ~= [3, 1])
        error("Inputs must be column vectors of length 3!")
    end

    vz_LVLH = -vr_ECI / norm(vr_ECI);
    vy_LVLH = -cross(vr_ECI, vv_ECI)/norm(cross(vr_ECI, vv_ECI));
    vx_LVLH = cross(vy_LVLH, vz_LVLH);

    C_ECI_LVLH = [vx_LVLH, vy_LVLH, vz_LVLH];
end

