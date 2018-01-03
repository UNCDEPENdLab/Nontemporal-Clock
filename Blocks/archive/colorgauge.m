function [Events Parameters Stimuli_sets Block_Export Trial_Export  Numtrials]=Demo(Parameters, Stimuli_sets, Trial, Blocknum, Modeflag, ...
    Events,Block_Export,Trial_Export,Demodata)
% clear Stimuli_sets
load('blockvars')

%Paradigm coded by Michael R Hess, August '15


%Experiment is adjusted for a screen resolution of 1024x768


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Trial Parameters% (Not all. For the rest, scroll down to "The Experiment Display" section.)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CHANGEHERE% %Total number of trials
Numtrials = 10 + 1; %Because of the way this block file runs, set Numtrials equal to the amount of trials you want and then add 1

%When the instructions will be displayed from the start of the experiment (Trial 1)
instruction_display_time = 0;

%CHANGEHERE% %When the color wheel and color question will appear on pre-surprise trials (after retention)
if Trial == 1
    color_wheel_time = instruction_display_time + .01;
else
    color_wheel_time = instruction_display_time + 2;
end

%CHANGEHERE% %How long the total accuracy score will display on screen at the end of the trials
total_feedback_time = 5;

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
    clear Stimuli_sets
    %Fixation Cross & Questions
    stimstruct = CreateStimStruct('text');
    stimstruct.wrapat = 0;
    stimstruct.stimuli = {'+','Match the color of your square on the right to the colored square on the left.'};
    stimstruct.stimsize = 20;
    Stimuli_sets(30) = Preparestimuli(Parameters,stimstruct);
    
    %Instructions (before practice trials)
    stimstruct = CreateStimStruct('text');
    stimstruct.wrapat = 0;
    stimstruct.stimuli = {'Move the mouse along the color wheel to match the color of your square','on the right to the colored square displayed on the left.', 'Click once you believe that the colors match. Press any key to start.'};
    stimstruct.stimsize = 20;
    stimstruct.wrapat = 0;
    stimstruct.vSpacing = 5;
    Stimuli_sets(31) = Preparestimuli(Parameters,stimstruct);
    
    %Text Feedback
    stimstruct = CreateStimStruct('text');
    stimstruct.wrapat = 0;
    stimstruct.stimuli = {'No line was displayed.','Displayed Color','Color You Chose'};
    stimstruct.stimsize = 30;
    stimstruct.vSpacing = 5;
    Stimuli_sets(36) = Preparestimuli(Parameters,stimstruct);
    
    %Accuracy Feedback
    stimstruct = CreateStimStruct('text');
    stimstruct.wrapat = 0;
    stimstruct.stimuli = {'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59','60','61','62','63','64','65','66','67','68','69','70','71','72','73','74','75','76','77','78','79','80','81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98','99','100'};
    stimstruct.stimsize = 30;
    stimstruct.vSpacing = 5;
    Stimuli_sets(40) = Preparestimuli(Parameters,stimstruct);
    
    %Accuracy Feedback
    stimstruct = CreateStimStruct('text');
    stimstruct.wrapat = 0;
    stimstruct.stimuli = {'Your color selection was', '%', 'accurate.'};
    stimstruct.stimsize = 30;
    stimstruct.vSpacing = 5;
    Stimuli_sets(41) = Preparestimuli(Parameters,stimstruct);
    
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
    
    
    Events.variableNames{3}  = 'ReportedColor';
    Events.variableFunctions{3} = '';
    

    %Center coordinates
    locx = Parameters.centerx;
    locy = Parameters.centery;
    

    %Mouse appears
    Events = newevent_mouse_cursor(Events,instruction_display_time,locx,locy,0);
    
    
    %Mouse Parameters
    mouseresponse_color = CreateResponseStruct;
    mouseresponse_see_line = CreateResponseStruct;
    mouseresponse_line_location = CreateResponseStruct;
    mouseresponse_angle = CreateResponseStruct;
    
    %Responsestruct
    responsestruct = CreateResponseStruct;
    responsestruct.x = locx;
    responsestruct.y = locy;
    
    
    %Instruction Display (before practice trials)
    if Trial == 1
        Events = newevent_mouse_cursor(Events,0,locx,locy,0);
        Events = newevent_show_stimulus(Events,31,1,locx,locy-100,instruction_display_time,'screenshot_no','clear_yes');
        Events = newevent_show_stimulus(Events,31,2,locx,locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,31,3,locx,locy+100,instruction_display_time,'screenshot_no','clear_no');
        responsestruct.allowedchars = 0;
        Events = newevent_keyboard(Events,instruction_display_time,responsestruct);
        
        %Selects a random color
        shuffled_colors = randperm(360);
        color_probe = shuffled_colors(1);
    
    %Color Feedback (Trial > 1)
    else
        
        accuracy_feedback_locy = locy + 150;
        accuracy_number = locx + 85;
        
        Events = newevent_show_stimulus(Events,40,accuracy_percentage,accuracy_number+17,accuracy_feedback_locy,instruction_display_time,'screenshot_no','clear_yes');
        Events = newevent_show_stimulus(Events,41,1,accuracy_number - 250,accuracy_feedback_locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,41,2,accuracy_number + 60,accuracy_feedback_locy,instruction_display_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,41,3,accuracy_number + 175,accuracy_feedback_locy,instruction_display_time,'screenshot_no','clear_no');
        
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
    
    
    if Trial <= Numtrials
        
    %Color Question
    for color_question = 1:1;
        
        Trial_Export.color_probe = color_probe;
        
        %Mouse appears
        Events = newevent_mouse_cursor(Events,color_wheel_time,locx,locy,Parameters.mouse.cursorsize);
        
        %Loads color Wheel
        command =   'load(''colorWheelLocations1'');';
        Events = newevent_command(Events,color_wheel_time,command,'clear_yes');
        command =   'load(''colorWheelLocations2'');';
        Events = newevent_command(Events,color_wheel_time,command,'clear_no');
        command =   'load(''colorwheel360'');';
        Events = newevent_command(Events,color_wheel_time,command,'clear_no');
        command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations1, 10, fullcolormatrix'', [], 1);';
        Events = newevent_command(Events,color_wheel_time,command,'clear_yes');
        command =   'Screen(''DrawDots'', Parameters.window, colorWheelLocations2, 10, fullcolormatrix'', [], 1);';
        Events = newevent_command(Events,color_wheel_time,command,'clear_no');
        Events = newevent_show_stimulus(Events,50,color_probe,locx-100,locy,color_wheel_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,50,'StimNum',locx+100,locy,color_wheel_time,'screenshot_no','clear_no');
        Events = newevent_show_stimulus(Events,30,2,locx,locy-300,color_wheel_time,'screenshot_no','clear_no');
        
        mouseresponse_color.variableInputName='ReportedColor';
        mouseresponse_color.variableInputMapping=[1:360;1:360]';
        
        %Mouse Click Windows
        mouseresponse_color.spatialwindows = buttonlocs;
        [Events,color_response] = newevent_mouse(Events,color_wheel_time,mouseresponse_color);
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        color_feedback_time = color_wheel_time + .01; %CHANGEHERE% When color feedback is given
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        Events = newevent_blank(Events,color_feedback_time);

        
        %Mouse disappears after response
        Events = newevent_mouse_cursor(Events,color_feedback_time,locx,locy,0);
        
    end
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        trial_end_time = color_feedback_time + .2; %CHANGEHERE% When the trial ends
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    else

        trial_end_time = total_feedback_time;
        
    end
    
    %Ends trial
    Events = newevent_end_trial(Events,trial_end_time);
    
    
