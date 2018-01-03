function [Events Parameters Stimuli_sets Block_Export Trial_Export  Numtrials]=Demo(Parameters, Stimuli_sets, Trial, Blocknum, Modeflag, ...
    Events,Block_Export,Trial_Export,Demodata)
clear Stimuli_sets
load('blockvars')

                                            %Paradigm coded by Michael R Hess, October '15


                                        %Experiment is adjusted for a screen resolution of 1024x768


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                        %Trial Parameters%
                        
    
    %CHANGEHERE% %Number of practice trials
    practice_trials = 4;
    
    %CHANGEHERE% %Number of pre-surprise trials (excludes practice trials)
    pre_surprise_trials = 40;
    
    %Trial number of the surprise trial (set to after pre-surprise trials)
    surprise_trial_number = pre_surprise_trials + 1
    
    %CHANGEHERE% %Number of post-surprise trials
    post_surprise_trials = 80;
    
    %Total number of trials
    Numtrials = practice_trials + surprise_trial_number + post_surprise_trials;
    
    
                      %Timing Parameters% (Not all. For the rest, scroll down to "The Experiment Display" section.)
                        
    
    %When the instructions will be displayed from the start of the experiment (Trial 1)
    instruction_display_time = 0;
    
    if Trial == 1
    %CHANGEHERE% %When the fixation cross will appear (after pressing a key on the instructions)
    fixation_onset_time = instruction_display_time + .01; 
    else
        fixation_onset_time = instruction_display_time + 1;
    end
    
    %CHANGEHERE% %When a colored square will be displayed (after fixation)
    disp_time = fixation_onset_time + 1 + rand * .5;
    
    %When the colored square is masked
    masking_time = disp_time + .2;
    
    %CHANGEHERE% %How long the colored square is displayed
    study_time = .5; 
    
    if Trial >= practice_trials
        %CHANGEHERE% %When the screen will blank on practice trials after a square is displayed (retention)
        trial_blank_time = masking_time + study_time * 2; 
    else
        %When the screen will blank on non-practice trials after a square is displayed (retention)
        trial_blank_time = masking_time + study_time; 
    end
    
    %CHANGEHERE% %When the color wheel and color question will appear on pre-surprise trials (after retention)
    color_wheel_time = trial_blank_time + 1; 
    
    %CHANGEHERE% %When participants are asked if they saw a line on surprise & post-surprise trials (after retention)
    see_line_question_time = color_wheel_time + .5;
    
    %CHANGEHERE% %When particpants are asked what the surprise object was or its color
    object_question_time = see_line_question_time + .01;
    
    %CHANGEHERE% %When participants are asked the location of the line on surprise & post-surprise trials (after being asked if they saw the line)
    location_question_time = object_question_time + .01; 
    
    %CHANGEHERE% %When participants are asked the angle of the line (after blank screen buffer)
    angle_question_time = location_question_time + .02;
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
    


%Enables mouse
Parameters.mouse.enabled = 1;

%Color Wheel 1 (Outer)
colorWheelRadius = 260; %radius of color wheel
%Cartesian Conversion
colorWheelLocations1 = [cosd(1:360).*colorWheelRadius + Parameters.centerx; ...
    sind(1:360).*colorWheelRadius + Parameters.centery];

%Color Wheel 2 (Inner)
colorWheelRadius = 252; %radius of color wheel
%Cartesian Conversion
colorWheelLocations2 = [cosd(1:360).*colorWheelRadius + Parameters.centerx; ...
    sind(1:360).*colorWheelRadius + Parameters.centery];

%Location Wheel
locationWheelRadius = 258; %radius of color wheel
%Cartesian Conversion
locationWheelLocations = [cosd(1:360).*locationWheelRadius + Parameters.centerx; ...
    sind(1:360).*locationWheelRadius + Parameters.centery];

%Used for mouse clicks on color wheel
for i = 1:360
    buttonlocs{i} = [locationWheelLocations(1,i),locationWheelLocations(2,i),12];
end

save('colorWheelLocations1','colorWheelLocations1');
save('colorWheelLocations2','colorWheelLocations2');

