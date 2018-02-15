if ~full_wheel
    to_load = 'selected_segment';
else
    to_load = 'fullcolormatrxi';
end

command =   'load(to_load);';
Events = newevent_command(Events,clickwheeltime,command,'clear_no');
command =   'load(''colorWheelLocations1'');';
Events = newevent_command(Events,clickwheeltime,command,'clear_no');
command =   'load(''colorWheelLocations2'');';
Events = newevent_command(Events,clickwheeltime,command,'clear_no');
command =   'load(''colorWheelLocations3'');';
Events = newevent_command(Events,clickwheeltime,command,'clear_no');
command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations1, 10, to_load'', [], 1);';
Events = newevent_command(Events,clickwheeltime,command,'clear_no');
command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations2, 10, to_load'', [], 1);';
Events = newevent_command(Events,clickwheeltime,command,'clear_no');
command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations3, 10, to_load'', [], 1);';
Events = newevent_command(Events,clickwheeltime,command,'clear_no');