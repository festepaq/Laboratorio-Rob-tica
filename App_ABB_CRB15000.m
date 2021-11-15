classdef App_ABB_CRB15000 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        ABB_CRB_15000             matlab.ui.Figure
        ParacomenzarutilizacualquiersliderparaconfigurarunanguloLabel  matlab.ui.control.Label
        mmLabel_3                 matlab.ui.control.Label
        mmLabel_2                 matlab.ui.control.Label
        mmLabel                   matlab.ui.control.Label
        posZ                      matlab.ui.control.NumericEditField
        ZEditFieldLabel           matlab.ui.control.Label
        posY                      matlab.ui.control.NumericEditField
        YEditFieldLabel           matlab.ui.control.Label
        posX                      matlab.ui.control.NumericEditField
        XEditFieldLabel           matlab.ui.control.Label
        PosicinEfectorFinalLabel  matlab.ui.control.Label
        info_q6                   matlab.ui.control.NumericEditField
        q1Label_6                 matlab.ui.control.Label
        info_q5                   matlab.ui.control.NumericEditField
        q1Label_5                 matlab.ui.control.Label
        info_q4                   matlab.ui.control.NumericEditField
        q1Label_4                 matlab.ui.control.Label
        info_q3                   matlab.ui.control.NumericEditField
        q1Label_3                 matlab.ui.control.Label
        info_q2                   matlab.ui.control.NumericEditField
        q1Label_2                 matlab.ui.control.Label
        info_q1                   matlab.ui.control.NumericEditField
        q1Label                   matlab.ui.control.Label
        q6                        matlab.ui.control.Slider
        q2                        matlab.ui.control.Slider
        q5                        matlab.ui.control.Slider
        q4                        matlab.ui.control.Slider
        q3                        matlab.ui.control.Slider
        q1                        matlab.ui.control.Slider
        grafica                   matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Value changing function: q1
        function q1ValueChanging(app, event)
            close all; clc;
            plot(app.grafica,0,0);
            axis(app.grafica,'on');
            grid(app.grafica,'on')
            hold(app.grafica,'on');
            title(app.grafica,'Robot ABB CRB-15000');

            q_1 = event.Value*pi/180;
            q_2 = app.q3.Value*pi/180;
            q_3 = app.q2.Value*pi/180;
            q_4 = app.q4.Value*pi/180;
            q_5 = app.q5.Value*pi/180;
            q_6 = app.q6.Value*pi/180;
            Q = [q_1 q_2 q_3 q_4 q_5 q_6];

           L1=0.265; L2=0.444; L3=0.110; L4=0.470; L5=0.080; L6=0.037;

           L(1) = Link('revolute','alpha',0,'a', 0,'d',L1,'offset',0,'modified','qlim',[-pi pi]);
           L(2) = Link('revolute','alpha',-pi/2,'a', 0,'d',0,'offset',-pi/2,'modified','qlim',[-pi pi]);
           L(3) = Link('revolute','alpha',0,'a', L2,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(4) = Link('revolute','alpha',-pi/2,'a', L3,'d',L4,'offset',0,'modified', 'qlim',[-pi pi]);
           L(5) = Link('revolute','alpha',pi/2,'a', 0,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(6) = Link('revolute','alpha',-pi/2,'a', L5,'d',L6,'offset', 0,'modified','qlim',[-pi pi]);

           pos_x = [0];
           pos_y = [0];
           pos_z = [0];

           MTH_BC = L(1).A(Q(1));
           [R,translation] = tr2rt(MTH_BC);
           pos_x(1) = [translation(1)];
           pos_y(1) = [translation(2)];
           pos_z(1) = [translation(3)];

           for i=2:6
               MTH_BC = MTH_BC*L(i).A(Q(i));
               [R,translation] = tr2rt(MTH_BC);
               pos_x(i+1) = [translation(1)];
               pos_y(i+1) = [translation(2)];
               pos_z(i+1) = [translation(3)];
               plot3(app.grafica,pos_x(i+1),pos_y(i+1),pos_z(i+1),'-o' , 'Color' , 'b' , 'MarkerSize' , 10,'MarkerFaceColor','b')
           end

           plot3(app.grafica,pos_x,pos_y,pos_z,'LineWidth',5,'Color',[.6 0 0]);

           tool = MTH_BC*[0.15 0 0 1]';
           pos_tool_x = [pos_x(7) tool(1)];
           pos_tool_y = [pos_y(7) tool(2)];
           pos_tool_z = [pos_z(7) tool(3)];
           plot3(app.grafica,pos_tool_x,pos_tool_y,pos_tool_z,'LineWidth',2,'Color','r');

           tool = MTH_BC*[0 0 0.2 1]';
           pos_tool_x = [pos_x(7) tool(1)];
           pos_tool_y = [pos_y(7) tool(2)];
           pos_tool_z = [pos_z(7) tool(3)];
           plot3(app.grafica,pos_tool_x,pos_tool_y,pos_tool_z,'LineWidth',2,'Color','c');

           view(app.grafica,140,30);
           axis(app.grafica,[-1 1 -1 1 -0.67 1.3]);
           hold(app.grafica,'off');

           app.info_q1.Value = round(q_1*180/pi,2);
           app.info_q2.Value = round(q_2*180/pi,2);
           app.info_q3.Value = round(q_3*180/pi,2);
           app.info_q4.Value = round(q_4*180/pi,2);
           app.info_q5.Value = round(q_5*180/pi,2);
           app.info_q6.Value = round(q_6*180/pi,2);

           app.posX.Value = round(translation(1)*1000,2);
           app.posY.Value = round(translation(2)*1000,2);
           app.posZ.Value = round(translation(3)*1000,2);
         
        end

        % Value changing function: q3
        function q3ValueChanging(app, event)
            close all; clc;
            plot(app.grafica,0,0);
            axis(app.grafica,'on');
            grid(app.grafica,'on')
            hold(app.grafica,'on');
            title(app.grafica,'Robot ABB CRB-15000');

            q_1 = app.q1.Value*pi/180;
            q_2 = app.q2.Value*pi/180;
            q_3 = event.Value*pi/180;
            q_4 = app.q4.Value*pi/180;
            q_5 = app.q5.Value*pi/180;
            q_6 = app.q6.Value*pi/180;
            Q = [q_1 q_2 q_3 q_4 q_5 q_6];

           L1=0.265; L2=0.444; L3=0.110; L4=0.470; L5=0.080; L6=0.037;

           L(1) = Link('revolute','alpha',0,'a', 0,'d',L1,'offset',0,'modified','qlim',[-pi pi]);
           L(2) = Link('revolute','alpha',-pi/2,'a', 0,'d',0,'offset',-pi/2,'modified','qlim',[-pi pi]);
           L(3) = Link('revolute','alpha',0,'a', L2,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(4) = Link('revolute','alpha',-pi/2,'a', L3,'d',L4,'offset',0,'modified', 'qlim',[-pi pi]);
           L(5) = Link('revolute','alpha',pi/2,'a', 0,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(6) = Link('revolute','alpha',-pi/2,'a', L5,'d',L6,'offset', 0,'modified','qlim',[-pi pi]);

           pos_x = [0];
           pos_y = [0];
           pos_z = [0];

           MTH_BC = L(1).A(Q(1));
           [R,translation] = tr2rt(MTH_BC);
           pos_x(1) = [translation(1)];
           pos_y(1) = [translation(2)];
           pos_z(1) = [translation(3)];

           for i=2:6
               MTH_BC = MTH_BC*L(i).A(Q(i));
               [R,translation] = tr2rt(MTH_BC);
               pos_x(i+1) = [translation(1)];
               pos_y(i+1) = [translation(2)];
               pos_z(i+1) = [translation(3)];
               plot3(app.grafica,pos_x(i+1),pos_y(i+1),pos_z(i+1),'-o' , 'Color' , 'b' , 'MarkerSize' , 10,'MarkerFaceColor','b')
           end

           plot3(app.grafica,pos_x,pos_y,pos_z,'LineWidth',5,'Color',[.6 0 0]);

           tool = MTH_BC*[0.15 0 0 1]';
           pos_tool_x = [pos_x(7) tool(1)];
           pos_tool_y = [pos_y(7) tool(2)];
           pos_tool_z = [pos_z(7) tool(3)];
           plot3(app.grafica,pos_tool_x,pos_tool_y,pos_tool_z,'LineWidth',2,'Color','r');

           tool = MTH_BC*[0 0 0.2 1]';
           pos_tool_x = [pos_x(7) tool(1)];
           pos_tool_y = [pos_y(7) tool(2)];
           pos_tool_z = [pos_z(7) tool(3)];
           plot3(app.grafica,pos_tool_x,pos_tool_y,pos_tool_z,'LineWidth',2,'Color','c');

           view(app.grafica,140,30);
           axis(app.grafica,[-1 1 -1 1 -0.67 1.3]);
           hold(app.grafica,'off');

           app.info_q1.Value = round(q_1*180/pi,2);
           app.info_q2.Value = round(q_2*180/pi,2);
           app.info_q3.Value = round(q_3*180/pi,2);
           app.info_q4.Value = round(q_4*180/pi,2);
           app.info_q5.Value = round(q_5*180/pi,2);
           app.info_q6.Value = round(q_6*180/pi,2);

           app.posX.Value = round(translation(1)*1000,2);
           app.posY.Value = round(translation(2)*1000,2);
           app.posZ.Value = round(translation(3)*1000,2);
            
        end

        % Value changed function: q3
        function q3ValueChanged(app, event)
            value = app.q3.Value;
            
        end

        % Value changed function: q1
        function q1ValueChanged(app, event)
            value = app.q1.Value;
            
        end

        % Value changed function: info_q1
        function info_q1ValueChanged(app, event)
            value = app.info_q1.Value;
            
        end

        % Value changed function: info_q2
        function info_q2ValueChanged(app, event)
            value = app.info_q2.Value;
            
        end

        % Value changed function: info_q3
        function info_q3ValueChanged(app, event)
            value = app.info_q3.Value;
            
        end

        % Value changed function: info_q4
        function info_q4ValueChanged(app, event)
            value = app.info_q4.Value;
            
        end

        % Value changed function: info_q5
        function info_q5ValueChanged(app, event)
            value = app.info_q5.Value;
            
        end

        % Value changed function: info_q6
        function info_q6ValueChanged(app, event)
            value = app.info_q6.Value;
            
        end

        % Value changed function: q4
        function q4ValueChanged(app, event)
            value = app.q4.Value;
            
        end

        % Value changed function: q5
        function q5ValueChanged(app, event)
            value = app.q5.Value;
            
        end

        % Value changed function: q6
        function q6ValueChanged(app, event)
            value = app.q6.Value;
            
        end

        % Value changed function: posX
        function posXValueChanged(app, event)
            value = app.posX.Value;
            
        end

        % Value changed function: posY
        function posYValueChanged(app, event)
            value = app.posY.Value;
            
        end

        % Value changed function: posZ
        function posZValueChanged(app, event)
            value = app.posZ.Value;
            
        end

        % Value changing function: q2
        function q2ValueChanging(app, event)
            close all; clc;
            plot(app.grafica,0,0);
            axis(app.grafica,'on');
            grid(app.grafica,'on')
            hold(app.grafica,'on');
            title(app.grafica,'Robot ABB CRB-15000');

            q_1 = app.q1.Value*pi/180;
            q_2 = event.Value*pi/180;
            q_3 = app.q3.Value*pi/180;
            q_4 = app.q4.Value*pi/180;
            q_5 = app.q5.Value*pi/180;
            q_6 = app.q6.Value*pi/180;
            Q = [q_1 q_2 q_3 q_4 q_5 q_6];

           L1=0.265; L2=0.444; L3=0.110; L4=0.470; L5=0.080; L6=0.037;

           L(1) = Link('revolute','alpha',0,'a', 0,'d',L1,'offset',0,'modified','qlim',[-pi pi]);
           L(2) = Link('revolute','alpha',-pi/2,'a', 0,'d',0,'offset',-pi/2,'modified','qlim',[-pi pi]);
           L(3) = Link('revolute','alpha',0,'a', L2,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(4) = Link('revolute','alpha',-pi/2,'a', L3,'d',L4,'offset',0,'modified', 'qlim',[-pi pi]);
           L(5) = Link('revolute','alpha',pi/2,'a', 0,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(6) = Link('revolute','alpha',-pi/2,'a', L5,'d',L6,'offset', 0,'modified','qlim',[-pi pi]);

           pos_x = [0];
           pos_y = [0];
           pos_z = [0];

           MTH_BC = L(1).A(Q(1));
           [R,translation] = tr2rt(MTH_BC);
           pos_x(1) = [translation(1)];
           pos_y(1) = [translation(2)];
           pos_z(1) = [translation(3)];

           for i=2:6
               MTH_BC = MTH_BC*L(i).A(Q(i));
               [R,translation] = tr2rt(MTH_BC);
               pos_x(i+1) = [translation(1)];
               pos_y(i+1) = [translation(2)];
               pos_z(i+1) = [translation(3)];
               plot3(app.grafica,pos_x(i+1),pos_y(i+1),pos_z(i+1),'-o' , 'Color' , 'b' , 'MarkerSize' , 10,'MarkerFaceColor','b')
           end

           plot3(app.grafica,pos_x,pos_y,pos_z,'LineWidth',5,'Color',[.6 0 0]);

           tool = MTH_BC*[0.15 0 0 1]';
           pos_tool_x = [pos_x(7) tool(1)];
           pos_tool_y = [pos_y(7) tool(2)];
           pos_tool_z = [pos_z(7) tool(3)];
           plot3(app.grafica,pos_tool_x,pos_tool_y,pos_tool_z,'LineWidth',2,'Color','r');

           tool = MTH_BC*[0 0 0.2 1]';
           pos_tool_x = [pos_x(7) tool(1)];
           pos_tool_y = [pos_y(7) tool(2)];
           pos_tool_z = [pos_z(7) tool(3)];
           plot3(app.grafica,pos_tool_x,pos_tool_y,pos_tool_z,'LineWidth',2,'Color','c');

           view(app.grafica,140,30);
           axis(app.grafica,[-1 1 -1 1 -0.67 1.3]);
           hold(app.grafica,'off');

           app.info_q1.Value = round(q_1*180/pi,2);
           app.info_q2.Value = round(q_2*180/pi,2);
           app.info_q3.Value = round(q_3*180/pi,2);
           app.info_q4.Value = round(q_4*180/pi,2);
           app.info_q5.Value = round(q_5*180/pi,2);
           app.info_q6.Value = round(q_6*180/pi,2);

           app.posX.Value = round(translation(1)*1000,2);
           app.posY.Value = round(translation(2)*1000,2);
           app.posZ.Value = round(translation(3)*1000,2);
            
        end

        % Value changing function: q4
        function q4ValueChanging(app, event)
            close all; clc;
            plot(app.grafica,0,0);
            axis(app.grafica,'on');
            grid(app.grafica,'on')
            hold(app.grafica,'on');
            title(app.grafica,'Robot ABB CRB-15000');

            q_1 = app.q1.Value*pi/180;
            q_2 = app.q2.Value*pi/180;
            q_3 = app.q3.Value*pi/180;
            q_4 = event.Value*pi/180;
            q_5 = app.q5.Value*pi/180;
            q_6 = app.q6.Value*pi/180;
            Q = [q_1 q_2 q_3 q_4 q_5 q_6];

           L1=0.265; L2=0.444; L3=0.110; L4=0.470; L5=0.080; L6=0.037;

           L(1) = Link('revolute','alpha',0,'a', 0,'d',L1,'offset',0,'modified','qlim',[-pi pi]);
           L(2) = Link('revolute','alpha',-pi/2,'a', 0,'d',0,'offset',-pi/2,'modified','qlim',[-pi pi]);
           L(3) = Link('revolute','alpha',0,'a', L2,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(4) = Link('revolute','alpha',-pi/2,'a', L3,'d',L4,'offset',0,'modified', 'qlim',[-pi pi]);
           L(5) = Link('revolute','alpha',pi/2,'a', 0,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(6) = Link('revolute','alpha',-pi/2,'a', L5,'d',L6,'offset', 0,'modified','qlim',[-pi pi]);

           pos_x = [0];
           pos_y = [0];
           pos_z = [0];

           MTH_BC = L(1).A(Q(1));
           [R,translation] = tr2rt(MTH_BC);
           pos_x(1) = [translation(1)];
           pos_y(1) = [translation(2)];
           pos_z(1) = [translation(3)];

           for i=2:6
               MTH_BC = MTH_BC*L(i).A(Q(i));
               [R,translation] = tr2rt(MTH_BC);
               pos_x(i+1) = [translation(1)];
               pos_y(i+1) = [translation(2)];
               pos_z(i+1) = [translation(3)];
               plot3(app.grafica,pos_x(i+1),pos_y(i+1),pos_z(i+1),'-o' , 'Color' , 'b' , 'MarkerSize' , 10,'MarkerFaceColor','b')
           end

           plot3(app.grafica,pos_x,pos_y,pos_z,'LineWidth',5,'Color',[.6 0 0]);
           view(app.grafica,140,30);
           axis(app.grafica,[-1 1 -1 1 -0.67 1.3]);
           hold(app.grafica,'off');

           app.info_q1.Value = round(q_1*180/pi,2);
           app.info_q2.Value = round(q_2*180/pi,2);
           app.info_q3.Value = round(q_3*180/pi,2);
           app.info_q4.Value = round(q_4*180/pi,2);
           app.info_q5.Value = round(q_5*180/pi,2);
           app.info_q6.Value = round(q_6*180/pi,2);

           app.posX.Value = round(translation(1)*1000,2);
           app.posY.Value = round(translation(2)*1000,2);
           app.posZ.Value = round(translation(3)*1000,2);
            
        end

        % Value changing function: q5
        function q5ValueChanging(app, event)
            close all; clc;
            plot(app.grafica,0,0);
            axis(app.grafica,'on');
            grid(app.grafica,'on')
            hold(app.grafica,'on');
            title(app.grafica,'Robot ABB CRB-15000');

            q_1 = app.q1.Value*pi/180;
            q_2 = app.q2.Value*pi/180;
            q_3 = app.q3.Value*pi/180;
            q_4 = app.q4.Value*pi/180;
            q_5 = event.Value*pi/180;
            q_6 = app.q6.Value*pi/180;
            Q = [q_1 q_2 q_3 q_4 q_5 q_6];

           L1=0.265; L2=0.444; L3=0.110; L4=0.470; L5=0.080; L6=0.037;

           L(1) = Link('revolute','alpha',0,'a', 0,'d',L1,'offset',0,'modified','qlim',[-pi pi]);
           L(2) = Link('revolute','alpha',-pi/2,'a', 0,'d',0,'offset',-pi/2,'modified','qlim',[-pi pi]);
           L(3) = Link('revolute','alpha',0,'a', L2,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(4) = Link('revolute','alpha',-pi/2,'a', L3,'d',L4,'offset',0,'modified', 'qlim',[-pi pi]);
           L(5) = Link('revolute','alpha',pi/2,'a', 0,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(6) = Link('revolute','alpha',-pi/2,'a', L5,'d',L6,'offset', 0,'modified','qlim',[-pi pi]);

           pos_x = [0];
           pos_y = [0];
           pos_z = [0];

           MTH_BC = L(1).A(Q(1));
           [R,translation] = tr2rt(MTH_BC);
           pos_x(1) = [translation(1)];
           pos_y(1) = [translation(2)];
           pos_z(1) = [translation(3)];

           for i=2:6
               MTH_BC = MTH_BC*L(i).A(Q(i));
               [R,translation] = tr2rt(MTH_BC);
               pos_x(i+1) = [translation(1)];
               pos_y(i+1) = [translation(2)];
               pos_z(i+1) = [translation(3)];
               plot3(app.grafica,pos_x(i+1),pos_y(i+1),pos_z(i+1),'-o' , 'Color' , 'b' , 'MarkerSize' , 10,'MarkerFaceColor','b')
           end

           plot3(app.grafica,pos_x,pos_y,pos_z,'LineWidth',5,'Color',[.6 0 0]);
           view(app.grafica,140,30);
           axis(app.grafica,[-1 1 -1 1 -0.67 1.3]);
           hold(app.grafica,'off');

           app.info_q1.Value = round(q_1*180/pi,2);
           app.info_q2.Value = round(q_2*180/pi,2);
           app.info_q3.Value = round(q_3*180/pi,2);
           app.info_q4.Value = round(q_4*180/pi,2);
           app.info_q5.Value = round(q_5*180/pi,2);
           app.info_q6.Value = round(q_6*180/pi,2);

           app.posX.Value = round(translation(1)*1000,2);
           app.posY.Value = round(translation(2)*1000,2);
           app.posZ.Value = round(translation(3)*1000,2);
        end

        % Value changing function: q6
        function q6ValueChanging(app, event)
            close all; clc;
            plot(app.grafica,0,0);
            axis(app.grafica,'on');
            grid(app.grafica,'on')
            hold(app.grafica,'on');
            title(app.grafica,'Robot ABB CRB-15000');

            q_1 = app.q1.Value*pi/180;
            q_2 = app.q2.Value*pi/180;
            q_3 = app.q3.Value*pi/180;
            q_4 = app.q4.Value*pi/180;
            q_5 = app.q5.Value*pi/180;
            q_6 = event.Value*pi/180;
            Q = [q_1 q_2 q_3 q_4 q_5 q_6];

           L1=0.265; L2=0.444; L3=0.110; L4=0.470; L5=0.080; L6=0.037;

           L(1) = Link('revolute','alpha',0,'a', 0,'d',L1,'offset',0,'modified','qlim',[-pi pi]);
           L(2) = Link('revolute','alpha',-pi/2,'a', 0,'d',0,'offset',-pi/2,'modified','qlim',[-pi pi]);
           L(3) = Link('revolute','alpha',0,'a', L2,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(4) = Link('revolute','alpha',-pi/2,'a', L3,'d',L4,'offset',0,'modified', 'qlim',[-pi pi]);
           L(5) = Link('revolute','alpha',pi/2,'a', 0,'d',0,'offset',0,'modified','qlim',[-pi pi]);
           L(6) = Link('revolute','alpha',-pi/2,'a', L5,'d',L6,'offset', 0,'modified','qlim',[-pi pi]);

           pos_x = [0];
           pos_y = [0];
           pos_z = [0];

           MTH_BC = L(1).A(Q(1));
           [R,translation] = tr2rt(MTH_BC);
           pos_x(1) = [translation(1)];
           pos_y(1) = [translation(2)];
           pos_z(1) = [translation(3)];

           for i=2:6
               MTH_BC = MTH_BC*L(i).A(Q(i));
               [R,translation] = tr2rt(MTH_BC);
               pos_x(i+1) = [translation(1)];
               pos_y(i+1) = [translation(2)];
               pos_z(i+1) = [translation(3)];
               plot3(app.grafica,pos_x(i+1),pos_y(i+1),pos_z(i+1),'-o' , 'Color' , 'b' , 'MarkerSize' , 10,'MarkerFaceColor','b')
           end

           plot3(app.grafica,pos_x,pos_y,pos_z,'LineWidth',5,'Color',[.6 0 0]);
           view(app.grafica,140,30);
           axis(app.grafica,[-1 1 -1 1 -0.67 1.3]);
           hold(app.grafica,'off');

           app.info_q1.Value = round(q_1*180/pi,2);
           app.info_q2.Value = round(q_2*180/pi,2);
           app.info_q3.Value = round(q_3*180/pi,2);
           app.info_q4.Value = round(q_4*180/pi,2);
           app.info_q5.Value = round(q_5*180/pi,2);
           app.info_q6.Value = round(q_6*180/pi,2);

           app.posX.Value = round(translation(1)*1000,2);
           app.posY.Value = round(translation(2)*1000,2);
           app.posZ.Value = round(translation(3)*1000,2);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create ABB_CRB_15000 and hide until all components are created
            app.ABB_CRB_15000 = uifigure('Visible', 'off');
            app.ABB_CRB_15000.Position = [100 100 961 565];
            app.ABB_CRB_15000.Name = 'MATLAB App';

            % Create grafica
            app.grafica = uiaxes(app.ABB_CRB_15000);
            title(app.grafica, 'Title')
            xlabel(app.grafica, 'X')
            ylabel(app.grafica, 'Y')
            zlabel(app.grafica, 'Z')
            app.grafica.Position = [366 18 564 515];

            % Create q1
            app.q1 = uislider(app.ABB_CRB_15000);
            app.q1.Limits = [-180 180];
            app.q1.ValueChangedFcn = createCallbackFcn(app, @q1ValueChanged, true);
            app.q1.ValueChangingFcn = createCallbackFcn(app, @q1ValueChanging, true);
            app.q1.Position = [156 364 150 3];

            % Create q3
            app.q3 = uislider(app.ABB_CRB_15000);
            app.q3.Limits = [-225 85];
            app.q3.ValueChangedFcn = createCallbackFcn(app, @q3ValueChanged, true);
            app.q3.ValueChangingFcn = createCallbackFcn(app, @q3ValueChanging, true);
            app.q3.Position = [157 264 150 3];

            % Create q4
            app.q4 = uislider(app.ABB_CRB_15000);
            app.q4.Limits = [-180 180];
            app.q4.ValueChangedFcn = createCallbackFcn(app, @q4ValueChanged, true);
            app.q4.ValueChangingFcn = createCallbackFcn(app, @q4ValueChanging, true);
            app.q4.Position = [157 215 150 3];

            % Create q5
            app.q5 = uislider(app.ABB_CRB_15000);
            app.q5.Limits = [-180 180];
            app.q5.ValueChangedFcn = createCallbackFcn(app, @q5ValueChanged, true);
            app.q5.ValueChangingFcn = createCallbackFcn(app, @q5ValueChanging, true);
            app.q5.Position = [157 165 150 3];

            % Create q2
            app.q2 = uislider(app.ABB_CRB_15000);
            app.q2.Limits = [-180 180];
            app.q2.ValueChangingFcn = createCallbackFcn(app, @q2ValueChanging, true);
            app.q2.Position = [156 314 150 3];

            % Create q6
            app.q6 = uislider(app.ABB_CRB_15000);
            app.q6.Limits = [-180 180];
            app.q6.ValueChangedFcn = createCallbackFcn(app, @q6ValueChanged, true);
            app.q6.ValueChangingFcn = createCallbackFcn(app, @q6ValueChanging, true);
            app.q6.Position = [157 118 150 3];

            % Create q1Label
            app.q1Label = uilabel(app.ABB_CRB_15000);
            app.q1Label.HorizontalAlignment = 'right';
            app.q1Label.Position = [45 355 25 22];
            app.q1Label.Text = 'q1';

            % Create info_q1
            app.info_q1 = uieditfield(app.ABB_CRB_15000, 'numeric');
            app.info_q1.ValueChangedFcn = createCallbackFcn(app, @info_q1ValueChanged, true);
            app.info_q1.Position = [80 354 43 22];

            % Create q1Label_2
            app.q1Label_2 = uilabel(app.ABB_CRB_15000);
            app.q1Label_2.HorizontalAlignment = 'right';
            app.q1Label_2.Position = [45 305 25 22];
            app.q1Label_2.Text = 'q2';

            % Create info_q2
            app.info_q2 = uieditfield(app.ABB_CRB_15000, 'numeric');
            app.info_q2.ValueChangedFcn = createCallbackFcn(app, @info_q2ValueChanged, true);
            app.info_q2.Position = [80 304 43 22];

            % Create q1Label_3
            app.q1Label_3 = uilabel(app.ABB_CRB_15000);
            app.q1Label_3.HorizontalAlignment = 'right';
            app.q1Label_3.Position = [45 255 25 22];
            app.q1Label_3.Text = 'q3';

            % Create info_q3
            app.info_q3 = uieditfield(app.ABB_CRB_15000, 'numeric');
            app.info_q3.ValueChangedFcn = createCallbackFcn(app, @info_q3ValueChanged, true);
            app.info_q3.Position = [80 254 43 22];

            % Create q1Label_4
            app.q1Label_4 = uilabel(app.ABB_CRB_15000);
            app.q1Label_4.HorizontalAlignment = 'right';
            app.q1Label_4.Position = [45 206 25 22];
            app.q1Label_4.Text = 'q4';

            % Create info_q4
            app.info_q4 = uieditfield(app.ABB_CRB_15000, 'numeric');
            app.info_q4.ValueChangedFcn = createCallbackFcn(app, @info_q4ValueChanged, true);
            app.info_q4.Position = [80 205 43 22];

            % Create q1Label_5
            app.q1Label_5 = uilabel(app.ABB_CRB_15000);
            app.q1Label_5.HorizontalAlignment = 'right';
            app.q1Label_5.Position = [45 156 25 22];
            app.q1Label_5.Text = 'q5';

            % Create info_q5
            app.info_q5 = uieditfield(app.ABB_CRB_15000, 'numeric');
            app.info_q5.ValueChangedFcn = createCallbackFcn(app, @info_q5ValueChanged, true);
            app.info_q5.Position = [80 155 43 22];

            % Create q1Label_6
            app.q1Label_6 = uilabel(app.ABB_CRB_15000);
            app.q1Label_6.HorizontalAlignment = 'right';
            app.q1Label_6.Position = [45 108 25 22];
            app.q1Label_6.Text = 'q6';

            % Create info_q6
            app.info_q6 = uieditfield(app.ABB_CRB_15000, 'numeric');
            app.info_q6.ValueChangedFcn = createCallbackFcn(app, @info_q6ValueChanged, true);
            app.info_q6.Position = [80 107 43 22];

            % Create PosicinEfectorFinalLabel
            app.PosicinEfectorFinalLabel = uilabel(app.ABB_CRB_15000);
            app.PosicinEfectorFinalLabel.FontSize = 14;
            app.PosicinEfectorFinalLabel.FontWeight = 'bold';
            app.PosicinEfectorFinalLabel.Position = [134 511 153 22];
            app.PosicinEfectorFinalLabel.Text = 'Posición Efector Final';

            % Create XEditFieldLabel
            app.XEditFieldLabel = uilabel(app.ABB_CRB_15000);
            app.XEditFieldLabel.HorizontalAlignment = 'right';
            app.XEditFieldLabel.FontWeight = 'bold';
            app.XEditFieldLabel.Position = [134 466 25 22];
            app.XEditFieldLabel.Text = 'X';

            % Create posX
            app.posX = uieditfield(app.ABB_CRB_15000, 'numeric');
            app.posX.ValueChangedFcn = createCallbackFcn(app, @posXValueChanged, true);
            app.posX.FontWeight = 'bold';
            app.posX.Position = [174 466 100 22];

            % Create YEditFieldLabel
            app.YEditFieldLabel = uilabel(app.ABB_CRB_15000);
            app.YEditFieldLabel.HorizontalAlignment = 'right';
            app.YEditFieldLabel.FontWeight = 'bold';
            app.YEditFieldLabel.Position = [134 432 25 22];
            app.YEditFieldLabel.Text = 'Y';

            % Create posY
            app.posY = uieditfield(app.ABB_CRB_15000, 'numeric');
            app.posY.ValueChangedFcn = createCallbackFcn(app, @posYValueChanged, true);
            app.posY.FontWeight = 'bold';
            app.posY.Position = [174 432 100 22];

            % Create ZEditFieldLabel
            app.ZEditFieldLabel = uilabel(app.ABB_CRB_15000);
            app.ZEditFieldLabel.HorizontalAlignment = 'right';
            app.ZEditFieldLabel.FontWeight = 'bold';
            app.ZEditFieldLabel.Position = [134 398 25 22];
            app.ZEditFieldLabel.Text = 'Z';

            % Create posZ
            app.posZ = uieditfield(app.ABB_CRB_15000, 'numeric');
            app.posZ.ValueChangedFcn = createCallbackFcn(app, @posZValueChanged, true);
            app.posZ.FontWeight = 'bold';
            app.posZ.Position = [174 398 100 22];

            % Create mmLabel
            app.mmLabel = uilabel(app.ABB_CRB_15000);
            app.mmLabel.FontWeight = 'bold';
            app.mmLabel.Position = [280 466 27 22];
            app.mmLabel.Text = 'mm';

            % Create mmLabel_2
            app.mmLabel_2 = uilabel(app.ABB_CRB_15000);
            app.mmLabel_2.FontWeight = 'bold';
            app.mmLabel_2.Position = [280 432 27 22];
            app.mmLabel_2.Text = 'mm';

            % Create mmLabel_3
            app.mmLabel_3 = uilabel(app.ABB_CRB_15000);
            app.mmLabel_3.FontWeight = 'bold';
            app.mmLabel_3.Position = [280 398 27 22];
            app.mmLabel_3.Text = 'mm';

            % Create ParacomenzarutilizacualquiersliderparaconfigurarunanguloLabel
            app.ParacomenzarutilizacualquiersliderparaconfigurarunanguloLabel = uilabel(app.ABB_CRB_15000);
            app.ParacomenzarutilizacualquiersliderparaconfigurarunanguloLabel.HorizontalAlignment = 'center';
            app.ParacomenzarutilizacualquiersliderparaconfigurarunanguloLabel.FontWeight = 'bold';
            app.ParacomenzarutilizacualquiersliderparaconfigurarunanguloLabel.Position = [33 37 337 28];
            app.ParacomenzarutilizacualquiersliderparaconfigurarunanguloLabel.Text = {'Para comenzar, utiliza cualquier slider para configurar un'; 'angulo de rotación ''q'' y se graficará automáticamente.'};

            % Show the figure after all components are created
            app.ABB_CRB_15000.Visible = 'on';
        end

    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = App_ABB_CRB15000

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.ABB_CRB_15000)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.ABB_CRB_15000)
        end
    end
end