if strcmp(Modeflag,'InitializeBlock');
    locx = Parameters.centerx;
    locy = Parameters.centery;
    
    %Shape Structs & Instructions
    for folded_shape_structs = 1:1
        linelength = 150;
        %Lines (at various angles)
        stimstruct = CreateStimStruct('shape');
        
        stimstruct.stimuli = {'DrawLine','DrawLine','DrawLine','DrawLine','DrawLine','DrawLine','DrawLine','DrawLine'};
        stimstruct.linelength = [linelength,linelength,linelength,linelength,linelength,linelength,linelength,linelength];
        stimstruct.linewidth = 8;
        stimstruct.lineangle = [0,25,50,75,100,125,150,175];
        stimstruct.color = [0,0,0,0,0,0,0,0];
        Stimuli_sets(1) = Preparestimuli(Parameters,stimstruct);
        
        %Smaller Lines (at various angles)[for angle question]
        stimstruct = CreateStimStruct('shape');
        stimstruct.stimuli = {'DrawLine','DrawLine','DrawLine','DrawLine','DrawLine','DrawLine','DrawLine','DrawLine'};
        stimstruct.linelength = [75,75,75,75,75,75,75,75];
        stimstruct.linewidth = [5,5,5,5,5,5,5,5];
        stimstruct.lineangle = [0,25,50,75,100,125,150,175];
        stimstruct.color = [0,0,0,0,0,0,0,0];
        Stimuli_sets(2) = Preparestimuli(Parameters,stimstruct);
        
        %Fixation Cross & Questions
        stimstruct = CreateStimStruct('text');
        stimstruct.stimuli = {'+','What color was the square?', 'Did you notice anything unusual','about that trial compared to the others?'};
        stimstruct.stimsize = 25;
        stimstruct.wrapat = 0;
        Stimuli_sets(30) = Preparestimuli(Parameters,stimstruct);
        
        %Instructions (before practice trials)
        stimstruct = CreateStimStruct('text');
        stimstruct.stimuli = {'Good work! Now onto the first part of the experiment.','Once the experiment begins, keep your chin rested on the chin rest and stare at','the fixation cross in the center of the screen.','A colored square will appear. You will then be asked to report','the color of the square using a color wheel.','You will first complete 4 practice trials.','Press any key to start the practice trials.'};
        stimstruct.stimsize = 17;
        stimstruct.wrapat = 70;
        stimstruct.vSpacing = 5;
        stimstruct.wrapat = 0;
        Stimuli_sets(31) = Preparestimuli(Parameters,stimstruct);
        
        %Instructions (before regular trials)
        stimstruct = CreateStimStruct('text');
        stimstruct.stimuli = {'That was the end of the practice trials.','The experiment will now begin.','Press any key to continue.'};
        stimstruct.stimsize = 25;
        stimstruct.vSpacing = 5;
        stimstruct.wrapat = 0;
        Stimuli_sets(32) = Preparestimuli(Parameters,stimstruct);
        
        %Ask about line angle
        stimstruct = CreateStimStruct('text');
        stimstruct.stimuli = {'Which line angle did you see?','If you had to guess the angle..'};
        stimstruct.stimsize = 30;
        stimstruct.vSpacing = 5;
        stimstruct.wrapat = 0;
        Stimuli_sets(33) = Preparestimuli(Parameters,stimstruct);
        
        %Line Location Selection Squares
        stimstruct = CreateStimStruct('shape');
        stimstruct.stimuli = {'FrameRect'};
        stimstruct.xdim = 400;
        stimstruct.ydim = 300;
        stimstruct.color = [0,0,0];
        Stimuli_sets(34) = Preparestimuli(Parameters,stimstruct);
        
        %Ask about line location
        stimstruct = CreateStimStruct('text');
        stimstruct.stimuli = {'A line was shown. Click where you saw it.','Click where you think it may have appeared.'};
        stimstruct.stimsize = 30;
        stimstruct.vSpacing = 5;
        stimstruct.wrapat = 0;
        Stimuli_sets(35) = Preparestimuli(Parameters,stimstruct);
        
        %Ask what object they saw
        stimstruct = CreateStimStruct('text');
        stimstruct.stimuli = {'What was unusual about that trial?','A line was flashed in one of the corners. Type what color you think it was.'};
        stimstruct.stimsize = 23;
        stimstruct.vSpacing = 5;
        stimstruct.wrapat = 0;
        Stimuli_sets(44) = Preparestimuli(Parameters,stimstruct);
 
        %Feedback
        stimstruct = CreateStimStruct('text');
        stimstruct.stimuli = {'No line was displayed.','Displayed Color','Color You Chose'};
        stimstruct.stimsize = 30;
        stimstruct.vSpacing = 5;
        stimstruct.wrapat = 0;
        Stimuli_sets(36) = Preparestimuli(Parameters,stimstruct);
        
        %Arrow Key Images
        stimstruct = CreateStimStruct('image');
        stimstruct.stimuli = {'YES.png';'NO.png'}; %yes or no
        stimstruct.stimsize = [1,1,1,1,1,1,1,1];
        Stimuli_sets(40) = Preparestimuli(Parameters,stimstruct);
    end
    
    %Accuracy Feedback
    stimstruct = CreateStimStruct('text');
    stimstruct.stimuli = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59','60','61','62','63','64','65','66','67','68','69','70','71','72','73','74','75','76','77','78','79','80','81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98','99','100'};
    stimstruct.stimsize = 30;
    stimstruct.vSpacing = 5;
    stimstruct.wrapat = 0;
    Stimuli_sets(41) = Preparestimuli(Parameters,stimstruct);
    
    %Accuracy Feedback
    stimstruct = CreateStimStruct('text');
    stimstruct.stimuli = {'Your color selection was', '%', 'accurate.'};
    stimstruct.stimsize = 30;
    stimstruct.vSpacing = 5;
    stimstruct.wrapat = 0;
    Stimuli_sets(42) = Preparestimuli(Parameters,stimstruct);
    
    %Location (Post-Surprise)
    stimstruct = CreateStimStruct('text');
    stimstruct.stimuli = {'Click where you saw the line', 'A line was shown, if you had to quess where it was..'};
    stimstruct.stimsize = 25;
    stimstruct.vSpacing = 5;
    stimstruct.wrapat = 0;
    Stimuli_sets(45) = Preparestimuli(Parameters,stimstruct);
    
    %Location (Post-Surprise)
    stimstruct = CreateStimStruct('text');
    stimstruct.stimuli = {'What angle was the line?', 'If you had to guess the angle of the line..'};
    stimstruct.stimsize = 30;
    stimstruct.vSpacing = 5;
    stimstruct.wrapat = 0;
    Stimuli_sets(46) = Preparestimuli(Parameters,stimstruct);    
    
    mask_square = 75;
    mask_rectanglex = mask_square + 50;
    mask_rectangley = mask_square + 50;
    
    colorz = shuffle([255,0,0 %red
        0, 0, 255 %dark blue
        0, 255, 255 %cyan
        255, 106, 0 %orange
        255, 216, 0 %yellow
         182, 255, 0 %light green
        0, 255, 144 %turquoise
         0, 148, 255 %blue
        178, 0, 255 %purple
        255, 0, 220 %violet
         255, 0, 110 %pink
         200,200,200 %silver
        ]);
    
    %Masking Squares
    stimstruct = CreateStimStruct('shape');
    stimstruct.stimuli = {'FillRect','FillRect','FillRect','FillRect','FillRect','FillRect','FillRect','FillRect','FillRect','FillRect','FillRect','FillRect'};
    stimstruct.xdim = [mask_rectanglex,mask_square,mask_rectanglex,mask_square,mask_rectanglex,mask_square,mask_square,mask_square,mask_square,mask_square,mask_square,mask_square];
    stimstruct.ydim = [mask_square,mask_rectangley,mask_square,mask_rectangley,mask_square,mask_rectangley,mask_square,mask_square,mask_square,mask_square,mask_square,mask_square];
    stimstruct.color = colorz;
    Stimuli_sets(43) = Preparestimuli(Parameters,stimstruct);
    
    %Color Wheel Dots (aka the cluster fudge of space-taking code)
    for  stimstruct = CreateStimStruct('shape');
        stimstruct.stimuli = {'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';
            'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FillRect';'FrameRect'};
        stimstruct.color = [  246.0000   37.0000  111.0000;
            246.0000   37.0000  110.0000;
            246.0000   37.0000  109.0000;
            246.0000   37.0000  107.5000;
            246.0000   37.0000  106.0000;
            246.0000   37.0000  104.5000;
            246.0000   37.0000  103.0000;
            246.0000   37.5000  102.0000;
            246.0000   38.0000  101.0000;
            246.0000   38.5000   99.5000;
            246.0000   39.0000   98.0000;
            246.0000   39.5000   96.5000;
            246.0000   40.0000   95.0000;
            246.0000   41.0000   94.0000;
            246.0000   42.0000   93.0000;
            245.5000   42.5000   91.5000;
            245.0000   43.0000   90.0000;
            245.0000   44.0000   89.0000;
            245.0000   45.0000   88.0000;
            245.0000   46.0000   86.5000;
            245.0000   47.0000   85.0000;
            244.5000   47.5000   84.0000;
            244.0000   48.0000   83.0000;
            243.5000   49.0000   81.5000;
            243.0000   50.0000   80.0000;
            242.5000   51.0000   79.0000;
            242.0000   52.0000   78.0000;
            242.0000   53.0000   76.5000;
            242.0000   54.0000   75.0000;
            241.5000   55.5000   74.0000;
            241.0000   57.0000   73.0000;
            240.5000   58.0000   71.5000;
            240.0000   59.0000   70.0000;
            239.0000   60.0000   69.0000;
            238.0000   61.0000   68.0000;
            237.5000   62.0000   66.5000;
            237.0000   63.0000   65.0000;
            236.5000   64.0000   64.0000;
            236.0000   65.0000   63.0000;
            235.5000   66.0000   62.0000;
            235.0000   67.0000   61.0000;
            234.0000   68.5000   60.0000;
            233.0000   70.0000   59.0000;
            232.5000   71.0000   57.5000;
            232.0000   72.0000   56.0000;
            231.0000   73.0000   55.0000;
            230.0000   74.0000   54.0000;
            229.0000   75.0000   53.0000;
            228.0000   76.0000   52.0000;
            227.5000   77.0000   51.0000;
            227.0000   78.0000   50.0000;
            226.0000   79.0000   49.0000;
            225.0000   80.0000   48.0000;
            224.0000   81.0000   46.5000;
            223.0000   82.0000   45.0000;
            222.0000   83.0000   44.0000;
            221.0000   84.0000   43.0000;
            220.0000   85.0000   42.0000;
            219.0000   86.0000   41.0000;
            218.0000   87.0000   40.0000;
            217.0000   88.0000   39.0000;
            216.0000   89.0000   38.0000;
            215.0000   90.0000   37.0000;
            214.0000   91.0000   36.5000;
            213.0000   92.0000   36.0000;
            212.0000   93.0000   35.0000;
            211.0000   94.0000   34.0000;
            210.0000   95.0000   33.0000;
            209.0000   96.0000   32.0000;
            208.0000   97.0000   31.0000;
            207.0000   98.0000   30.0000;
            205.5000   98.5000   29.5000;
            204.0000   99.0000   29.0000;
            203.0000  100.0000   28.0000;
            202.0000  101.0000   27.0000;
            201.0000  102.0000   26.5000;
            200.0000  103.0000   26.0000;
            198.5000  103.5000   25.0000;
            197.0000  104.0000   24.0000;
            196.0000  105.0000   23.5000;
            195.0000  106.0000   23.0000;
            194.0000  107.0000   22.5000;
            193.0000  108.0000   22.0000;
            191.5000  108.5000   21.5000;
            190.0000  109.0000   21.0000;
            189.0000  110.0000   20.5000;
            188.0000  111.0000   20.0000;
            186.5000  111.5000   19.5000;
            185.0000  112.0000   19.0000;
            183.5000  113.0000   19.0000;
            182.0000  114.0000   19.0000;
            181.0000  114.5000   19.0000;
            180.0000  115.0000   19.0000;
            178.5000  115.5000   19.0000;
            177.0000  116.0000   19.0000;
            176.0000  117.0000   19.0000;
            175.0000  118.0000   19.0000;
            173.5000  118.5000   19.0000;
            172.0000  119.0000   19.0000;
            170.5000  119.5000   19.5000;
            169.0000  120.0000   20.0000;
            168.0000  120.5000   20.5000;
            167.0000  121.0000   21.0000;
            165.5000  121.5000   21.5000;
            164.0000  122.0000   22.0000;
            162.5000  123.0000   22.5000;
            161.0000  124.0000   23.0000;
            160.0000  124.5000   24.0000;
            159.0000  125.0000   25.0000;
            157.5000  125.5000   25.5000;
            156.0000  126.0000   26.0000;
            154.5000  126.5000   27.0000;
            153.0000  127.0000   28.0000;
            152.0000  127.5000   28.5000;
            151.0000  128.0000   29.0000;
            149.5000  128.5000   30.0000;
            148.0000  129.0000   31.0000;
            146.5000  129.0000   32.0000;
            145.0000  129.0000   33.0000;
            144.0000  129.5000   34.0000;
            143.0000  130.0000   35.0000;
            141.5000  130.5000   36.0000;
            140.0000  131.0000   37.0000;
            138.5000  131.5000   38.0000;
            137.0000  132.0000   39.0000;
            135.5000  132.5000   40.0000;
            134.0000  133.0000   41.0000;
            133.0000  133.5000   42.5000;
            132.0000  134.0000   44.0000;
            130.5000  134.0000   45.0000;
            129.0000  134.0000   46.0000;
            127.5000  134.5000   47.0000;
            126.0000  135.0000   48.0000;
            125.0000  135.5000   49.0000;
            124.0000  136.0000   50.0000;
            122.5000  136.0000   51.5000;
            121.0000  136.0000   53.0000;
            119.5000  136.5000   54.0000;
            118.0000  137.0000   55.0000;
            117.0000  137.0000   56.5000;
            116.0000  137.0000   58.0000;
            114.5000  137.5000   59.0000;
            113.0000  138.0000   60.0000;
            111.5000  138.0000   61.5000;
            110.0000  138.0000   63.0000;
            109.0000  138.5000   64.0000;
            108.0000  139.0000   65.0000;
            106.5000  139.0000   66.5000;
            105.0000  139.0000   68.0000;
            103.5000  139.5000   69.5000;
            102.0000  140.0000   71.0000;
            101.0000  140.0000   72.0000;
            100.0000  140.0000   73.0000;
            98.5000  140.5000   74.5000;
            97.0000  141.0000   76.0000;
            95.5000  141.0000   77.5000;
            94.0000  141.0000   79.0000;
            93.0000  141.0000   80.0000;
            92.0000  141.0000   81.0000;
            90.5000  141.5000   82.5000;
            89.0000  142.0000   84.0000;
            88.0000  142.0000   85.5000;
            87.0000  142.0000   87.0000;
            85.5000  142.0000   88.5000;
            84.0000  142.0000   90.0000;
            82.5000  142.0000   91.0000;
            81.0000  142.0000   92.0000;
            80.0000  142.0000   93.5000;
            79.0000  142.0000   95.0000;
            77.5000  142.5000   96.5000;
            76.0000  143.0000   98.0000;
            75.0000  143.0000   99.5000;
            74.0000  143.0000  101.0000;
            72.5000  143.0000  102.5000;
            71.0000  143.0000  104.0000;
            70.0000  143.0000  105.0000;
            69.0000  143.0000  106.0000;
            67.5000  143.0000  107.5000;
            66.0000  143.0000  109.0000;
            65.0000  143.0000  110.5000;
            64.0000  143.0000  112.0000;
            63.0000  143.0000  113.5000;
            62.0000  143.0000  115.0000;
            61.0000  143.0000  116.0000;
            60.0000  143.0000  117.0000;
            58.5000  143.0000  118.5000;
            57.0000  143.0000  120.0000;
            56.0000  143.0000  121.5000;
            55.0000  143.0000  123.0000;
            54.0000  143.0000  124.5000;
            53.0000  143.0000  126.0000;
            52.5000  143.0000  127.0000;
            52.0000  143.0000  128.0000;
            51.0000  143.0000  129.5000;
            50.0000  143.0000  131.0000;
            49.5000  143.0000  132.5000;
            49.0000  143.0000  134.0000;
            48.0000  143.0000  135.0000;
            47.0000  143.0000  136.0000;
            46.5000  143.0000  137.5000;
            46.0000  143.0000  139.0000;
            46.0000  142.5000  140.0000;
            46.0000  142.0000  141.0000;
            45.5000  142.0000  142.5000;
            45.0000  142.0000  144.0000;
            45.0000  142.0000  145.0000;
            45.0000  142.0000  146.0000;
            45.0000  142.0000  147.5000;
            45.0000  142.0000  149.0000;
            45.5000  141.5000  150.0000;
            46.0000  141.0000  151.0000;
            46.5000  141.0000  152.5000;
            47.0000  141.0000  154.0000;
            47.5000  141.0000  155.0000;
            48.0000  141.0000  156.0000;
            49.0000  140.5000  157.0000;
            50.0000  140.0000  158.0000;
            50.5000  140.0000  159.0000;
            51.0000  140.0000  160.0000;
            52.0000  139.5000  161.0000;
            53.0000  139.0000  162.0000;
            54.5000  139.0000  163.5000;
            56.0000  139.0000  165.0000;
            57.0000  138.5000  165.5000;
            58.0000  138.0000  166.0000;
            59.5000  138.0000  167.0000;
            61.0000  138.0000  168.0000;
            62.5000  137.5000  169.0000;
            64.0000  137.0000  170.0000;
            65.5000  137.0000  171.0000;
            67.0000  137.0000  172.0000;
            68.5000  136.5000  173.0000;
            70.0000  136.0000  174.0000;
            71.5000  135.5000  174.5000;
            73.0000  135.0000  175.0000;
            75.0000  135.0000  176.0000;
            77.0000  135.0000  177.0000;
            78.5000  134.5000  177.5000;
            80.0000  134.0000  178.0000;
            82.0000  133.5000  179.0000;
            84.0000  133.0000  180.0000;
            85.5000  132.5000  180.5000;
            87.0000  132.0000  181.0000;
            89.0000  132.0000  181.5000;
            91.0000  132.0000  182.0000;
            92.5000  131.5000  182.5000;
            94.0000  131.0000  183.0000;
            96.0000  130.5000  183.5000;
            98.0000  130.0000  184.0000;
            100.0000  129.5000  184.5000;
            102.0000  129.0000  185.0000;
            104.0000  128.5000  185.5000;
            106.0000  128.0000  186.0000;
            107.5000  127.5000  186.5000;
            109.0000  127.0000  187.0000;
            111.0000  126.5000  187.5000;
            113.0000  126.0000  188.0000;
            115.0000  125.5000  188.0000;
            117.0000  125.0000  188.0000;
            119.0000  124.0000  188.5000;
            121.0000  123.0000  189.0000;
            123.0000  122.5000  189.0000;
            125.0000  122.0000  189.0000;
            127.0000  121.5000  189.0000;
            129.0000  121.0000  189.0000;
            130.5000  120.5000  189.5000;
            132.0000  120.0000  190.0000;
            134.0000  119.0000  190.0000;
            136.0000  118.0000  190.0000;
            138.0000  117.5000  190.0000;
            140.0000  117.0000  190.0000;
            142.0000  116.5000  190.0000;
            144.0000  116.0000  190.0000;
            145.5000  115.0000  189.5000;
            147.0000  114.0000  189.0000;
            149.0000  113.5000  189.0000;
            151.0000  113.0000  189.0000;
            153.0000  112.0000  189.0000;
            155.0000  111.0000  189.0000;
            156.5000  110.0000  188.5000;
            158.0000  109.0000  188.0000;
            160.0000  108.5000  188.0000;
            162.0000  108.0000  188.0000;
            163.5000  107.0000  187.5000;
            165.0000  106.0000  187.0000;
            167.0000  105.5000  186.5000;
            169.0000  105.0000  186.0000;
            170.5000  104.0000  185.5000;
            172.0000  103.0000  185.0000;
            174.0000  102.0000  184.5000;
            176.0000  101.0000  184.0000;
            177.5000  100.0000  183.5000;
            179.0000   99.0000  183.0000;
            180.5000   98.0000  182.5000;
            182.0000   97.0000  182.0000;
            184.0000   96.0000  181.5000;
            186.0000   95.0000  181.0000;
            187.5000   94.0000  180.5000;
            189.0000   93.0000  180.0000;
            190.5000   92.0000  179.0000;
            192.0000   91.0000  178.0000;
            193.5000   90.0000  177.5000;
            195.0000   89.0000  177.0000;
            196.5000   88.0000  176.0000;
            198.0000   87.0000  175.0000;
            199.5000   86.0000  174.5000;
            201.0000   85.0000  174.0000;
            202.5000   84.0000  173.0000;
            204.0000   83.0000  172.0000;
            205.0000   82.0000  171.0000;
            206.0000   81.0000  170.0000;
            207.5000   80.0000  169.0000;
            209.0000   79.0000  168.0000;
            210.0000   78.0000  167.5000;
            211.0000   77.0000  167.0000;
            212.5000   76.0000  166.0000;
            214.0000   75.0000  165.0000;
            215.0000   73.5000  164.0000;
            216.0000   72.0000  163.0000;
            217.5000   71.0000  162.0000;
            219.0000   70.0000  161.0000;
            220.0000   69.0000  159.5000;
            221.0000   68.0000  158.0000;
            222.0000   67.0000  157.0000;
            223.0000   66.0000  156.0000;
            224.0000   64.5000  155.0000;
            225.0000   63.0000  154.0000;
            226.0000   62.0000  153.0000;
            227.0000   61.0000  152.0000;
            228.0000   60.0000  150.5000;
            229.0000   59.0000  149.0000;
            230.0000   58.0000  148.0000;
            231.0000   57.0000  147.0000;
            232.0000   56.0000  146.0000;
            233.0000   55.0000  145.0000;
            233.5000   54.0000  143.5000;
            234.0000   53.0000  142.0000;
            235.0000   51.5000  141.0000;
            236.0000   50.0000  140.0000;
            236.5000   49.0000  138.5000;
            237.0000   48.0000  137.0000;
            237.5000   47.5000  136.0000;
            238.0000   47.0000  135.0000;
            239.0000   46.0000  133.5000;
            240.0000   45.0000  132.0000;
            240.5000   44.0000  131.0000;
            241.0000   43.0000  130.0000;
            241.5000   42.5000  128.5000;
            242.0000   42.0000  127.0000;
            242.5000   41.0000  125.5000;
            243.0000   40.0000  124.0000;
            243.0000   39.5000  123.0000;
            243.0000   39.0000  122.0000;
            243.5000   38.5000  120.5000;
            244.0000   38.0000  119.0000;
            244.5000   37.5000  118.0000;
            245.0000   37.0000  117.0000;
            245.0000   37.0000  115.5000;
            245.0000   37.0000  114.0000;
            245.5000   37.0000  112.5000;
            000.0000   00.0000  000.0000];
        stimstruct.xdim = [100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100];
        stimstruct.ydim = [100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100];
        
        Stimuli_sets(50) = Preparestimuli(Parameters,stimstruct);
    end
    
    
