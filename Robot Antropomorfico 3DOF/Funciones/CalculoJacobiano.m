clear all
clc

syms q1 q2 q3 l1 l2 l3 qn1 qn2 qn3 dx dy dz;

L1=Link([0 l1 0 pi/2 0]);
L2=Link([0 0 l2 0 0]);
L3=Link([0 0 l3 0 0]);
Rob=SerialLink([L1 L2 L3], 'name', 'RockBot');
q=[q1 q2 q3];
Jp=Rob.jacob0(q,'trans');
Jp_inv=inv(Jp);

qn=Jp^-1*[dx;dy;dz];

qn1=simplify(qn(1));
qn2=simplify(qn(2));
qn3=simplify(qn(3));








