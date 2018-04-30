function varargout = GUI2(varargin)
% GUI2 MATLAB code for GUI2.fig
%      GUI2, by itself, creates a new GUI2 or raises the existing
%      singleton*.
%
%      H = GUI2 returns the handle to a new GUI2 or the handle to
%      the existing singleton*.
%
%      GUI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI2.M with the given input arguments.
%
%      GUI2('Property','Value',...) creates a new GUI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI2

% Last Modified by GUIDE v2.5 11-Mar-2017 11:22:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI2_OutputFcn, ...
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


% --- Executes just before GUI2 is made visible.
function GUI2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI2 (see VARARGIN)

% Choose default command line output for GUI2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUI2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function mouseMove (object, eventdata)
C = get (gca, 'CurrentPoint');
title(gca, ['\fontsize{16}[current position] = [', num2str(C(1,1)), ', ',num2str(C(1,2)), ']']);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
%Get Workspace
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla
global l1; global l2; global l3; global R1min_Original; global R2min_Original; global R3min_Original; global R1max_Original; global R2max_Original; global R3max_Original;

plot(0,0,'+k');

R1min=R1min_Original;
R2min=R2min_Original;
R3min=R3min_Original;
R1max=R1max_Original;
R2max=R2max_Original;
R3max=R3max_Original;

R1min_=R1min;
R2min_=R2min;
R3min_=R3min;
R1max_=R1max;
R2max_=R2max;
R3max_=R3max;
while ( R1min_ >= R1max_ )
    R1min_=R1min_-360; 
end

while ( R2min_ >= R2max_ )
    R2min_=R2min_-360; 
end

while ( R3min_ >= R3max_ )
    R3min_=R3min_-360; 
end
k=linspace(R3min_,R3max_);
hold on;
for i = R1min_:2.5:R1max_
    for j = R2min_:2.5:R2max_
            a = l1*cosd(i)+l2*cosd(i+j)+l3*cosd(i+j+k);
            b = l1*sind(i)+l2*sind(i+j)+l3*sind(i+j+k);
            plot(a,b,'.r');
    end
end
set(handles.pushbutton5, 'Enable', 'off');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
%Direct kinamatics
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global h;
global q11_; global q22_; global q33_;global q1_; global q2_; global q3_;

global l1; global l2; global l3; global R1min_Original; global R2min_Original; global R3min_Original; global R1max_Original; global R2max_Original; global R3max_Original;


R1min=R1min_Original;
R2min=R2min_Original;
R3min=R3min_Original;
R1max=R1max_Original;
R2max=R2max_Original;
R3max=R3max_Original;

q1 = str2double(get(handles.edit10, 'string'));
q2 = str2double(get(handles.edit11, 'string'));
q3 = str2double(get(handles.edit12, 'string'));

if(R1max ~= 360)
    R1max=mod((R1max+360),360);
end
if(R2max ~= 360)
    R2max=mod((R2max+360),360);
end
if(R3max ~= 360)
    R3max=mod((R3max+360),360);
end
R1min=mod((R1min+360),360);
R2min=mod((R2min+360),360);
R3min=mod((R3min+360),360);
q1=mod(q1+360,360);
q2=mod(q2+360,360);
q3= mod(q3+360,360);

if ( R1min > R1max )
    if(q1 <=360 && q1 >=R1min)
        q1 = q1-360;
    end
    R1min=R1min-360; 
end

if ( R2min > R2max )
    if(q2 <=360 && q2 >=R2min)
        q2 = q2-360;
    end
    R2min=R2min-360; 
end

if ( R3min > R3max )
    if(q3 <=360 && q3 >=R3min)
        q3 = q3-360;
    end
    R3min=R3min-360; 
end
if (((q1 <= R1max && q1 >= R1min) || R1min == R1max) && (( q2 <= R2max && q2 >= R2min) || R2min == R2max) && ((q3 <= R3max && q3 >= R3min) || R3min == R3max))
hold on;
x=[0 l1*cosd(q1) l1*cosd(q1)+l2*cosd(q1+q2) l1*cosd(q1)+l2*cosd(q1+q2)+l3*cosd(q1+q2+q3) ];
y=[0 l1*sind(q1) l1*sind(q1)+l2*sind(q1+q2) l1*sind(q1)+l2*sind(q1+q2)+l3*sind(q1+q2+q3) ];
delete(h);
h = plot(x,y,'k','LineWidth',3);
    set(handles.text1,'string','a');
    set(handles.text2,'string','b');
    set(handles.text3,'string','theta');
    set(handles.text4,'string',num2str (l1*cosd(q1)+l2*cosd(q1+q2)+l3*cosd(q1+q2+q3)));
    set(handles.text5,'string',num2str (l1*sind(q1)+l2*sind(q1+q2)+l3*sind(q1+q2+q3)));
    set(handles.text6,'string',num2str (mod((q1+q2+q3+360),360)));
