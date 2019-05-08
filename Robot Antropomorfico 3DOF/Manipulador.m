function varargout = Manipulador(varargin)
% MANIPULADOR MATLAB code for Manipulador.fig
%      MANIPULADOR, by itself, creates a new MANIPULADOR or raises the existing
%      singleton*.
%
%      H = MANIPULADOR returns the handle to a new MANIPULADOR or the handle to
%      the existing singleton*.
%
%      MANIPULADOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANIPULADOR.M with the given input arguments.
%
%      MANIPULADOR('Property','Value',...) creates a new MANIPULADOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Manipulador_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Manipulador_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Manipulador

% Last Modified by GUIDE v2.5 23-Apr-2018 11:48:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Manipulador_OpeningFcn, ...
                   'gui_OutputFcn',  @Manipulador_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Manipulador is made visible.
function Manipulador_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Manipulador (see VARARGIN)
global  q1 q2 q3 q10 q20 q30 Velocidad Pinza Serial_flag
q1=0;
q2=40;
q3=0;
Pinza=0;
Serial_flag=0;
q10 = 0;
q20 = 0;
q30 = 0;
Velocidad=0.01;
Brazo= vrworld('roboticasolid.wrl','new');
open(Brazo);
handles.G1=vrnode(Brazo,'brazo_robotico');
handles.G2=vrnode(Brazo,'grado2');
handles.G3=vrnode(Brazo,'Grado3');

%Asignamos La Vista Superior
FigSuperior=vr.canvas(Brazo,handles.VistaSuperior_Out);
%set(FigSuperior,'Viewpoint','Atras');

%Asignamos La Vista Frontal
FigFrontal=vr.canvas(Brazo,handles.VistaFrontal_Out);
%set(FigFrontal,'Viewpoint','Frente');

CinematicaDirecta(hObject, eventdata, handles);
%handles.G3.rotation=[0 0 1 pi/2];
vrdrawnow;

% Choose default command line output for Manipulador
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Manipulador wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Manipulador_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function CinematicaDirecta(hObject, eventdata, handles)
global q1 q2 q3 H01 H02 H03
[H01,H02,H03] = Robotica_ProjectMatrizCinematicaDirecta(q1,q2,q3);
set(handles.H03_Out,'data',H03);
set(handles.X_Out,'String',H03(1,4));
set(handles.Y_Out,'String',H03(2,4));
set(handles.Z_Out,'String',H03(3,4));
set(handles.th1_Out, 'String',q1);
set(handles.th2_Out, 'String',q2);
set(handles.th3_Out, 'String',q3);

function Animation(hObject, eventdata, handles)
global q1 q2 q3 q10 q20 q30;

if q10 < q1
    for i=(q10)*pi/180:0.01:(q1)*pi/180
        handles.G1.rotation=[0 1 0 i];
        vrdrawnow;        
    end
else
    if q10 > q1
        for i=(q10)*pi/180:-0.01:(q1)*pi/180
            handles.G1.rotation=[0 1 0 i];
            vrdrawnow;
        end
    end
end
q10 = q1;

if q20 < q2
    for j=(q20)*pi/180:0.01:(q2)*pi/180
        handles.G2.rotation=[0 0 1 j];
        vrdrawnow;
    end
else
    if q20 > q2
        for j=(q20)*pi/180:-0.01:(q2)*pi/180
            handles.G2.rotation=[0 0 1 j];
            vrdrawnow;
        end
    end
end
q20 = q2;

if q30 < q3
    for k=(q30)*pi/180:0.01:(q3)*pi/180
        handles.G3.rotation=[0 0 1 k];
        vrdrawnow;
    end
else
    if q30 > q3
        for k=(q30)*pi/180:-0.01:(q3)*pi/180
            handles.G3.rotation=[0 0 1 k];
            vrdrawnow;
        end
    end
end
q30 = q3;



% --- Executes on slider movement.
function th1_In_Callback(hObject, eventdata, handles)
% hObject    handle to th1_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global q1 q2 q3 Serial Pinza Serial_flag
q1=get(handles.th1_In,'value');
CinematicaDirecta(hObject, eventdata, handles);
Animation(hObject, eventdata, handles);

if Serial_flag==1
   Robotica_ProjectDataSend(Serial,q1,q2,q3,Pinza)
