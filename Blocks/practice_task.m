function [Events Parameters Stimuli_sets Block_Export Trial_Export  Numtrials]=clock_task(Parameters, Stimuli_sets, Trial, Blocknum, Modeflag, ...
    Events,Block_Export,Trial_Export,Demodata)

load('blockvars');addpath(genpath('util'));

%Paradigm programmed by Michael R Hess, March '18

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(Modeflag,'InitializeBlock')
    clear Stimuli_sets
    
    %% Trial Parameters% (Not all. For the rest, scroll down to "The Experiment Display" section.)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Parameters.blocklist
    Blocknum
    try
        con_num = Demodata.practice_struct(Blocknum);
    catch
        con_num = 1;
    end
    
    num_blocks = length(Parameters.blocklist);
    s_cb = mod(Demodata.s_num,2);
    s_cb = s_cb(1);
    
    if con_num == 1
        show_points = 1; even_uneven = 1; num_segments = 4;
    elseif con_num == 2
        show_points = 0; even_uneven = 2; num_segments = 4;
    elseif con_num == 3
        show_points = 1; even_uneven = 2; num_segments = 8;
    end
    
    %Total number of trials
    Numtrials = num_segments*2 + 1; %Because of the way this block file runs, set Numtrials equal to the amount of trials you want and then add 1
    
    %Set the min & max win probability of the best & worst segment (random).
    %The rest of the segments are given probabilites on a gradient between these.
    min_prob = 0.4; %min segment probability
    max_prob = 0.6; %max segmenet probability
    
    test_mode = 0; %test mode deactivates instructions atm
    speed_test = 0; %disables mouse
    turn_bot_off = 0; %turn off bot mode?
    toggle_botbutton = 0; %0 = click wheel during bot mode, 1 = click button
    
    if test_mode
        Numtrials = 30;
    end
    
    seg_colors{1} = [0 105 255]; %colors of segments
    seg_colors{2} = seg_colors{1};
    add_wheel_borders = 1;
    
    %Timing variables%
    
    %When the instructions will be displayed from the start of the experiment (Trial 1)
    instruction_display_time = 0;
    reward_time = instruction_display_time+.01;
    
    %When the segment wheel will appear
    seg_wheel_time = instruction_display_time + 2;
    
    %How long the feedback will display on screen at the end of a trial
    if speed_test
        total_feedback_time = .01;
    else
        total_feedback_time = 1;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Set up Stimuli
    
    %Create segments on click wheel
    [seg_values scorecolormatrix change_spot num_wheel_boxes] = segment_wheel(num_segments,seg_colors,add_wheel_borders);
    seg_rows = randperm(num_segments);
    
    csvwrite('seg_rows.csv',seg_rows);
    csvwrite('blankcolormatrix.csv',scorecolormatrix);
    
    add_choice = 0;
    for add_seg_row = 1:(num_segments/2)
        for add_seg_val = 1:length(seg_values(1,:))
            add_choice = add_choice + 1;
            possible_bot_choices(add_choice) = seg_values(seg_rows(add_seg_row),add_seg_val);
        end
    end
    
    csvwrite('scorecolormatrix.csv',scorecolormatrix);
    scorecolormatrix2 = scorecolormatrix;
    csvwrite('scorecolormatrix2.csv',scorecolormatrix2);
    
    scorecolormatrix3 = scorecolormatrix;
    csvwrite('scorecolormatrix3.csv',scorecolormatrix3);
    scorecolormatrix4 = scorecolormatrix2;
    csvwrite('scorecolormatrix4.csv',scorecolormatrix4);
    
    save('seg_values','seg_values');
    
    %Enables mouse
    Parameters.mouse.enabled = 1;
    
    %Color Wheel 1 (Outer)
    colorWheelRadius1 = 260; %radius of color wheel
    %Cartesian Conversion
    colorWheelLocations1 = [cosd(1:num_wheel_boxes).*colorWheelRadius1 + Parameters.centerx; ...
        sind(1:num_wheel_boxes).*colorWheelRadius1 + Parameters.centery];
    
    %Color Wheel 2 (Mid)
    colorWheelRadius2 = 252; %radius of color wheel
    %Cartesian Conversion
    colorWheelLocations2 = [cosd(1:num_wheel_boxes).*colorWheelRadius2 + Parameters.centerx; ...
        sind(1:num_wheel_boxes).*colorWheelRadius2 + Parameters.centery];
    
    %Color Wheel 3 (Inner)
    colorWheelRadius3 = 244; %radius of color wheel
    %Cartesian Conversion
    colorWheelLocations3 = [cosd(1:num_wheel_boxes).*colorWheelRadius3 + Parameters.centerx; ...
        sind(1:num_wheel_boxes).*colorWheelRadius3+ Parameters.centery];
    
    %Points Wheel 1 (Inner)
    pointsWheelRadius1 = colorWheelRadius1 + 40; %radius of color wheel
    %Cartesian Conversion
    pointsWheelLocations1 = [cosd(1:num_wheel_boxes).*pointsWheelRadius1 + Parameters.centerx; ...
        sind(1:num_wheel_boxes).*pointsWheelRadius1 + Parameters.centery];
    pointsWheelLocations1(2,360) = pointsWheelLocations1(2,360) - 0.1;
    
    %Points Wheel 1 (Outer)
    pointsWheelRadius2 = pointsWheelRadius1 + 8; %radius of color wheel
    %Cartesian Conversion
    pointsWheelLocations2 = [cosd(1:num_wheel_boxes).*pointsWheelRadius2 + Parameters.centerx; ...
        sind(1:num_wheel_boxes).*pointsWheelRadius2 + Parameters.centery];
    
    pointswheel2_endnotch = [cosd(360).*pointsWheelRadius2 + Parameters.centerx; ...
        sind(360).*pointsWheelRadius2 + Parameters.centery];
    
    pointsWheelLocations2(2,360) = pointsWheelLocations2(2,360) - 0.1;
    
    
    %Points Wheel 2 (Inner)
    pointsWheel2Radius1 = pointsWheelRadius1 - 19; %radius of color wheel
    %Cartesian Conversion
    pointsWheel2Locations1 = [cosd(1:num_wheel_boxes).*pointsWheel2Radius1 + Parameters.centerx; ...
        sind(1:num_wheel_boxes).*pointsWheel2Radius1 + Parameters.centery];
    
    pointswheel1_endnotch = [cosd(360).*pointsWheelRadius1 + Parameters.centerx; ...
        sind(360).*pointsWheelRadius1 + Parameters.centery];
    
    pointsWheel2Locations1(2,360) = pointsWheel2Locations1(2,360) - 0.1;
    
    %Points Wheel 1 (Outer)
    pointsWheel2Radius2 = pointsWheel2Radius1 + 8; %radius of color wheel
    %Cartesian Conversion
    pointsWheel2Locations2 = [cosd(1:num_wheel_boxes).*pointsWheel2Radius2 + Parameters.centerx; ...
        sind(1:num_wheel_boxes).*pointsWheel2Radius2 + Parameters.centery];
    
    pointswheel2_endnotch = [cosd(360).*pointsWheelRadius2 + Parameters.centerx; ...
        sind(360).*pointsWheelRadius2 + Parameters.centery];
    
    pointsWheel2Locations2(2,360) = pointsWheel2Locations2(2,360) - 0.1;
    
    %Location Wheel
    locationWheelRadius = colorWheelRadius1; %radius of color wheel
    %Cartesian Conversion
    locationWheelLocations1 = [cosd(1:num_wheel_boxes).*locationWheelRadius + Parameters.centerx; ...
        sind(1:num_wheel_boxes).*locationWheelRadius + Parameters.centery];
    
    %Location Wheel
    locationWheelRadius = colorWheelRadius2; %radius of color wheel
    %Cartesian Conversion
    locationWheelLocations2 = [cosd(1:num_wheel_boxes).*locationWheelRadius + Parameters.centerx; ...
        sind(1:num_wheel_boxes).*locationWheelRadius + Parameters.centery];
    
    %Location Wheel
    locationWheelRadius = colorWheelRadius3; %radius of color wheel
    %Cartesian Conversion
    locationWheelLocations3 = [cosd(1:num_wheel_boxes).*locationWheelRadius + Parameters.centerx; ...
        sind(1:num_wheel_boxes).*locationWheelRadius + Parameters.centery];
    
    locationWheelLocations = [locationWheelLocations1 locationWheelLocations2 locationWheelLocations3];
    
    but_count = 0;
    %Used for mouse clicks on color wheel
    for i = 1:num_wheel_boxes
        but_count = but_count + 1;
        if i < num_wheel_boxes
            buttonlocs{but_count} = [locationWheelLocations(1,i),locationWheelLocations(2,i),22];
        else
            buttonlocs{but_count} = [0.1,0.1,1];
        end
    end
    
    loc_off = -2;
    
    firstpoint1(1,1) = mean(round(pointsWheelLocations1(1,1)),round(pointsWheelLocations1(1,2)));
    firstpoint1(2,1) = mean(round(pointsWheelLocations1(2,1)),round(pointsWheelLocations1(2,2)))+loc_off;
    firstpoint2(1,1) = mean(round(pointsWheelLocations2(1,1)),round(pointsWheelLocations2(1,2)));
    firstpoint2(2,1) = mean(round(pointsWheelLocations2(2,1)),round(pointsWheelLocations2(2,2)))+loc_off;
    firstcolor = scorecolormatrix(360,:);
    
    firstpoint3(1,1) = mean(round(pointsWheel2Locations1(1,1)),round(pointsWheel2Locations1(1,2)));
    firstpoint3(2,1) = mean(round(pointsWheel2Locations1(2,1)),round(pointsWheel2Locations1(2,2)))+loc_off;
    firstpoint4(1,1) = mean(round(pointsWheel2Locations2(1,1)),round(pointsWheel2Locations2(1,2)));
    firstpoint4(2,1) = mean(round(pointsWheel2Locations2(2,1)),round(pointsWheel2Locations2(2,2)))+loc_off;
    firstcolor2 = scorecolormatrix2(360,:);
    
    save('colorWheelLocations','colorWheelLocations1','colorWheelLocations2','colorWheelLocations3');
    save('pointsWheelLocations','pointsWheelLocations1','pointsWheelLocations2','pointsWheel2Locations1', ...
        'pointsWheel2Locations2','firstpoint1','firstpoint2','firstpoint3','firstpoint4','firstcolor','firstcolor2');
    save('pointswheel_endnotches','pointswheel1_endnotch','pointswheel2_endnotch');
    
    locx = Parameters.centerx;
    locy = Parameters.centery;
    
    border_offset = 8;
    
    %Color Wheel 1 Border
    cwb1 = 800;
    stimstruct = CreateStimStruct('shape');
    stimstruct.stimuli = {'FrameOval'};
    stimstruct.xdim = colorWheelRadius1*2+border_offset;
    stimstruct.ydim = colorWheelRadius1*2+border_offset;
    stimstruct.color = [0 0 0];
    Stimuli_sets(cwb1) = Preparestimuli(Parameters,stimstruct);
    
    %Color Wheel 2 Border
    stimstruct = CreateStimStruct('shape');
    for i = 1:2
        cwb2 = 801;
        stimstruct.stimuli = {'FrameOval'};
        stimstruct.xdim = pointsWheelRadius2*2+border_offset;
        stimstruct.ydim = pointsWheelRadius2*2+border_offset;
        stimstruct.color = [0 0 0];
        stimstruct.stimsize = 1;
        if i==2;stimstruct.stimsize = 1.01;end
        Stimuli_sets(cwb2+i-1) = Preparestimuli(Parameters,stimstruct);
    end
    
    %Points Wheel 1 Border
    pwb1 = 802;
    stimstruct = CreateStimStruct('shape');
    stimstruct.stimuli = {'FrameOval'};
    stimstruct.xdim = pointsWheelRadius1*2-border_offset;
    stimstruct.ydim = pointsWheelRadius1*2-border_offset;
    stimstruct.color = [0 0 0];
    Stimuli_sets(pwb1) = Preparestimuli(Parameters,stimstruct);
    
    %Points Wheel 2 Border
    stimstruct = CreateStimStruct('shape');
    for i = 1:2
        pwb2 = 803;
        stimstruct.stimuli = {'FrameOval'};
        stimstruct.xdim = pointsWheelRadius2*2+border_offset;
        stimstruct.ydim = pointsWheelRadius2*2+border_offset;
        stimstruct.color = [0 0 0];
        stimstruct.stimsize = 1;
        if i==2;stimstruct.stimsize = 1.01;end
        Stimuli_sets(pwb2+i-1) = Preparestimuli(Parameters,stimstruct);
    end
    
    %Bot button
    bot_but = 1010;
    stimstruct = CreateStimStruct('shape');
    stimstruct.stimuli = {'FillRect'};
    button_x = 300;
    button_y = 200;
    stimstruct.xdim = button_x;
    stimstruct.ydim = button_y;
    button_color = 225;
    stimstruct.color = [button_color button_color button_color];
    Stimuli_sets(bot_but) = Preparestimuli(Parameters,stimstruct);
    
    %Bot button frame
    bot_but_frame = 1011;
    stimstruct = CreateStimStruct('shape');
    stimstruct.stimuli = {'FrameRect'};
    stimstruct.xdim = button_x;
    stimstruct.ydim = button_y;
    button_color = 0;
    stimstruct.color = [button_color button_color button_color];
    Stimuli_sets(bot_but_frame) = Preparestimuli(Parameters,stimstruct);
    
    %Load face pics
    face_stims = 1;
    face_dir = dir('Stimuli/faces');
    stimstruct = CreateStimStruct('image');
    for f = 3:length(face_dir)
        stimstruct.stimuli{f-2} = sprintf('faces/%s',face_dir(f).name);
    end
    Stimuli_sets(face_stims) = Preparestimuli(Parameters,stimstruct);
    
    %Nickel
    nickel = 500;
    stimstruct = CreateStimStruct('image');
    stimstruct.stimuli = {'nickel_noback.png'};
    stimstruct.stimsize = 1;
    Stimuli_sets(nickel) = Preparestimuli(Parameters,stimstruct);
    
    nickel_diam = 375;
    
    %Golden Nickel Border
    gnb = 1000;
    stimstruct = CreateStimStruct('shape');
    stimstruct.stimuli = {'FrameOval'};
    stimstruct.xdim = nickel_diam-3;
    stimstruct.ydim = nickel_diam;
    stimstruct.color = [255 255 0];
    Stimuli_sets(gnb) = Preparestimuli(Parameters,stimstruct);
    
    %No reward
    no_win = 599;
    stimstruct = CreateStimStruct('image');
    stimstruct.stimuli = {'nowinnickel.png'};
    stimstruct.stimsize = 1;
    Stimuli_sets(no_win) = Preparestimuli(Parameters,stimstruct);
    
    %Red Nickel Border
    rnb = 1001;
    stimstruct = CreateStimStruct('shape');
    stimstruct.stimuli = {'FrameOval'};
    stimstruct.xdim = nickel_diam-3;
    stimstruct.ydim = nickel_diam;
    stimstruct.color = [255 0 0];
    Stimuli_sets(rnb) = Preparestimuli(Parameters,stimstruct);
    
    %% Instructions & Other Text
    
    %Fixation Cross & Questions
    stimstruct = CreateStimStruct('text');
    stimstruct.wrapat = 0;
    stimstruct.stimuli = {'+','Click anywhere on the points wheel to try to score a nickel.'};
    stimstruct.stimsize = 20;
    Stimuli_sets(30) = Preparestimuli(Parameters,stimstruct);
    
    %Instructions (before practice trials)
    ins = 31;
    stimstruct = CreateStimStruct('text');
    stimstruct.stimuli = {'You and the computer will be playing a game together.','The goal of the game is to win as many nickels as possible,','which will be exchanged for actual money at the end of the game.' ...
        'During each trial, you will see a blue, segmented wheel.','Your task is to find the segment on the wheel that awards nickels most frequently.','After clicking on a segment, you will see whether' ...
        'you gained a nickel (indicated with the color yellow) or not (red).','To help you get an idea of how the game works,','we''ve provided a training section to complete before you begin.','Press Spacebar to continue to training.', ...
        'In this section, the points wheel will be hidden,','meaning you''ll have to pay closer attention!','Press Spacebar to continue.' ... %11-13
        'Great job so far!','The number of segments has increased to 8.' ... %14-15
        'One more training phase to complete.','The scoring wheel is back!' ... %16-17
        'Training complete!','Now loading the main experiment...'}; %18-19
    stimstruct.stimsize = 20;
    stimstruct.vSpacing = 5;
    Stimuli_sets(ins) = Preparestimuli(Parameters,stimstruct);
    
    %Bot button text
    bot_but_text = 1110; %click here
    stimstruct = CreateStimStruct('text');
    stimstruct.stimuli = {'Click the blue','segment to continue'};
    stimstruct.stimsize = 22;
    Stimuli_sets(bot_but_text) = Preparestimuli(Parameters,stimstruct);
    
    %Click instructions
    sub_but_text = 1111;
    stimstruct = CreateStimStruct('text');
    stimstruct.stimuli = {'Click any blue','segment to see if you win'};
    stimstruct.stimsize = 22;
    Stimuli_sets(sub_but_text) = Preparestimuli(Parameters,stimstruct);
    
    %Whose turn
    whose_turn = 1112; %turn
    stimstruct = CreateStimStruct('text');
    stimstruct.stimuli = {'Computer''s turn!','Your Turn!'};
    stimstruct.stimsize = 52;
    Stimuli_sets(whose_turn) = Preparestimuli(Parameters,stimstruct);
    
    %Accuracy Feedback
    reward = 300;
    stimstruct = CreateStimStruct('text');
    stimstruct.wrapat = 0;
    stimstruct.stimuli = {'Congrats! You won a nickel!', 'Sorry, no nickel this time.','Congrats! You won another nickel!','Total: '};
    stimstruct.stimsize = 30;
    stimstruct.vSpacing = 5;
    Stimuli_sets(reward) = Preparestimuli(Parameters,stimstruct);
    
    %% Set up wheel blocks & chop up probabilities into quadrants
    
    %Base blocks of the wheel
    setupwheelblocks;
    
    if even_uneven < 3
        probs = [min_prob:((max_prob-min_prob)/(num_segments-1)):max_prob];
    else %gold mine
        probs = [0.4 0.4 0.4 0.75];
    end
    
    try
        probs = Shuffle(probs);
    catch
        probs = shuffle(probs);
    end
    
    try
        prob_count = 1;
        for i = 1:360
            if ~mod(i,(360/length(probs))) && i < 360
                prob_count = prob_count + 1;
            end
            wheel_probs(i) = probs(prob_count);
        end
    catch
        sca;keyboard
    end
    score = 0;
    
    bot_mode = 1
    bot_choice_count = 0;
    ready_for_score = 0;
    save('workspace');
