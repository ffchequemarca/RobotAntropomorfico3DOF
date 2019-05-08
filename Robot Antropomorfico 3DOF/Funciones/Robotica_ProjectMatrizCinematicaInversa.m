function [ q1,q2,q3] = Robotica_ProjectMatrizCinematicaInversa(rx,ry,rz,codo)
%Robotica_ProjectMatrizCinematicaInversa
%[ q1,q2,q3] = Robotica_ProjectMatrizCinematicaInversa(rx,ry,rx,codo),
%Calcula la cinematica Inversa de un robot antropomorfico de 3 grados de
%libertad, intruduciendo las coordenadas y un 0 en codo para codo abajo y un 1 en codo para codo arriba.

l1=160;
l2=100;
l3=185;

q1=atan2d(ry,rx);
rx_aux=sqrt((rx^2)+(ry^2));
rz_aux=rz-l1;

M=((rx_aux^2)+(rz_aux^2)-(l2^2)-(l3^2))/(2*l2*l3);
a=sqrt(1-M^2);
if codo==1
   a=-a;
end
q3=atan2d(a,M);
q2=-atan2d(rx_aux,rz_aux)+atan2d((l2+l3*cosd(q3)),l3*sind(q3));

end

