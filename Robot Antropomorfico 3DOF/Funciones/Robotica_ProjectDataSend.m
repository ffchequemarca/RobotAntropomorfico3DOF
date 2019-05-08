function [ ] = Robotica_ProjectDataSend(Serial,Grado1,Grado2,Grado3,Pinza)
%Robotica_ProjectDataSend(Serial,Grado1,Grado2,Grado3,Pinza) Envio de datos con
%los angulos que debe tomar el manipulador en un momento dado.

Grado3=-Grado3;

%     g1=uint8((0.0012*Grado1*Grado1)+(1.0778*Grado1)+21); %= 0,0012x2 + 1,0778x + 21
%     g2=uint8((1.4167*Grado2)+0.1667); %1,4167x + 0,1667
%     g3=uint8((1.4167*Grado3)+127.67); %1,4167x + 127,67

    g1=uint8(Grado1);
    g2=uint8(Grado2);
    g3=uint8(Grado3+90);

    if Pinza==1
        g4=160;
    end

    if Pinza==0
        g4=90;
    end
    
    SendData=[g1,g2,g3,g4];
    disp(SendData);
    SendData=char(SendData);
    fprintf(Serial,SendData);
    

end