end


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function th1_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th1_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function th2_In_Callback(hObject, eventdata, handles)
% hObject    handle to th2_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global q1 q2 q3 Serial Pinza Serial_flag
q2=get(handles.th2_In,'value');
CinematicaDirecta(hObject, eventdata, handles);
Animation(hObject, eventdata, handles);
if Serial_flag==1
    Robotica_ProjectDataSend(Serial,q1,q2,q3,Pinza)
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function th2_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th2_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function th3_In_Callback(hObject, eventdata, handles)
% hObject    handle to th3_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global q1 q2 q3 Serial Pinza Serial_flag
q3=get(handles.th3_In,'value');
CinematicaDirecta(hObject, eventdata, handles);
Animation(hObject, eventdata, handles);
if Serial_flag==1
    Robotica_ProjectDataSend(Serial,q1,q2,q3,Pinza)
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function th3_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th3_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function X_In_Callback(hObject, eventdata, handles)
% hObject    handle to X_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_In as text
%        str2double(get(hObject,'String')) returns contents of X_In as a double


% --- Executes during object creation, after setting all properties.
function X_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_In_Callback(hObject, eventdata, handles)
% hObject    handle to Y_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_In as text
%        str2double(get(hObject,'String')) returns contents of Y_In as a double


% --- Executes during object creation, after setting all properties.
function Y_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z_In_Callback(hObject, eventdata, handles)
% hObject    handle to Z_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z_In as text
%        str2double(get(hObject,'String')) returns contents of Z_In as a double


% --- Executes during object creation, after setting all properties.
function Z_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PCI_Btn.
function PCI_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to PCI_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global q1 q2 q3 Pinza Serial Serial_flag;

X=str2double(get(handles.X_In,'string'));
Y=str2double(get(handles.Y_In,'string'));
Z=str2double(get(handles.Z_In,'string'));

button_state = get(handles.SelectorCodo,'Value');
if button_state == get(hObject,'Max')
  [ q1,q2,q3] = Robotica_ProjectMatrizCinematicaInversa(X,Y,Z,0);
elseif button_state == get(hObject,'Min')
  [ q1,q2,q3] = Robotica_ProjectMatrizCinematicaInversa(X,Y,Z,1);
end

if Serial_flag==1
    Robotica_ProjectDataSend(Serial,q1,q2,q3,Pinza)
end

CinematicaDirecta(hObject, eventdata, handles);
Animation(hObject, eventdata, handles);



% --- Executes on button press in SelectorCodo.
function SelectorCodo_Callback(hObject, eventdata, handles)
% hObject    handle to SelectorCodo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of SelectorCodo
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
	set(handles.SelectorCodo, 'string', 'Abajo');    
elseif button_state == get(hObject,'Min')
	set(handles.SelectorCodo, 'string', 'Arriba');
end



function Puerto_In_Callback(hObject, eventdata, handles)
% hObject    handle to Puerto_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Puerto_In as text
%        str2double(get(hObject,'String')) returns contents of Puerto_In as a double


% --- Executes during object creation, after setting all properties.
function Puerto_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Puerto_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_Habilitar.
function Btn_Habilitar_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Habilitar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Serial Serial_flag q1 q2 q3 Pinza;


switch Serial_flag
    case 1
        fclose(Serial);
        Puerto=char(get(handles.Puerto_In,'string'));
        delete(instrfind({'Port'},{Puerto}));
        set(handles.Btn_Habilitar, 'string', 'Habilitar');
        Serial_flag=0;
               
    case 0
       Puerto=char(get(handles.Puerto_In,'string'));
       Serial=Robotica_ProjectSerialOpen(Puerto);       
       Robotica_ProjectDataSend(Serial,q1,q2,q3,Pinza);
       set(handles.Btn_Habilitar, 'string', 'Deshabilitar');
       Serial_flag=1;
end


% --- Executes on button press in Pinza_Btn.
function Pinza_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Pinza_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Pinza_Btn
global q1 q2 q3 Pinza Serial Serial_flag

button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
	set(handles.Pinza_Btn, 'string', 'Cerrar Pinza'); 
    Pinza=1;
elseif button_state == get(hObject,'Min')
	set(handles.Pinza_Btn, 'string', 'Abrir Pinza');
    Pinza=0;
end

if Serial_flag==1
    Robotica_ProjectDataSend(Serial,q1,q2,q3,Pinza)
end



function Xi_In_Callback(hObject, eventdata, handles)
% hObject    handle to Xi_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xi_In as text
%        str2double(get(hObject,'String')) returns contents of Xi_In as a double


% --- Executes during object creation, after setting all properties.
function Xi_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xi_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Yi_In_Callback(hObject, eventdata, handles)
% hObject    handle to Yi_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Yi_In as text
%        str2double(get(hObject,'String')) returns contents of Yi_In as a double


% --- Executes during object creation, after setting all properties.
function Yi_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yi_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Zi_In_Callback(hObject, eventdata, handles)
% hObject    handle to Zi_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Zi_In as text
%        str2double(get(hObject,'String')) returns contents of Zi_In as a double