elseif strcmp(Modeflag,'InitializeTrial');
    

    Events.variableNames{1} = 'StimNum';
    
    Events.variableFunctions{1} = 'StimNum(Parameters)';
    
    Events.variableNames{2} = 'LineSeen';
    
    Events.variableFunctions{2} = '';
    
    Events.variableNames{3}  = 'ReportedColor';
    Events.variableFunctions{3} = '';
    
    
    for location_values = 1:1
        %Center coordinates
        locx = Parameters.centerx;
        locy = Parameters.centery;
        
        %Jitter
        xjitter = randi(80)-40;
        yjitter = randi(80)-40;
        
        %General Line Locations
        right = locx+300;
        left = locx-300;
        down = locy+225;
        up = locy-225;
        
        %Line Locations with Jitter
        line_location_x = randi(2);
        line_location_y = randi(2);
        stimx(1) =  left+xjitter;
        stimy(1) =  down+yjitter;
        stimx(2) =  right+xjitter;
        stimy(2) =  up+yjitter;
    end
    

    %Mouse Parameters
    mouseresponse_color = CreateResponseStruct;
    mouseresponse_see_line = CreateResponseStruct;
    mouseresponse_line_location = CreateResponseStruct;
    mouseresponse_angle = CreateResponseStruct;
    
    %Responsestruct
    responsestruct = CreateResponseStruct;
    responsestruct.x = locx;
    responsestruct.y = locy;
    
    %Instuctions
    for instructions = 1:1
        
    %Instruction Display (before practice trials)
    if Trial == 1
        
        Events = newevent_mouse_cursor(Events,0,locx,locy,0);
        Events = newevent_show_stimulus(Events,31,1,locx,locy-300,instruction_display_time,'screenshot_no','clear_yes');
        Events = newevent_show_stimulus(Events,31,2,locx,locy-200,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,31,3,locx,locy-100,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,31,4,locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,31,5,locx,locy+100,instruction_display_time,'screenshot_no','clear_no');        responsestruct.allowedchars = 0;
        Events = newevent_show_stimulus(Events,31,6,locx,locy+200,instruction_display_time,'screenshot_no','clear_no');        responsestruct.allowedchars = 0;
        Events = newevent_show_stimulus(Events,31,7,locx,locy+300,instruction_display_time,'screenshot_no','clear_no');        responsestruct.allowedchars = 0;
        Events = newevent_keyboard(Events,instruction_display_time,responsestruct);
        
        %Selects a random color
        shuffled_colors = randperm(360);
        color_probe = shuffled_colors(1);
    
    %Color Feedback (Trial > 1)
    elseif Trial > 1
        
        accuracy_feedback_locy = locy + 150;
        accuracy_number = locx + 85;
        
        Events = newevent_show_stimulus(Events,41,accuracy_percentage,accuracy_number+17,accuracy_feedback_locy,instruction_display_time,'screenshot_no','clear_yes');
        Events = newevent_show_stimulus(Events,42,1,accuracy_number - 250,accuracy_feedback_locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,42,2,accuracy_number + 65,accuracy_feedback_locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,42,3,accuracy_number + 175,accuracy_feedback_locy,instruction_display_time,'screenshot_no','clear_no');
        
        %Feedback color squares
        probe_color_locx = locx - 200;
        report_color_locx = locx + 200;
        
        %Probed
        Events = newevent_show_stimulus(Events,50,color_probe,probe_color_locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,36,2,probe_color_locx,locy-100,instruction_display_time,'screenshot_no','clear_no');
        
        %Response
        Events = newevent_show_stimulus(Events,50,color_response,report_color_locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,36,3,report_color_locx,locy-100,instruction_display_time,'screenshot_no','clear_no');
        
    %Selects a random color
    shuffled_colors = randperm(360);
    color_probe = shuffled_colors(1);
    end
    

        %Instruction Display (before regular trials)
        brief_time = instruction_display_time;
        if Trial == practice_trials + 1; %end of practice trials
            Events = newevent_mouse_cursor(Events,0,locx,locy,0);
            Events = newevent_show_stimulus(Events,32,1,locx,locy-100,brief_time,'screenshot_no','clear_yes');
            Events = newevent_show_stimulus(Events,32,2,locx,locy,brief_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,32,3,locx,locy+100,brief_time,'screenshot_no','clear_no');
            responsestruct.allowedchars = 0;
            Events =  newevent_keyboard(Events,brief_time,responsestruct);
            Events = newevent_show_stimulus(Events,30,1,locx,locy,brief_time+.01,'screenshot_no','clear_yes');
        end
    end
    
    %Selects a random angle
    shuffled_line_angles = randperm(8);
    which_line_angle = shuffled_line_angles(1);
    
    
    %Mouse appears
    Events = newevent_mouse_cursor(Events,instruction_display_time,locx,locy,0);
    
    %Fixation cross display
    Events = newevent_show_stimulus(Events,30,1,locx,locy,fixation_onset_time,'screenshot_no','clear_yes');
    
    %Colored square display
    Events = newevent_show_stimulus(Events,50,color_probe(1),locx,locy,disp_time,'screenshot_no','clear_no');
    
    %Randomizes colors
    colors = randperm(12);
    
    loc = 50;
    
    for masking_squares = 1:1;
    %Masking Squares
    Events = newevent_show_stimulus(Events,43,colors(1),locx+xjitter,locy+yjitter,masking_time,'screenshot_no','clear_yes');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(2),locx+loc+xjitter,locy+yjitter,masking_time,'screenshot_no','clear_no');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(3),locx+loc+xjitter,locy+loc+yjitter,masking_time,'screenshot_no','clear_no');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(4),locx+loc+xjitter,locy-loc+yjitter,masking_time,'screenshot_no','clear_no');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(5),locx-loc+xjitter,locy+yjitter,masking_time,'screenshot_no','clear_no');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(6),locx-loc+xjitter,locy+loc+yjitter,masking_time,'screenshot_no','clear_no');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(7),locx-loc+xjitter,locy-loc+yjitter,masking_time,'screenshot_no','clear_no');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(8),locx+xjitter,locy+loc+yjitter,masking_time,'screenshot_no','clear_no');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(9),locx+xjitter,locy-loc+yjitter,masking_time,'screenshot_no','clear_no');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(10),locx+xjitter,locy+yjitter,masking_time,'screenshot_no','clear_no');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(11),locx+xjitter,locy+yjitter,masking_time,'screenshot_no','clear_no');
    xjitter = randi(80)-40;
    yjitter = randi(80)-40;
    Events = newevent_show_stimulus(Events,43,colors(12),locx+xjitter,locy+yjitter,masking_time,'screenshot_no','clear_no');
    end
    
    %Screen blanks after colored square is displayed
    Events = newevent_blank(Events,trial_blank_time);
    
    %Line Locations
    line_loc_1_x = locx+450;
    line_loc_2_x = locx+150;
    line_loc_3_x = locx-150;
    line_loc_4_x = locx-450;
    
    line_loc_down_y = locy+250;
    line_loc_up_y = locy-250;
    
    
    %Surprise Question Timing & Selection Window Parameters
    for surprise_window = 1:1
        %Line Angle (Selection) Window Size
        angle_win_size = 37.5;
        
        %Line Location (Selection) Window Size
        loc_win_size = 200;
    end
    
    %Reset variable before defining
    see_line_response = 0;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%Events Executed Based on Trial Type (The Experiment Display)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Three Changeable Timing Variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for probe_line = randi(2)-1
        
        if Trial < surprise_trial_number; %Pre-surprise trials
            angle_display = 0;
            line_displayed = 1;
            
            color_question_time = color_wheel_time; %Color wheel time is defined in the "Timing Parameters" section at the top of this block file
            
        elseif Trial == surprise_trial_number || ( Trial > surprise_trial_number && probe_line); %Surprise & post_surprise trials when a line is displayed
            line_displayed = 2;
            angle_display = which_line_angle;
            
            Events = newevent_mouse_cursor(Events,0,locx,locy,0);
            
            line_loc_x = stimx(line_location_x);
            line_loc_y = stimy(line_location_y);
            
            %Line Display
            Events = newevent_show_stimulus(Events,1,which_line_angle,line_loc_x, ...
                line_loc_y,disp_time,'screenshot_no','clear_no');
            Trial_Export.line_displayed_x = line_loc_x;
            Trial_Export.line_displayed_y = line_loc_y;
            
            %Question 1 (See the line?)
            Events = newevent_show_stimulus(Events,30,3,locx,locy-150,see_line_question_time,'screenshot_no','clear_no'); %did they see a line?
            Events = newevent_show_stimulus(Events,30,4,locx,locy-50,see_line_question_time,'screenshot_no','clear_no'); %did they see a line?
            Events = newevent_show_stimulus(Events,40,1,locx+75,locy+50,see_line_question_time,'screenshot_no','clear_no'); %yes
            Events = newevent_show_stimulus(Events,40,2,locx-75,locy+50,see_line_question_time,'screenshot_no','clear_no'); %no
            
            %Mouse reappears
            Events = newevent_mouse_cursor(Events,see_line_question_time,locx,locy,Parameters.mouse.cursorsize);
            
            mouseresponse_see_line.variableInputName='LineSeen';
            mouseresponse_see_line.variableInputMapping=[1 2;2 1];
            
            %Mouse Click Windows
            mouseresponse_see_line.spatialwindows = {[locx-75,locy+50,50];[locx+75,locy+50,50]};%where they can click (yes or no button)
            
            %Waits for mouse input
            [Events,see_line_response] = newevent_mouse(Events,see_line_question_time,mouseresponse_see_line);
            
            Events = newevent_mouse_cursor(Events,see_line_question_time+.01,locx,locy,0);
            
            %Mouse reappears
            Events = newevent_mouse_cursor(Events,object_question_time,locx,locy,Parameters.mouse.cursorsize);
            
            if Trial == surprise_trial_number
            %Question 2 (Object)
            Events = newevent_show_stimulus(Events,44,'LineSeen',locx,locy,object_question_time,'screenshot_no','clear_yes'); %ask about object

            responsestruct = CreateResponseStruct;
            
            responsestruct.showinput = 1;
            
            responsestruct.x = locx - 100;
            responsestruct.y = locy + 100;
            
            responsestruct.maxlength = 50;
            
            responsestruct.allowbackspace = 1;
            
            responsestruct.waitforenter = 1;
            
            allowed = [];
            for letter = 'abcdefghijklmnopqrstuvwxyz'
                allowed = [allowed KbName(letter)];
            end
            
            responsestruct.allowedchars = [allowed KbName('Space')];
            
            [Events,reported_object] = newevent_keyboard(Events,object_question_time,responsestruct);
            end
            
            if Trial == surprise_trial_number
            %Question 2/3 (Line Location)
            Events = newevent_show_stimulus(Events,35,'LineSeen',locx,locy,location_question_time,'screenshot_no','clear_yes'); %ask line location
            elseif Trial > surprise_trial_number
            Events = newevent_show_stimulus(Events,45,'LineSeen',locx,locy,location_question_time,'screenshot_no','clear_yes'); %ask line location
            end
            
            %Line Location Selection Squares
            Events = newevent_show_stimulus(Events,34,1,left,up,location_question_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,34,1,right,up,location_question_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,34,1,right,down,location_question_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,34,1,left,down,location_question_time,'screenshot_no','clear_no');
            
            %Mouse Click Windows
            mouseresponse_line_location.spatialwindows = {[left,up,loc_win_size]; ...
                [right,up,loc_win_size];[left,down,loc_win_size];[right,down,loc_win_size]};
            
            %Waits for mouse input
            [Events,location_response] = newevent_mouse(Events,location_question_time,mouseresponse_line_location);

            %Mouse disappears after response
            Events = newevent_mouse_cursor(Events,location_question_time+.01,locx,locy,0);
            
            %Mouse reappears
            Events = newevent_mouse_cursor(Events,angle_question_time,locx,locy,Parameters.mouse.cursorsize);
            
            if Trial == surprise_trial_number
            %Question 3/4 (Angle)
            Events = newevent_show_stimulus(Events,33,'LineSeen',locx,locy,angle_question_time,'screenshot_no','clear_yes'); %ask angle
            elseif Trial > surprise_trial_number
            Events = newevent_show_stimulus(Events,46,'LineSeen',locx,locy,angle_question_time,'screenshot_no','clear_yes'); %ask angle
            end
            Events = newevent_show_stimulus(Events,2,8,line_loc_1_x,line_loc_down_y,angle_question_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,2,4,line_loc_2_x,line_loc_down_y,angle_question_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,2,7,line_loc_3_x,line_loc_down_y,angle_question_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,2,3,line_loc_4_x,line_loc_down_y,angle_question_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,2,6,line_loc_1_x,line_loc_up_y,angle_question_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,2,2,line_loc_2_x,line_loc_up_y,angle_question_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,2,5,line_loc_3_x,line_loc_up_y,angle_question_time,'screenshot_no','clear_no');
            Events = newevent_show_stimulus(Events,2,1,line_loc_4_x,line_loc_up_y,angle_question_time,'screenshot_no','clear_no');
            
            %Mouse Click Windows
            mouseresponse_angle.spatialwindows = {[line_loc_4_x, line_loc_up_y,angle_win_size];[line_loc_2_x, line_loc_up_y,angle_win_size]; ...
                [line_loc_4_x, line_loc_down_y,angle_win_size]; [line_loc_2_x, line_loc_down_y,angle_win_size]; ...
                [line_loc_3_x, line_loc_up_y,angle_win_size]; [line_loc_1_x, line_loc_up_y,angle_win_size];
                [line_loc_3_x, line_loc_down_y,angle_win_size];[line_loc_1_x, line_loc_down_y,angle_win_size]}; %line locations (for angle question)
            
            %Waits for mouse input
            [Events,angle_response] = newevent_mouse(Events,angle_question_time,mouseresponse_angle);
                        
            %Mouse disappears after response on angle question
            mouse_disappear_time = angle_question_time + .01;
            Events = newevent_mouse_cursor(Events,mouse_disappear_time,locx,locy,0);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            color_question_time = mouse_disappear_time + .01; %CHANGEHERE% When the participant is asked about color (after asked about angle)
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
        elseif Trial > (surprise_trial_number && probe_line == 0) %Post surprise trial in which a line is not shown
            
            %Question 1 (See the line?)
            Events = newevent_show_stimulus(Events,30,3,locx,locy-150,see_line_question_time,'screenshot_no','clear_no'); %did they see a line?
            Events = newevent_show_stimulus(Events,30,4,locx,locy-50,see_line_question_time,'screenshot_no','clear_no'); %did they see a line?
            Events = newevent_show_stimulus(Events,40,1,locx+75,locy+50,see_line_question_time,'screenshot_no','clear_no'); %yes
            Events = newevent_show_stimulus(Events,40,2,locx-75,locy+50,see_line_question_time,'screenshot_no','clear_no'); %no
            
            %Mouse reappears
            Events = newevent_mouse_cursor(Events,see_line_question_time,locx,locy,Parameters.mouse.cursorsize);
            mouseresponse_see_line.variableInputName='LineSeen';
            mouseresponse_see_line.variableInputMapping=[1 2; 2 1];
            
            %Mouse Click Windows
            mouseresponse_see_line.spatialwindows = {[locx-75,locy+50,50];[locx+75,locy+50,50]};%where they can click (yes or no button)
            
            %Waits for mouse input
            [Events,see_line_response] = newevent_mouse(Events,see_line_question_time,mouseresponse_see_line);
            
            %Mouse disappears after response
            Events = newevent_mouse_cursor(Events,see_line_question_time+.0000001,locx,locy,0);
            
            %"No line was displayed"
            Events = newevent_show_stimulus(Events,36,1,locx,locy,see_line_question_time+.05,'screenshot_no','clear_yes');
            Events = newevent_show_stimulus(Events,36,1,locx,locy,see_line_question_time+.05,'screenshot_no','clear_yes');
            line_displayed = 1;
            angle_display = 0;

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            color_question_time = see_line_question_time + 2; %CHANGEHERE% When the participant is asked about color
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
        end
    end
    
    %Color Question
    for color_question = 1:1;
        
        Trial_Export.color_probe = color_probe;
        
        %Mouse appears
        Events = newevent_mouse_cursor(Events,color_question_time,locx,locy,Parameters.mouse.cursorsize);
        
        %Loads color Wheel
        command =   'load(''colorWheelLocations1'');';
        Events = newevent_command(Events,color_question_time,command,'clear_yes');
        command =   'load(''colorWheelLocations2'');';
        Events = newevent_command(Events,color_question_time,command,'clear_no');
        command =   'load(''colorwheel360'');';
        Events = newevent_command(Events,color_question_time,command,'clear_no');
        command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations1, 10, fullcolormatrix'', [], 1);';
        Events = newevent_command(Events,color_question_time,command,'clear_yes');
        command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations2, 10, fullcolormatrix'', [], 1);';
        Events = newevent_command(Events,color_question_time,command,'clear_no');
        Events = newevent_show_stimulus(Events,50,'StimNum',locx,locy,color_question_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,30,2,locx,locy-300,color_question_time,'screenshot_no','clear_no');
        
        mouseresponse_color.variableInputName='ReportedColor';
        mouseresponse_color.variableInputMapping=[1:360;1:360]';
        
        %Mouse Click Windows
        mouseresponse_color.spatialwindows = buttonlocs;
        [Events,color_response] = newevent_mouse(Events,color_question_time,mouseresponse_color);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        color_feedback_time = color_question_time + .01; %CHANGEHERE% When color feedback is given
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %Mouse disappears after response
        Events = newevent_mouse_cursor(Events,color_feedback_time,locx,locy,0);
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    trial_end_time = color_feedback_time + .01; %CHANGEHERE% When the trial ends
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Ends trial
    Events = newevent_end_trial(Events,trial_end_time);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    

    %Exports trial type
    if(Trial ==  surprise_trial_number)
        Trial_Export.trial_type = 3;
    elseif (Trial <= practice_trials)
        Trial_Export.trial_type = 1;
    elseif (Trial < surprise_trial_number)
        Trial_Export.trial_type = 2;
    else
        Trial_Export.trial_type = 4;
    end
    
