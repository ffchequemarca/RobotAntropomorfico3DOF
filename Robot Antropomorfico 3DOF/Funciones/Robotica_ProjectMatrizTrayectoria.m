function [qn1,qn2,qn3] = Robotica_ProjectMatrizTrayectoria(q1,q2,q3,dx,dy,dz)

    l1=160;
    l2=100;
    l3=185;
      
    q1=deg2rad(q1);
    q2=deg2rad(q2);
    q3=deg2rad(q3);
    
%     qn1 = (dy*cos(q1) - dx*sin(q1) + l2*q1*cos(q2) + l3*q1*cos(q2 + q3))/(l3*cos(q2 + q3) + l2*cos(q2));
%     qn2 = (l2*q2*sin(q3) + dz*cos(q2)*sin(q3) + dz*cos(q3)*sin(q2) + dx*cos(q1)*cos(q2)*cos(q3) + dy*cos(q2)*cos(q3)*sin(q1) - dx*cos(q1)*sin(q2)*sin(q3) - dy*sin(q1)*sin(q2)*sin(q3))/(l2*sin(q3));
%     qn3 = -(dz*l2*sin(q2) - l2*l3*q3*sin(q3) + dx*l2*cos(q1)*cos(q2) + dy*l2*cos(q2)*sin(q1) + dz*l3*cos(q2)*sin(q3) + dz*l3*cos(q3)*sin(q2) + dx*l3*cos(q1)*cos(q2)*cos(q3) + dy*l3*cos(q2)*cos(q3)*sin(q1) - dx*l3*cos(q1)*sin(q2)*sin(q3) - dy*l3*sin(q1)*sin(q2)*sin(q3))/(l2*l3*sin(q3));

    qn1=q1+((dy*cos(q1) - dx*sin(q1))/(l3*cos(q2 + q3) + l2*cos(q2)));
    qn2=q2 +((dz*cos(q2)*sin(q3) + dz*cos(q3)*sin(q2) + dx*cos(q1)*cos(q2)*cos(q3) + dy*cos(q2)*cos(q3)*sin(q1) - dx*cos(q1)*sin(q2)*sin(q3) - dy*sin(q1)*sin(q2)*sin(q3))/(l2*sin(q3)));
    qn3=q3 + (-(dz*l2*sin(q2) + dx*l2*cos(q1)*cos(q2) + dy*l2*cos(q2)*sin(q1) + dz*l3*cos(q2)*sin(q3) + dz*l3*cos(q3)*sin(q2) + dx*l3*cos(q1)*cos(q2)*cos(q3) + dy*l3*cos(q2)*cos(q3)*sin(q1) - dx*l3*cos(q1)*sin(q2)*sin(q3) - dy*l3*sin(q1)*sin(q2)*sin(q3))/(l2*l3*sin(q3)));
    
    qn1=rad2deg(qn1);
    qn2=rad2deg(qn2);
    qn3=rad2deg(qn3);
    
end