elseif strcmp(Modeflag,'InitializeTrial')
    %% Set up other experiment parameters
    if Trial == 1;     load('workspace'); end
    if Trial == 0; Trial = 1; end
    Trial
    instruction_display_time = 0;
    if Trial == 1
        seg_wheel_time = instruction_display_time + .01;
    end
    
    if Trial > 3
        string_trial = num2str(Trial-2);
    else
        string_trial = num2str(Trial);
    end
    
    change_trial = num_segments+1;
    change_trial2 = 126; change_trial3 = 188 - 1;
    
    if Trial == change_trial
        bot_mode = 0
    end
    
    section_tcount = num_segments;
    
    num_choices = num_segments;
    c_rows = round(section_tcount+1/num_choices);
    if Trial == 1
        bot_choices = 0;
        for crow = 1:c_rows
            if crow == 1
                if even_uneven == 1
                    bot_choices(end:end+num_choices-1) = randperm(num_choices);
                else
                    bot_choices(end:end+num_choices-1) = randi(num_choices,1,num_choices);
                end
            else
                if even_uneven == 1
                    bot_choices(end+1:end+num_choices) = randperm(num_choices);
                else
                    bot_choices(end+1:end+num_choices) = randi(num_choices,1,num_choices);
                end
            end
        end
    end
    
    if Trial == change_trial || Trial == change_trial3
        bot_choice_count = 0;
        bot_choices = 0;
        bot_choices = 0;
        for crow = 1:c_rows
            if crow == 1
                bot_choices(end:end+num_choices-1) = randperm(num_choices);
            else
                bot_choices(end+1:end+num_choices) = randperm(num_choices);
            end
        end
    end
    
    if turn_bot_off
        bot_mode = 0
    end
    
    if bot_mode
        num_pos_bot_seg_choices = num_choices;
    end
    
    %Find bot's current choice
    try
        bot_choice_count = bot_choice_count + 1;
        click_choice = bot_choices(bot_choice_count);
    catch
        sca;keyboard;
    end
    bot_click_zone = seg_values(seg_rows(click_choice),:);
    med_zone = round(median(bot_click_zone));
    if num_segments == 4
        med_off = 40;
    else
        med_off = 18;
    end
    
    bot_click_zone = med_zone-med_off:med_zone+med_off;
    
    if bot_mode && ~turn_bot_off
        segment_response = seg_values(seg_rows(click_choice),12);
        selected_prob = click_choice;
    end
    
    %Center coordinates
    locx = Parameters.centerx;
    locy = Parameters.centery;
    
    %Mouse appears
    Events = newevent_mouse_cursor(Events,instruction_display_time,locx,locy,0);
    
    %Mouse Parameters
    mouseresponse_seg = CreateResponseStruct;
    
    %Responsestruct
    responsestruct = CreateResponseStruct;
    responsestruct.x = locx;
    responsestruct.y = locy;
    if Trial == 1
    else
        %Wheel borders
        Events = newevent_show_stimulus(Events,cwb1,1,locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,cwb2,1,locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,cwb2+1,1,locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,pwb1,1,locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,pwb2,1,locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,pwb2+1,1,locx,locy,instruction_display_time,'screenshot_no','clear_no');
    end
    clickwheeltime = instruction_display_time;
    
    if ~bot_mode & Trial ~= change_trial2-1
        full_wheel = 1;
    else
        full_wheel = 0;
    end
    
    if Trial == 1
    else
        %Loads segmented wheel
        loadclickablewheel;
    end
    
    if Trial == change_trial2
        scorecolormatrix = repmat(scorewheelcolor,num_wheel_boxes,3);
        for add_partition = 1:num_segments
            if add_partition == num_segments
                scorecolormatrix(359,:) = [0 0 0];
            else
                scorecolormatrix(change_spot(add_partition)-1,:) = [0 0 0];
            end
        end
        csvwrite('scorecolormatrix',scorecolormatrix);
        scorecolormatrix2 = scorecolormatrix;
        scorecolormatrix3 = scorecolormatrix;
        scorecolormatrix4 = scorecolormatrix;
        csvwrite('scorecolormatrix2',scorecolormatrix2);
        csvwrite('scorecolormatrix3',scorecolormatrix3);
        csvwrite('scorecolormatrix4',scorecolormatrix4);
    end
    
    %Loads points wheel
    points_time = instruction_display_time;
    if Trial == 1
    else
        if Trial ~= change_trial2
            loadpointswheel2;
        else
            loadblankwheel;
        end
    end
    if Trial == 1; segment_score = zeros(num_segments,2); end
    %% Instruction Display (before practice trials) %%
    if Trial == 1 && Blocknum == 1
        if ~test_mode
            Events = newevent_mouse_cursor(Events,0,locx,locy,0);
            Events = newevent_show_stimulus(Events,ins,1,locx,locy-315,instruction_display_time,'screenshot_no','clear_yes');
            Events = newevent_show_stimulus(Events,ins,2,locx,locy-245,instruction_display_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,ins,3,locx,locy-175,instruction_display_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,ins,4,locx,locy-105,instruction_display_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,ins,5,locx,locy-35,instruction_display_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,ins,6,locx,locy+35,instruction_display_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,ins,7,locx,locy+105,instruction_display_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,ins,8,locx,locy+175,instruction_display_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,ins,9,locx,locy+245,instruction_display_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,ins,10,locx,locy+315,instruction_display_time,'screenshot_no','clear_no');
            responsestruct.allowedchars = KbName('Space');
            if ~speed_test
                Events = newevent_keyboard(Events,instruction_display_time,responsestruct);
            end
            seg_wheel_time = instruction_display_time + .01;
            points_time = seg_wheel_time;
            clickwheeltime = points_time;
            reward_time = seg_wheel_time + .01;
            trial_end_time = reward_time + 2;
            clear_screen = 'clear_yes';
        end
        segment_score = zeros(num_segments,2);
    elseif Trial == 1 && Blocknum == 2
        Events = newevent_show_stimulus(Events,ins,11,locx,locy-75,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,ins,12,locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,ins,13,locx,locy+75,instruction_display_time,'screenshot_no','clear_no');
        responsestruct.allowedchars = KbName('Space');
        if ~speed_test
            Events = newevent_keyboard(Events,instruction_display_time,responsestruct);
        end
        seg_wheel_time = instruction_display_time + .01;
        points_time = seg_wheel_time;
        clickwheeltime = points_time;
        reward_time = seg_wheel_time + .01;
        clear_screen = 'clear_yes';
    elseif Trial == 1 && Blocknum == 3
        Events = newevent_show_stimulus(Events,ins,14,locx,locy-75,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,ins,15,locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,ins,13,locx,locy+75,instruction_display_time,'screenshot_no','clear_no');
        responsestruct.allowedchars = KbName('Space');
        if ~speed_test
            Events = newevent_keyboard(Events,instruction_display_time,responsestruct);
        end
        seg_wheel_time = instruction_display_time + .01;
        points_time = seg_wheel_time;
        clickwheeltime = points_time;
        reward_time = seg_wheel_time + .01;
        clear_screen = 'clear_yes';
    elseif Trial == 1 && Blocknum == 4
        Events = newevent_show_stimulus(Events,ins,16,locx,locy-75,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,ins,17,locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,ins,13,locx,locy+75,instruction_display_time,'screenshot_no','clear_no');
        responsestruct.allowedchars = KbName('Space');
        if ~speed_test
            Events = newevent_keyboard(Events,instruction_display_time,responsestruct);
        end
        seg_wheel_time = instruction_display_time + .01;
        points_time = seg_wheel_time;
        clickwheeltime = points_time;
        reward_time = seg_wheel_time + .01;
        clear_screen = 'clear_yes';
    end
    
    %% If bot mode, wait for segment click before continuing
    if bot_mode && ~turn_bot_off
        if Trial > 1
            seg_wheel_time = instruction_display_time;
            clear_screen = 'clear_no';
        end
        if bot_mode
            %Show cursor
            Events = newevent_mouse_cursor(Events,seg_wheel_time,locx,locy,0);
            %Mouse Parameters
            bot_response = CreateResponseStruct;
            %Text
            Events = newevent_show_stimulus(Events,whose_turn,1,locx,locy-400,seg_wheel_time,'screenshot_no',clear_screen);
            if Trial == 1
                loadclickablewheel;
                loadpointswheel2;
                %Wheel borders
                Events = newevent_show_stimulus(Events,pwb1,1,locx,locy,seg_wheel_time,'screenshot_no','clear_no');
                Events = newevent_show_stimulus(Events,pwb2+1,1,locx,locy,seg_wheel_time,'screenshot_no','clear_no');
            end
            if toggle_botbutton
                %Bot Button
                Events = newevent_show_stimulus(Events,bot_but,1,locx,locy,seg_wheel_time,'screenshot_no','clear_no');
                Events = newevent_show_stimulus(Events,bot_but_frame,1,locx,locy,seg_wheel_time,'screenshot_no','clear_no');
                %Bot Button Text
                Events = newevent_show_stimulus(Events,bot_but_text,1,locx,locy-25,seg_wheel_time,'screenshot_no','clear_no');
                Events = newevent_show_stimulus(Events,bot_but_text,2,locx,locy+25,seg_wheel_time,'screenshot_no','clear_no');
                %Mouse Click Windows
                bot_buttonlocs{1}=[locx,locy,200];
                bot_response.spatialwindows = bot_buttonlocs;
                if ~test_mode & ~speed_test
                    [Events bot_button_click] = newevent_mouse(Events,seg_wheel_time,bot_response);
                end
            else
                %Bot Instructions
                Events = newevent_show_stimulus(Events,bot_but_text,1,locx,locy-25,seg_wheel_time,'screenshot_no','clear_no');
                Events = newevent_show_stimulus(Events,bot_but_text,2,locx,locy+25,seg_wheel_time,'screenshot_no','clear_no');
            end
        end
        
        %Mouse appears
        Events = newevent_mouse_cursor(Events,seg_wheel_time,locx,locy,Parameters.mouse.cursorsize);
        
        %Mouse Click Windows
        for i = 1:length(bot_click_zone)
            try
                pos_buttonlocs{i} = [locationWheelLocations(1,bot_click_zone(i)),locationWheelLocations(2,bot_click_zone(i)),25];
            catch
                sca;keyboard
            end
        end
        mouseresponse_seg.spatialwindows = pos_buttonlocs;
        if ~speed_test
            [Events] = newevent_mouse(Events,seg_wheel_time,mouseresponse_seg);
        end
    end
    
    %% Feedback %%
    if (Trial ~= change_trial && Trial ~= change_trial3) || bot_mode
        HideCursor;
        if Trial == 1
            seg_wheel_time = reward_time + 2;
        elseif Trial == 2
            seg_wheel_time = reward_time + 1.5;
        else
            seg_wheel_time = reward_time + 1;
        end
        
        if speed_test
            seg_wheel_time = reward_time + .01;
        end
        
        y_offset = 100;
        rewardtext_locy = locy - 400;
        nickel_locy = locy - 100;
        
        %Find prob of click space
        selected_prob = wheel_probs(segment_response);
        
        %Find selected segment of the wheel
        show_selected_segment;
        
        win = 0; add = 0;
        
        chance = rand(1);
        if chance <= selected_prob
            win = 1;
            
            %Calculate segment score
            segment_score(selected_row,1) = segment_score(selected_row,1) + 1;
            segment_score(selected_row,2) = segment_score(selected_row,2) + 1;
            score = score + 1;
            if show_points
                [add] = show_score(segment_score,add,scorecolormatrix,scorecolormatrix2,win,seg_values,segment_response,change_spot,Trial,num_wheel_boxes,num_segments,change_trial2);
            end
            
            %Wheel borders
            Events = newevent_show_stimulus(Events,cwb1,1,locx,locy,reward_time,'screenshot_no','clear_yes');
            Events = newevent_show_stimulus(Events,cwb2,1,locx,locy,reward_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,cwb2+1,1,locx,locy,reward_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,pwb1,1,locx,locy,reward_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,pwb2,1,locx,locy,reward_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,pwb2+1,1,locx,locy,reward_time,'screenshot_no','clear_no');
            
            %Loads segmented wheel
            clickwheeltime = reward_time;
            full_wheel = 0;
            loadclickablewheel;
            
            if score < 2
                Events = newevent_show_stimulus(Events,reward,1,locx,rewardtext_locy+y_offset-100,reward_time,'screenshot_no','clear_no'); %"you won a nickel!'
            else
                Events = newevent_show_stimulus(Events,reward,3,locx,rewardtext_locy+y_offset-100,reward_time,'screenshot_no','clear_no'); %"you won ANOTHER nickel!"
            end
            
            %Loads points wheel
            points_time = reward_time;
            loadpointswheel;
            
            %Nickel
            Events = newevent_show_stimulus(Events,nickel,1,locx,nickel_locy+y_offset,reward_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,gnb,1,locx,nickel_locy+y_offset+3,reward_time,'screenshot_no','clear_no');
            
        else %Didn't win a nickel :'(
            
            %Calculate segment score
            segment_score(selected_row,2) = segment_score(selected_row,2) + 1;
            scorecolormatrix=csvread('scorecolormatrix.csv');
            if show_points
                [add] = show_score(segment_score,add,scorecolormatrix,scorecolormatrix2,win,seg_values,segment_response,change_spot,Trial,num_wheel_boxes,num_segments,change_trial2);
            end
            
            %Wheel borders
            Events = newevent_show_stimulus(Events,cwb1,1,locx,locy,reward_time,'screenshot_no','clear_yes');
            Events = newevent_show_stimulus(Events,cwb2,1,locx,locy,reward_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,cwb2+1,1,locx,locy,reward_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,pwb1,1,locx,locy,reward_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,pwb2,1,locx,locy,reward_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,pwb2+1,1,locx,locy,reward_time,'screenshot_no','clear_no');
            
            %Loads segmented wheel
            clickwheeltime = reward_time;
            full_wheel = 0;
            loadclickablewheel;
            
            %Loads points wheel
            points_time = reward_time;
            loadpointswheel
            
            %"No reward" test
            Events = newevent_show_stimulus(Events,reward,2,locx,rewardtext_locy+y_offset-100,reward_time,'screenshot_no','clear_no');
            
            %Crossed out nickel
            Events = newevent_show_stimulus(Events,no_win,1,locx,nickel_locy+y_offset,reward_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,rnb,1,locx,nickel_locy+y_offset+3,reward_time,'screenshot_no','clear_no');
            
        end
    end
    
    %% Pariticipant response display %%
    
    if Trial < Numtrials
        
        if ~bot_mode
            
            %Mouse appears
            Events = newevent_mouse_cursor(Events,seg_wheel_time,locx,locy,Parameters.mouse.cursorsize);
            
            %Wheel borders
            Events = newevent_show_stimulus(Events,cwb1,1,locx,locy,seg_wheel_time,'screenshot_no','clear_yes');
            Events = newevent_show_stimulus(Events,cwb2,1,locx,locy,seg_wheel_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,cwb2+1,1,locx,locy,seg_wheel_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,pwb1,1,locx,locy,seg_wheel_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,pwb2,1,locx,locy,seg_wheel_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,pwb2+1,1,locx,locy,seg_wheel_time,'screenshot_no','clear_no');
            
            %Loads segmented wheel
            clickwheeltime = seg_wheel_time;
            
            full_wheel = 1;
            
            loadclickablewheel;
            
            if Trial == change_trial2
                scorecolormatrix = repmat(scorewheelcolor,num_wheel_boxes,3);
                for add_partition = 1:num_segments
                    if add_partition == num_segments
                        scorecolormatrix(359,:) = [0 0 0];
                    else
                        scorecolormatrix(change_spot(add_partition)-1,:) = [0 0 0];
                    end
                end
                csvwrite('scorecolormatrix',scorecolormatrix);
                scorecolormatrix2 = scorecolormatrix;
                scorecolormatrix3 = scorecolormatrix;
                scorecolormatrix4 = scorecolormatrix;
                csvwrite('scorecolormatrix2',scorecolormatrix2);
                csvwrite('scorecolormatrix3',scorecolormatrix3);
                csvwrite('scorecolormatrix4',scorecolormatrix4);
            end
            
            points_time = seg_wheel_time;
            loadpointswheel;
            
            if ~toggle_botbutton && Trial ~= change_trial2-1
                %Mouse Click Windows
                mouseresponse_seg.spatialwindows = buttonlocs;
                if ~speed_test
                    [Events,segment_response] = newevent_mouse(Events,seg_wheel_time,mouseresponse_seg);
                end
                Events = newevent_show_stimulus(Events,whose_turn,2,locx,locy-400,seg_wheel_time,'screenshot_no','clear_no'); %your turn!
                %Click Instructions
                Events = newevent_show_stimulus(Events,sub_but_text,1,locx,locy-25,seg_wheel_time,'screenshot_no','clear_no');
                Events = newevent_show_stimulus(Events,sub_but_text,2,locx,locy+25,seg_wheel_time,'screenshot_no','clear_no');
            end
            trial_end_time = seg_wheel_time + .001; %when the trial ends
        else
            trial_end_time = reward_time + total_feedback_time; %when the trial ends
        end
    elseif Trial == Numtrials && Blocknum < num_blocks
        trial_end_time = total_feedback_time;
    else
        token_win_time = total_feedback_time + .01;
        command = 'money_count = csvread(''money_count.csv'');';
        Events = newevent_command(Events,token_win_time,command,'clear_no');
        command = 'DrawFormattedText(Parameters.window,sprintf(''You won $%s from this experiment! Congrats!'',num2str(round(money_count*.1,2))),''center'',''center'',[0 0 0]);';
        Events = newevent_command(Events,token_win_time,command,'clear_yes');
        trial_end_time = token_win_time + 3;
    end
    
    if Trial == Numtrials && Blocknum == length(Demodata.practice_struct)
        Events = newevent_show_stimulus(Events,ins,18,locx,locy-50,trial_end_time,'screenshot_no','clear_yes');
        Events = newevent_show_stimulus(Events,ins,19,locx,locy,trial_end_time,'screenshot_no','clear_no');
        trial_end_time2 = trial_end_time + 5;
        Events = newevent_end_trial(Events,trial_end_time2);
    else
        %% Ends trial
        Events = newevent_end_trial(Events,trial_end_time);
    end
    save('workspace2');
elseif strcmp(Modeflag,'EndTrial')
    load('workspace2');
    %% Record output data in structure & save in .MAT file
    seg_rows=csvread('seg_rows.csv');
    money_now_won = sum(segment_score(:,1))*0.05;
    if Blocknum > 1
        money_already_won = csvread('money_count.csv');
    else
        money_already_won = 0;
    end
    money_count = money_now_won + money_already_won;
    if Trial < Numtrials
        if ~bot_mode || turn_bot_off
            if speed_test
                segment_response = randi(360)
            else
                segment_response = (Events.windowclicked{segment_response})
                if segment_response > 358 && num_segments == 4
                    segment_response = 1;
                end
            end
        end
    end
elseif strcmp(Modeflag,'EndBlock')
else
    %Something went wrong in Runblock (You should never see this error)
    error('Invalid modeflag');
end
saveblockspace
end