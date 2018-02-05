function [Events] = load_pointswheel(time,Events)
%
command =   'load(''pointsWheelLocations'');';
Events = newevent_command(Events,time,command,'clear_no');
%
command =   'load(''scorecolormatrix'');';
Events = newevent_command(Events,time,command,'clear_no');

% load('scorecolormatrix');
%Points Wheel 1 (Inner)
pointsWheelRadius1 = colorWheelRadius1 + 20; %radius of color wheel
%Cartesian Conversion
pointsWheelLocations1 = [cosd(1:359).*pointsWheelRadius1 + Parameters.centerx; ...
    sind(1:359).*pointsWheelRadius1 + Parameters.centery];

%Points Wheel (Outer)
pointsWheelRadius2 = pointsWheelRadius1 + 8; %radius of color wheel
%Cartesian Conversion
pointsWheelLocations2 = [cosd(1:359).*pointsWheelRadius2 + Parameters.centerx; ...
    sind(1:359).*pointsWheelRadius2 + Parameters.centery];
% scorecolormatrix=scorecolormatrix(1:359,:);
%                 command =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations1, 10, scorecolormatrix'', [], 1);';
showdotscommand1 =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations1, 10, scorecolormatrix'', [], 1);';
Events = newevent_command(Events,time,showdotscommand1,'clear_no');
showdotscommand2 =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations2, 10, scorecolormatrix'', [], 1);';
Events = newevent_command(Events,time,showdotscommand2,'clear_no');

end