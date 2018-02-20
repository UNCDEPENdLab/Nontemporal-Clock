%Loads points wheel
command = 'scorecolormatrix=csvread(''scorecolormatrix.csv'');';
Events = newevent_command(Events,points_time,command,'clear_no');
command =   'load(''pointsWheelLocations'');';
Events = newevent_command(Events,points_time,command,'clear_no');
command =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations1, 10, scorecolormatrix'', [], 1);';
Events = newevent_command(Events,points_time,command,'clear_no');
command =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations2, 10, scorecolormatrix'', [], 1);';
Events = newevent_command(Events,points_time,command,'clear_no');

% command = 'eval(firstpoint1 = pointsWheelLocations1(:,1)';
% Events = newevent_command(Events,points_time,command,'clear_no');
% command = 'eval(firstpoint2 = pointsWheelLocations2(:,2)';
% Events = newevent_command(Events,points_time,command,'clear_no');
% command = 'eval(firstcolor = scorecolormatrix(360,:)';
% Events = newevent_command(Events,points_time,command,'clear_no');

command =   'Screen(''DrawDots'', Parameters.window, firstpoint1, 5.5, firstcolor'', [], 1);';
Events = newevent_command(Events,points_time,command,'clear_no');
command =   'Screen(''DrawDots'', Parameters.window, firstpoint2, 5.5, firstcolor'', [], 1);';
Events = newevent_command(Events,points_time,command,'clear_no');