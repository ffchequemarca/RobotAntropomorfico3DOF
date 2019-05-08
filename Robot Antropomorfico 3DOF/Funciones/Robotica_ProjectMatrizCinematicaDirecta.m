function [ H01, H02, H03 ] = Robotica_ProjectMatrizCinematicaDirecta(q1,q2,q3)
    
    l1=160;
    l2=100;
    l3=185;

    H01=[[ cosd(q1), 0,  sind(q1),  0];[ sind(q1), 0, -cosd(q1),  0];[       0, 1,        0, l1];[       0, 0,        0,  1]];

    H02=[[ cosd(q1)*cosd(q2), -cosd(q1)*sind(q2),  sind(q1), l2*cosd(q1)*cosd(q2)];[ cosd(q2)*sind(q1), -sind(q1)*sind(q2), -cosd(q1), l2*cosd(q2)*sind(q1)];[         sind(q2),          cosd(q2),        0,    l1 + l2*sind(q2)];[               0,                0,        0,                  1]];

    H03=[[ cosd(q1)*cosd(q2)*cosd(q3) - cosd(q1)*sind(q2)*sind(q3), - cosd(q1)*cosd(q2)*sind(q3) - cosd(q1)*cosd(q3)*sind(q2),  sind(q1), l2*cosd(q1)*cosd(q2) + l3*cosd(q1)*cosd(q2)*cosd(q3) - l3*cosd(q1)*sind(q2)*sind(q3)];[ cosd(q2)*cosd(q3)*sind(q1) - sind(q1)*sind(q2)*sind(q3), - cosd(q2)*sind(q1)*sind(q3) - cosd(q3)*sind(q1)*sind(q2), -cosd(q1), l2*cosd(q2)*sind(q1) + l3*cosd(q2)*cosd(q3)*sind(q1) - l3*sind(q1)*sind(q2)*sind(q3)];[                 cosd(q2)*sind(q3) + cosd(q3)*sind(q2),                   cosd(q2)*cosd(q3) - sind(q2)*sind(q3),        0,                    l1 + l2*sind(q2) + l3*cosd(q2)*sind(q3) + l3*cosd(q3)*sind(q2)];[                                                 0,                                                   0,        0,                                                                            1]];

end