else
    msgbox('No Solution');
end
    
% --- Executes on button press in pushbutton3.
function pushbutton4_Callback(hObject, eventdata, handles)
%Inverse Get Digram
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global h;
handles = guidata(hObject);

global l1; global l2; global l3; global R1min_Original; global R2min_Original; global R3min_Original; global R1max_Original; global R2max_Original; global R3max_Original;

global q11_; global q22_; global q33_;global q1_; global q2_; global q3_;

R1min=R1min_Original;
R2min=R2min_Original;
R3min=R3min_Original;
R1max=R1max_Original;
R2max=R2max_Original;
R3max=R3max_Original;



if(R1max ~= 360)
    R1max=mod((R1max+360),360);
end
if(R2max ~= 360)
    R2max=mod((R2max+360),360);
end
if(R3max ~= 360)
    R3max=mod((R3max+360),360);
end
R1min=mod((R1min+360),360);
R2min=mod((R2min+360),360);
R3min=mod((R3min+360),360);


a = str2double(get(handles.edit13, 'string'));
b = str2double(get(handles.edit14, 'string'));
theta = str2double(get(handles.edit15, 'string'));

a1 = a-l3*cosd(theta);
b1 = b-l3*sind(theta);

r = sqrt(a1*a1+b1*b1);
if ((l1*l1+r*r-l2*l2)/(2*l1*r)<=1 && (l1*l1+r*r-l2*l2)/(2*l1*r)>=-1)
alpha = acosd((l1*l1+r*r-l2*l2)/(2*l1*r));

if ( b1 > 0 && a1 < 0 )
    q1 = 180+atand(b1/a1)-alpha;
    q1_ = 180+atand(b1/a1)+alpha;
elseif ( b1 <= 0 && a1 < 0 )
    q1 = 180+ atand(b1/a1)-alpha;
    q1_ = 180 + atand(b1/a1)+alpha;
elseif (b1 < 0 && a1 >0 )
    q1 = atand(b1/a1)-alpha;
    q1_ = atand(b1/a1)+alpha;
else
    q1 = atand(b1/a1)-alpha;
    q1_ = atand(b1/a1)+alpha;
end

if ( (r*sind(alpha) > 0) && (r*cosd(alpha)-l1 < 0) )
    q2 = 180+atand((r*sind(alpha))/(r*cosd(alpha)-l1));
    q2_ = 180+atand((r*sind(-alpha))/(r*cosd(-alpha)-l1));
elseif ( (r*sind(alpha) <= 0) && (r*cosd(alpha)-l1 < 0) )
        q2 = 180+atand((r*sind(alpha))/(r*cosd(alpha)-l1));
        q2_ = 180+atand((r*sind(-alpha))/(r*cosd(-alpha)-l1));
    elseif ( r*sind(alpha) < 0 && (r*cosd(alpha)-l1 >0 ))
            q2 = atand((r*sind(alpha))/(r*cosd(alpha)-l1));
            q2_ = atand((r*sind(-alpha))/(r*cosd(-alpha)-l1));
        else
        q2 =  (atand((r*sind(alpha))/(r*cosd(alpha)-l1)));
        q2_ =  atand((r*sind(-alpha))/(r*cosd(-alpha)-l1));
end

q3 = theta-q1-q2;
q3_ = theta-q1_-q2_;
 
q11=q1; 
q11_ = q1_;
q22 = q2;
q22_ = q2_;
q33 = q3;
q33_ = q3_;


q1=mod(q1+360,360);
q2=mod(q2+360,360);
q3= mod(q3+360,360);
q1_=mod(q1_+360,360);
q2_=mod(q2_+360,360);
q3_= mod(q3_+360,360);


