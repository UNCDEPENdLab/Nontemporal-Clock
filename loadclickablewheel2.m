if full_wheel == 0
    command =   'load(''selected_segment'');';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'load(''colorWheelLocations'');';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations1, 10, selected_segment'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations2, 10, selected_segment'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations3, 10, selected_segment'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
elseif full_wheel == 1
    command =   'load(''wheel360'');';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'load(''colorWheelLocations'');';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations1, 10, fullcolormatrix'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations2, 10, fullcolormatrix'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations3, 10, fullcolormatrix'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
elseif full_wheel == -1
    command =   'load(''basecolormatrix'')';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'load(''colorWheelLocations'');';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations1, 10, basecolormatrix'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations2, 10, basecolormatrix'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations3, 10, basecolormatrix'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
else
    command = 'segment_response = csvread(''segment_response'');selected_row = csvread(''selected_row'');selected_segment = csvread(''selected_segment'');';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'load(''colorWheelLocations'');';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations1, 10, selected_segment'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations2, 10, selected_segment'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
    command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations3, 10, selected_segment'', [], 1);';
    Events = newevent_command(Events,clickwheeltime2,command,'clear_no');
end