elseif strcmp(Modeflag,'EndTrial');
    
    for export_variables_1 = 1:1
        
        try
            Trial_Export.color_response = Events.windowclicked{color_response};
        catch
            Trial_Export.color_response = 0;
        end
        
        try
            Trial_Export.see_line_response = Events.windowclicked{see_line_response}-1;
        catch
            Trial_Export.see_line_response = 0;
        end
        
        if line_displayed == 2
            Trial_Export.line_displayed = 1;
            try
                Trial_Export.angle_display = angle_display;
            catch
                Trial_Export.angle_display = 0;
            end
            try
                Trial_Export.angle_response =  Events.windowclicked{angle_response};
            catch
                Trial_Export.angle_response = 0;
            end
            try
                Trial_Export.location_response = Events.windowclicked{location_response};
            catch
                Trial_Export.location_response = 0;
            end
        else
            Trial_Export.line_displayed = 0;
        end
        
        try
            Trial_Export.line_displayed_x = line_loc_x;
        catch
            Trial_Export.line_displayed_x = 0;
            Trial_Export.location_display = 0;
        end
        
        try
            Trial_Export.line_displayed_y = line_loc_y;
        catch
            Trial_Export.line_displayed_y = 0;
            Trial_Export.location_display = 0;
        end
        
        if Trial_Export.line_displayed_x ~= 0
            if line_loc_x < 300 && line_loc_y < 200
                Trial_Export.location_display = 1;
            elseif line_loc_x > 300 && line_loc_y < 200
                Trial_Export.location_display = 2;
            elseif line_loc_x < 300 && line_loc_y > 200
                Trial_Export.location_display = 3;
            elseif line_loc_x > 300 && line_loc_y > 200
                Trial_Export.location_display = 4;
            end
        end
        
        if line_displayed == 1
            Trial_Export.line_displayed_x = 0;
            Trial_Export.line_displayed_y = 0;
            Trial_Export.location_display = 0;
        end
    end
    
    color_response = (Events.windowclicked{color_response});
    
    difference = color_response - color_probe;
    
    if(difference > 180)
        difference = difference - 360;
    end
    if(difference < -180)
        difference = difference + 360;
    end
    
    
    if Trial > practice_trials
        
        if Trial == practice_trials + 1
            total_accuracy = (accuracy_percentage + round(100 - ((sqrt(difference^2))/180)*100))/2;
        elseif Trial >= practice_trials + 2
            total_accuracy = (total_accuracy + round(100 - ((sqrt(difference^2))/180)*100))/2;
        end
        
        Trial_Export.total_accuracy = total_accuracy;
    else
        Trial_Export.total_accuracy = 0;
    end
    
    
 Trial_Export.color_accuracy = difference;
 
 accuracy_percentage = round(100 - ((sqrt(difference^2))/180)*100);
 
 Trial_Export.accuracy_percentage = accuracy_percentage;
 
 if Trial == surprise_trial_number
 Trial_Export.object_response = char(Events.response{reported_object});
 end
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Output Descriptions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%accuracy_percentage:
       %This is a calculation that determines how close the participant's
       %reported color is to the displayed color.