if ( R1min > R1max )
    if(q1 <=360 && q1 >=R1min)
        q1 = q1-360;
    end
    if(q1_ <=360 && q1_ >=R1min)
        q1_ = q1_-360;
    end
    R1min=R1min-360; 
end

if ( R2min > R2max )
    if(q2 <=360 && q2 >=R2min)
        q2 = q2-360;
    end
    if(q2_ <=360 && q2_ >=R2min)
        q2_ = q2_-360;
    end
    R2min=R2min-360; 
end

if ( R3min > R3max )
    if(q3 <=360 && q3 >=R3min)
        q3 = q3-360;
    end
    if(q3_ <=360 && q3_ >=R3min)
        q3_ = q3_-360;
    end
    R3min=R3min-360; 
end

hold on;
if (((q1 <= R1max && q1 >= R1min) || R1min == R1max) && (( q2 <= R2max && q2 >= R2min) || R2min == R2max) && ((q3 <= R3max && q3 >= R3min) || R3min == R3max))
    x = [0 l1*cosd(q1) l1*cosd(q1)+l2*cosd(q1+q2) l1*cosd(q1)+l2*cosd(q1+q2)+l3*cosd(q1+q2+q3)];
    y = [0 l1*sind(q1) l1*sind(q1)+l2*sind(q1+q2) l1*sind(q1)+l2*sind(q1+q2)+l3*sind(q1+q2+q3)];
    delete(h);
    h = plot(x,y,'k','LineWidth',3);
    set(handles.text1,'string','q1');
    set(handles.text2,'string','q2');
    set(handles.text3,'string','q3');
    set(handles.text4,'string',num2str (q11));
    set(handles.text5,'string',num2str (q22));
    set(handles.text6,'string',num2str (q33));
    if (((q1_ <= R1max && q1_ >= R1min)|| R1min == R1max) && ((q2_ <= R2max &&q2_ >= R2min)|| R2min == R2max) && ((q3_ <= R3max && q3_ >= R3min)|| R3min == R3max) && ( q1 ~= q1_ && q2~=q2_ && q3~=q3_))
        set(handles.pushbutton5, 'Enable', 'on');
    else
         set(handles.pushbutton5, 'Enable', 'off');
    end
elseif (((q1_ <= R1max && q1_ >= R1min)|| R1min == R1max) && ((q2_ <= R2max &&q2_ >= R2min)|| R2min == R2max) && ((q3_ <= R3max && q3_ >= R3min)|| R3min == R3max))
    x = [0 l1*cosd(q1_) l1*cosd(q1_)+l2*cosd(q1_+q2_) l1*cosd(q1_)+l2*cosd(q1_+q2_)+l3*cosd(q1_+q2_+q3_)];
    y = [0 l1*sind(q1_) l1*sind(q1_)+l2*sind(q1_+q2_) l1*sind(q1_)+l2*sind(q1_+q2_)+l3*sind(q1_+q2_+q3_)];
    delete(h);
    h = plot(x,y,'k','LineWidth',3);
    set(handles.text1,'string','q1');
    set(handles.text2,'string','q2');
    set(handles.text3,'string','q3');
    set(handles.text4,'string',num2str (q11_));
    set(handles.text5,'string',num2str (q22_));
    set(handles.text6,'string',num2str (q33_));
    set(handles.pushbutton5, 'Enable', 'off');
else
    msgbox('out of range');
end
else
    msgbox('No Solution !');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton5_Callback(hObject, eventdata, handles)
%Invrse Get another Digram
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global h;

handles = guidata(hObject);

global l1; global l2; global l3;

global q11_; global q22_; global q33_;global q1_; global q2_; global q3_;

set(handles.text1,'string','q1');
set(handles.text2,'string','q2');
set(handles.text3,'string','q3');
set(handles.text4,'string',num2str (q11_));
set(handles.text5,'string',num2str (q22_));
set(handles.text6,'string',num2str (q33_));

hold on;

    x = [0 l1*cosd(q1_) l1*cosd(q1_)+l2*cosd(q1_+q2_) l1*cosd(q1_)+l2*cosd(q1_+q2_)+l3*cosd(q1_+q2_+q3_)];
    y = [0 l1*sind(q1_) l1*sind(q1_)+l2*sind(q1_+q2_) l1*sind(q1_)+l2*sind(q1_+q2_)+l3*sind(q1_+q2_+q3_)];
    delete(h);
    h = plot(x,y,'k','LineWidth',3);


