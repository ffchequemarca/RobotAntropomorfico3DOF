
clear all;
clc;
syms q1 q2 q3 l1 l2 l3
A01=Robotica_MatrizDenavitHartenberg(q1,l1,0,pi/2);
A12=Robotica_MatrizDenavitHartenberg(q2,0,l2,0);
A23=Robotica_MatrizDenavitHartenberg(q3,0,l3,0);
A03=A01*A12*A23;
save('Robotica_ProjectMatrizTransformacion.mat','A03');
disp(vpa(A03,4));
