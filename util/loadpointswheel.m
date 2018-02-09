%Loads points wheel
% command =   'load(''scorecolormatrix'');';
command = 'scorecolormatrix=csvread(''scorecolormatrix.csv'');';
Events = newevent_command(Events,points_time,command,'clear_no'); %selected segment
command =   'load(''pointsWheelLocations1'');';
Events = newevent_command(Events,points_time,command,'clear_no');
command =   'load(''pointsWheelLocations2'');';
Events = newevent_command(Events,points_time,command,'clear_no');
command =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations1, 10, scorecolormatrix'', [], 1);';
Events = newevent_command(Events,points_time,command,'clear_no');
command =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations2, 10, scorecolormatrix'', [], 1);';
Events = newevent_command(Events,points_time,command,'clear_no');

% command = 'load(''pointswheel1_endnotch'')';
% Events = newevent_command(Events,points_time,command,'clear_no');
% command =   'Screen(''DrawDots'', Parameters.window, pointswheel1_endnotch, 10, [0 0 0]'', [], 1);';
% Events = newevent_command(Events,points_time,command,'clear_no');
% command = 'load(''pointswheel2_endnotch'')';
% Events = newevent_command(Events,points_time,command,'clear_no');
% command =   'Screen(''DrawDots'', Parameters.window, pointswheel2_endnotch, 10, [0 0 0]'', [], 1);';
% Events = newevent_command(Events,points_time,command,'clear_no');