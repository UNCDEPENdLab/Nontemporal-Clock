%Loads points wheel
command = 'scorecolormatrix=csvread(''scorecolormatrix.csv'');';
Events = newevent_command(Events,points_time,command,'clear_no');
command =   'load(''pointsWheelLocations'');';
Events = newevent_command(Events,points_time,command,'clear_no');
command =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations1, 10, scorecolormatrix'', [], 1);';
Events = newevent_command(Events,points_time,command,'clear_no');
command =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations2, 10, scorecolormatrix'', [], 1);';
Events = newevent_command(Events,points_time,command,'clear_no');