elseif strcmp(Modeflag,'EndTrial');
    
    if Trial < Numtrials
        
        try
            Trial_Export.color_response = Events.windowclicked{color_response};
        catch
            Trial_Export.color_response = 0;
        end
        
        
        color_response = (Events.windowclicked{color_response});
        
        difference = color_response - color_probe;
        
        
        if(difference > 180)
            difference = difference - 360;
        end
        
        if(difference < -180)
            difference = difference + 360;
        end
        
        if Trial > 1
            
            if Trial == 2
                total_accuracy = (accuracy_percentage + round(100 - ((sqrt(difference^2))/180)*100))/2;
            elseif Trial > 2
                total_accuracy = (total_accuracy + round(100 - ((sqrt(difference^2))/180)*100))/2;              
            end
            
            Trial_Export.total_accuracy = total_accuracy;
        else
            Trial_Export.total_accuracy = round(100 - ((sqrt(difference^2))/180)*100);
        end        
        
        Trial_Export.color_accuracy = difference;
        
        accuracy_percentage = round(100 - ((sqrt(difference^2))/180)*100);
        
        Trial_Export.accuracy_percentage = accuracy_percentage;
    else
        Trial_Export.accuracy_percentage = 'feedback trial';
        Trial_Export.color_accuracy = 'feedback trial';
        Trial_Export.color_probe = 'feedback trial';
        Trial_Export.color_response = 'feedback trial';
        Trial_Export.total_accuracy = 'feedback trial';
        
    end
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Output Descriptions%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%accuracy_percentage:
       %This is a calculation that determines how close the participant's
       %reported color is to the displayed color.

%color_accuracy:
        %This outputs the distance in color space between the actual color
        %and the reported color.

%color_probe & color_response:
       %These outputs are the color value of the square displayed on screen during the trial (color_probe) 
       %and the color value of the color that the participant selected (color_response).
            %Colored squares line the circumference, numbered 1-360, with 1 at the rightmost edge. 
            %Values of the squares increase by 1 clockwise around the circle.

%total_accuracy:
       %This is the average of the total of the accuracy percentages across all trials.

       
       %%%NOTE%%% Because of how this blockfile runs, feedback is technically given at
       %%%%%%%%%% the start of the next trial. Therefore, a blank feedback trial is
       %%%%%%%%%% needed at the end of the last trial in order to give feedback for
       %%%%%%%%%% that trial. The output for that trial will have all output
       %%%%%%%%%% variables set to 'feedback trial.'
       
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