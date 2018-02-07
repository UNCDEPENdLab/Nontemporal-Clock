            %Loads points wheel
            command =   'load(''scorecolormatrix'');';
            Events = newevent_command(Events,points_time,command,'clear_no'); %selected segment
            command =   'load(''pointsWheelLocations1'');';
            Events = newevent_command(Events,points_time,command,'clear_no');
            command =   'load(''pointsWheelLocations2'');';
            Events = newevent_command(Events,points_time,command,'clear_no');
            command =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations1, 10, scorecolormatrix'', [], 1);';
            Events = newevent_command(Events,points_time,command,'clear_no');
            command =   'Screen(''DrawDots'', Parameters.window, pointsWheelLocations2, 10, scorecolormatrix'', [], 1);';
            Events = newevent_command(Events,points_time,command,'clear_no');