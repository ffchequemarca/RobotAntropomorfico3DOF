function [Aij]=Robotica_MatrizDenavitHartenberg(theta,d,a,alpha)
alpha=rad2deg(alpha);
Aij=eye(4);
Aij=sym(Aij);
Aij(1,1)=cos(theta);
Aij(1,2)=-cosd(alpha)*sin(theta);
Aij(1,3)=sind(alpha)*sin(theta);
Aij(1,4)=a*cos(theta);

Aij(2,1)=sin(theta);
Aij(2,2)=cosd(alpha)*cos(theta);
Aij(2,3)=-sind(alpha)*cos(theta);
Aij(2,4)=a*sin(theta);

Aij(3,2)=sind(alpha);
Aij(3,3)=cosd(alpha);
Aij(3,4)=d;
end