%angle_display & angle_response:
       %These outputs are the angle that is displayed during the trial(angle_display)
       %and the angle that the participant selects as a response (angle_response)
        %These outputs translate into angles as such:
            % 1 = 0 degrees, 2 = 25 degrees, 3 = 50 degress, 4 = 75 degrees, 5 = 100 degrees, 6 = 125 degrees, 7 = 150 degrees, 8 = 175 degrees
       %These outputs will be 0 if no line is displayed on the trial.

%color_accuracy:
        %This outputs the distance in color space between the actual color
        %and the reported color.

%color_probe & color_response:
       %These outputs are the color value of the square displayed on screen during the trial (color_probe) 
       %and the color value of the color that the participant selected (color_response).
            %Colored squares line the circumference, numbered 1-360, with 1 at the rightmost edge. 
            %Values of the squares increase by 1 clockwise around the circle.

%line_displayed:
        %This output is whether or not a line is displayed during the
        %trial. (0 = displayed, 1 = not displayed)
        
%line_displayed_x & line_displayed_y:
       %These are the x and y coordinates of the line that was displayed.
       %These outputs will be 0 if no line is displayed on the trial.
           
%location_display & location_response:
       %These outputs represent where the line was located on the screen (location_display)
       %and where the participant reported they saw the line (location_response).
            %An output of 1 indicates the top left corner, 2 = top right corner,
                % 3 = bottom left corner, 4 = bottom right corner
       %These outputs will be 0 if no line is displayed on the trial.
       
%object_response
        %If the participant reported that he/she saw the object, this is
        %their response to what object they saw. If the participant
        %reported not seeing the object, this is their response to what
        %color they think the object was.
       
%see_line_response:
        %This output is whether the participant responds "yes" (1) or "no" (0) to
        %if they saw a line during the trial.
        
%trial_type:
        %This outputs trial type such that
            % 1 = practice, 2 = pre-surprise, 3 = surprise, 4 = post-surprise
            
%total_accuracy:
       %This is the average of the total of the accuracy percentages across all trials.
       %Total accuracy starts calculation at the end of the last practice trials.
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
       
elseif strcmp(Modeflag,'EndBlock');
else
    %Something went wrong in Runblock (You should never see this error)
    error('Invalid modeflag');
end
saveblockspace
end