% --- Executes during object creation, after setting all properties.
function Zi_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Zi_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Xo_In_Callback(hObject, eventdata, handles)
% hObject    handle to Xo_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Xo_In as text
%        str2double(get(hObject,'String')) returns contents of Xo_In as a double


% --- Executes during object creation, after setting all properties.
function Xo_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xo_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Yo_In_Callback(hObject, eventdata, handles)
% hObject    handle to Yo_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Yo_In as text
%        str2double(get(hObject,'String')) returns contents of Yo_In as a double


% --- Executes during object creation, after setting all properties.
function Yo_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Yo_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Zo_In_Callback(hObject, eventdata, handles)
% hObject    handle to Zo_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Zo_In as text
%        str2double(get(hObject,'String')) returns contents of Zo_In as a double


% --- Executes during object creation, after setting all properties.
function Zo_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Zo_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SelectorCodo2.
function SelectorCodo2_Callback(hObject, eventdata, handles)
% hObject    handle to SelectorCodo2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
	set(handles.SelectorCodo2, 'string', 'Abajo');    
elseif button_state == get(hObject,'Min')
	set(handles.SelectorCodo2, 'string', 'Arriba');
end
% Hint: get(hObject,'Value') returns toggle state of SelectorCodo2



function V_In_Callback(hObject, eventdata, handles)
% hObject    handle to V_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of V_In as text
%        str2double(get(hObject,'String')) returns contents of V_In as a double


% --- Executes during object creation, after setting all properties.
function V_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to V_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Puntos_In_Callback(hObject, eventdata, handles)
% hObject    handle to Puntos_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Puntos_In as text
%        str2double(get(hObject,'String')) returns contents of Puntos_In as a double


% --- Executes during object creation, after setting all properties.
function Puntos_In_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Puntos_In (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EjecutarTrayectoria.
function EjecutarTrayectoria_Callback(hObject, eventdata, handles)
% hObject    handle to EjecutarTrayectoria (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global q1 q2 q3 H03 Serial_flag Serial Pinza

Xi=str2double(get(handles.Xi_In,'string'));
Yi=str2double(get(handles.Yi_In,'string'));
Zi=str2double(get(handles.Zi_In,'string'));

Xo=str2double(get(handles.Xo_In,'string'));
Yo=str2double(get(handles.Yo_In,'string'));
Zo=str2double(get(handles.Zo_In,'string'));

V=str2double(get(handles.V_In,'string'));
Puntos=str2double(get(handles.Puntos_In,'string'));
X_aux=Xo-Xi;
Y_aux=Yo-Yi;
Z_aux=Zo-Zi;
Mag=sqrt(X_aux^2+Y_aux^2+Z_aux^2);
dx=X_aux/Puntos;
dy=Y_aux/Puntos;
dz=Z_aux/Puntos;
dt=V/1000;
button_state = get(handles.SelectorCodo2,'Value');
if button_state == get(hObject,'Max')
  [ q1, q2, q3 ] = Robotica_ProjectMatrizCinematicaInversa(Xi,Yi,Zi,0);
elseif button_state == get(hObject,'Min')
  [ q1, q2, q3 ] = Robotica_ProjectMatrizCinematicaInversa(Xi,Yi,Zi,1);
end

CinematicaDirecta(hObject, eventdata, handles);
Animation(hObject, eventdata, handles);

q1_aux=zeros(Puntos,1);
q2_aux=zeros(Puntos,1);
q3_aux=zeros(Puntos,1);
X1_aux=zeros(Puntos,1);
Y1_aux=zeros(Puntos,1);
Z1_aux=zeros(Puntos,1);

for i=1:Puntos    
    [q1,q2,q3] = Robotica_ProjectMatrizTrayectoria(q1,q2,q3,dx,dy,dz);
    CinematicaDirecta(hObject, eventdata, handles);
    Animation(hObject, eventdata, handles);
    q1_aux(i)=q1;
    q2_aux(i)=q2;
    q3_aux(i)=q3;
    X1_aux(i)=H03(1,4);
    Y1_aux(i)=H03(2,4);
    Z1_aux(i)=H03(3,4);   
    n=1:Puntos;  
    if Serial_flag==1
        Robotica_ProjectDataSend(Serial,q1,q2,q3,Pinza)
    end
    pause(dt);
end

axes(handles.q1Vsn_Out);
plot(n,q1_aux);
axes(handles.q2Vsn_Out);
plot(n,q2_aux);
axes(handles.q3Vsn_Out);
plot(n,q3_aux);
axes(handles.XYZ_Graph);
plot3(X1_aux,Z1_aux,Y1_aux);

guidata(hObject, handles);