function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton6_Callback(hObject, eventdata, handles)
%Maximum Load
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles=guidata(hObject);

global l1; global l2; global l3; global R1min_Original; global R2min_Original; global R3min_Original; global R1max_Original; global R2max_Original; global R3max_Original;

R1min=R1min_Original;
R2min=R2min_Original;
R3min=R3min_Original;
R1max=R1max_Original;
R2max=R2max_Original;
R3max=R3max_Original;

Fx = str2double(get(handles.edit16, 'string'));
Fy = str2double(get(handles.edit17, 'string'));
M = str2double(get(handles.edit18, 'string'));

P=[Fx ; Fy ; M];

Q1=[];
Q2=[];
Q3=[];

R1min_=R1min;
R2min_=R2min;
R3min_=R3min;
R1max_=R1max;
R2max_=R2max;
R3max_=R3max;
while ( R1min_ >= R1max_ )
    R1min_=R1min_-360; 
end

while ( R2min_ >= R2max_ )
    R2min_=R2min_-360; 
end

while ( R3min_ >= R3max_ )
    R3min_=R3min_-360; 
end

A = linspace(R1min_, R1max_,100);
B = linspace(R2min_, R2max_,100);
C = linspace(R3min_,R3max_,100);


Q1max = -1000000000;
Q2max = -1000000000;
Q3max = -1000000000;

for i=1:100
    for j=1:100
        for k=1:100
            ptr1_q1=-l1*sind(A(1,i))-l2*sind(A(1,i)+B(1,j))-l3*sind(A(1,i)+B(1,j)+C(1,k));
            ptr2_q1=l1*cosd(A(1,i))+l2*cosd(A(1,i)+B(1,j))+l3*cosd(A(1,i)+B(1,j)+C(1,k));
            ptr1_q2=-l2*sind(A(1,i)+B(1,j))-l3*sind(A(1,i)+B(1,j)+C(1,k));
            ptr2_q2=l2*cosd(A(1,i)+B(1,j))+l3*cosd(A(1,i)+B(1,j)+C(1,k));
            ptr1_q3=-l3*sind(A(1,i)+B(1,j)+C(1,k));
            ptr2_q3=l3*cosd(A(1,i)+B(1,j)+C(1,k));
            JT=[ ptr1_q1 ptr2_q1 1 ; ptr1_q2 ptr2_q2 1; ptr1_q3 ptr2_q3 1];
            Q=-(JT*P);
            if(Q(1,1) > Q1max)
                Q1max=Q(1,1);
            end
            if (Q(2,1) > Q2max)
                Q2max=Q(2,1);
            end
            if (Q(3,1) > Q3max)
                Q3max=Q(3,1);
            end
                
        end
    end
end

% 
% for i = R1min_:2.5:R1max_
%     for j = R2min_:2.5:R2max_
%             k=linspace(R3min_,R3max_);
% for i = R1min_:4:R1max_
%     for j = R2min_:2.5:R2max_
%         for k = R3min_:1:R3max_
%             ptr1_q1=-l1*sind(i)-l2*sind(i+j)-l3*sind(i+j+k);
%             ptr2_q1=l1*cosd(i)+l2*cosd(i+j)+l3*cosd(i+j+k);
%             ptr1_q2=-l2*sind(i+j)-l3*sind(i+j+k);
%             ptr2_q2=l2*cosd(i+j)+l3*cosd(i+j+k);
%             ptr1_q3=-l3*sind(i+j+k);
%             ptr2_q3=l3*cosd(i+j+k);
%             JT=[ ptr1_q1 ptr2_q1 1 ; ptr1_q2 ptr2_q2 1; ptr1_q3 ptr2_q3 1];
%             Q=-(JT*P);
%             Q1=[Q1 Q(1,1)];
%             Q2=[Q2 Q(2,1)];
%             Q3=[Q3 Q(3,1)];
%         end
%     end
% end


set(handles.text1,'string','q1max');
set(handles.text2,'string','q2max');
set(handles.text3,'string','q3max');
set(handles.text4,'string',num2str (Q1max));
set(handles.text5,'string',num2str (Q2max));
set(handles.text6,'string',num2str (Q3max));


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close;
untitled1('untitled1', handles.figure1);


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set (gcf, 'WindowButtonMotionFcn', @mouseMove);
