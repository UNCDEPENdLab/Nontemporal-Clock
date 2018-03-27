function Parameters = Setparameters(Parameters,Userdata)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Stream
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A multi-purpose experimental toolkit for creating experiments easily using Matlab and Psychtoolbox-3
% Includes optional EEG and Eyelink functionality
% maintained by Brad Wyble, with helpful contributions
% from Patrick Craston, Srivas Chennu, Marcelo Gomez, Syed Rahman & Asli
% Kilic, Michael Romano and especially Greg Wade
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Setparameters(Parameters,Userdata)
% Setparameters is called at the start of the experiment and at the start of each
% block. Establishes a set of parameter variables needed for the set up and
% running of Stream. Default values will be set for any value not specified
% within the blockfile.
%
% Input
%    Parameters: Parameter set for this experiment if previously set
%    Userdata:  Data for the current subject
%
%Setparameters is called by:
%    Runexp




%Current version of Stream
Parameters.Streamversion = '2.2.21';

if(nargin > 1)
    %Determine the set of blockfiles that will be run in the experiment:
    Parameters.blocklist = {'practice_task','practice_task','practice_task', ... 
        'clock_task','clock_task','clock_task','clock_task','clock_task','clock_task','clock_task','clock_task'};
end



%Set up file directories
if IsOSX | IsLinux   %on a mac, or PC choose the right data directory
    Parameters.datadir='data/';
    Parameters.trialdescriptions='Trialdescriptions/';
    Parameters.screenshotdir='Screenshots/';
    Parameters.stimulidir = 'Stimuli/';
    Parameters.workingdir = [pwd '/'];
    Parameters.keycodeoffset = -61;   %when using kbinput routine, what is the offset of the letter A
else
    Parameters.datadir='data\';
    Parameters.trialdescriptions='Trialdescriptions\';
    Parameters.screenshotdir='Screenshots\';
    Parameters.stimulidir = 'Stimuli\';
    Parameters.workingdir = [pwd '\'];
    Parameters.keycodeoffset = 0;
end

if(nargin ==1)
    Parameters.pahandle = 0;
end



%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Setup parameters for running Stream
Parameters.skipsynctests = 1;
Parameters.datafilename = 'ExpSub';    %data file prefix
Parameters.whichscreen = max(Screen('Screens'));  %which of the displays do we use?  (only relevant if there are multiple monitors)
if sum(Screen('Screens')) > 0
    Parameters.whichscreen = 2;
else
    Parameters.whichscreen = 0;  %which of the displays do we use?  (only relevant if there are multiple monitors)
end
backcolor = 255;
Parameters.backgroundcolor = repmat(backcolor,1,3);   %what color is the background screen in RGB (0-255)
Parameters.disableinput = 0;   %turn off all user input
Parameters.interruptible = 1;   % if set to 1, users can abort the experiment in between trials by pressing escape
Parameters.slowmotionfactor = 1;  %slow down the whole presentations sequence by the amount indicated  (1.0 = normal speed, 5.0 = 5x slower, .5 = 2x faster)
Parameters.speedoptimized = 0;   %experimental speed optimization setting, NOT YET WORKING DO NOT USE
Parameters.sync = 0;   %dontsync parameter for Screen(flip)

%it's not yet working in part because I haven't
%yet found a paradigm for which it is necessary
Parameters.audioinput = 0;   %do we need to initialize the audio drivers?
Parameters.audiooutput = 1;   %do we need to initialize the audio drivers?
Parameters.freq = 44100;

Parameters.instructionwidth = 60;   %how wide is the text box in which the instructions are displayed at the start?


Parameters.trialrestart = 0;  %restart PTB at the beginning of each trial
Parameters.blockrestart = 0; %restart PTB at the beginning of each block

%%%%%%%%%%%%%%%%%%%%%%%%
%%%% use Vpixx?
Parameters.vpixx.enabled = 0;
Parameters.vpixx.dummymode = 0;  %testing vpixx stuff without an actual voixx connected
Parameters.vpixx.M16 = 1;

%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Set the Screen Resolution for Displaying Stream
Parameters.ScreenResolutionX = 1920;
Parameters.ScreenResolutionY = 1080;

%%%%%%%%%%%%%%%%%%%%%%%%
%%%% use the mouse?
Parameters.mouse.enabled = 1;
Parameters.mouse.datastore = 0;
Parameters.mouse.cursorsize = 8;
Parameters.mouse.cursorcolor = [0,205,45];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%prepare stimuli Progress bar
Parameters.Progressbarenabled = 0;
Parameters.Progressbaritems = 0;
Parameters.Progressbaritems_done = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Parameters for specific blocks
Parameters.saveevery = 1;   %save a backup file after every X trials

%%%%%%%%%%%%%%%%%%%%%
%%%% Parameters pertaining to Parallel port
Parameters.ParallelPort = 0;
Parameters.MARKERS = struct( ...            %%%%%%%%%%%%%%%%%%%%  DEDICATED MARKERS  DO NOT MODIFY THESE
    'STARTEXP',	1,...                               %AUTOMATICALLY GENERATED %%
    'BEGINBLOCK',	2, ...
    'BLOCKTYPE',	3, ...
    'BEGINTRIAL',	13, ...
    'FIXATION',	15,...
    'INTRIALVALIDKEYRESPONSE',18,...   %AUTOMATICALLY GENERATED %%used by reactiontime keypress events (action type 2)
    'INTRIALINVALIDKEYRESPONSE',19,...   %AUTOMATICALLY GENERATED %%%used by reactiontime keypress events (action type 2)
    'INTRIALUNEXPECTEDKEYRESPONSE',20,...   %AUTOMATICALLY GENERATED %%%used by unexpected keypress events
    'INTERVENE', 21,...     %sometimes we need to insert an extra character between two identical digits
    'FIRSTDIGIT_TRIALNUM',	22,...
    'SECONDDIGIT_TRIALNUM',	22,...
    'THIRDDIGIT_TRIALNUM', 	22,...
    'FIRSTDIGIT_BLOCKNUM', 	32,...
    'SECONDDIGIT_BLOCKNUM', 32,...
    'RESPONSEONSET',	43,...
    'DINRESPONSE',	44,...
    'NORESPONSE',45,...
    'ENDTRIAL',	46,...
    'ENDBLOCK',	47,...
    'ENDEXP',	48,...      %AUTOMATICALLY GENERATED %%
    'VisualHigh_L',51,...
    'VisualMed_L',52,...
    'VisualLow_L',53,...
    'AuditoryHigh_L',54,...
    'AuditoryMed_L',55,...
    'AuditoryLow_L',56,...
    'SomaHigh_L',57,...
    'SomaMed_L',58,...
    'SomaLow_L',59,...
    'AV_High_L',60,...
    'AV_Med_L',61,...
    'AV_Low_L',62,...
    'AS_High_L',63,...
    'AS_Med_L',64,...
    'AS_Low_L',65,...
    'VS_High_L',66,...
    'VS_Med_L',67,...
    'VS_Low_L',68,...
    'Catch_trial_no_stim',69,....
    'Catch_trial_suprathreshold_Vis_L',72,...
    'Catch_trial_suprathreshold_aud_L',73,...
    'Catch_trial_suprathreshold_soma_L',74,...
    'VisualHigh_R',75,...
    'VisualMed_R',76,...
    'VisualLow_R',77,...
    'AuditoryHigh_R',78,...
    'AuditoryMed_R',79,...
    'AuditoryLow_R',80,...
    'SomaHigh_R',81,...
    'SomaMed_R',82,...
    'SomaLow_R',83,...
    'AV_High_R',84,...
    'AV_Med_R',85,...
    'AV_Row_R',86,...
    'AS_High_R',87,...
    'AS_Med_R',88,...
    'AS_Low_R',89,...
    'VS_High_R',90,...
    'VS_Med_R',91,...
    'VS_Low_R',92,...
    'Catch_trial_suprathreshold_Vis_R',96,...
    'Catch_trial_suprathreshold_aud_R',97,...
    'Catch_trial_suprathreshold_soma_R',98,...
    'Foot_pedal_response',99,...
    'hit',100,...
    'miss',101,...
    'cr',102,...
    'fa',103,...
    'Fixation_cross_change',104,...
    'EyesGood',105,...
    'EyesBad',106,...
    'STIMULI',110);


Parameters.MARKERPAUSE = .025;   %pause between triggers in seconds (.025 = 25 msec)
Parameters.invalidkeys_ParallelPortmark = 0;

%%%%%%%%%%%%%%%%%%%%%
%%%% Parameters pertaining to eyetracking
Parameters.eyetracking =0;   %enable eye tracking
Parameters.Eyelink =1;   %enable eye tracking
Parameters.TobiiX2 =0;   %enable eye tracking
Parameters.trackerId = 'X230C-010103334692';  %For Tobii
Parameters.eyecalibrate = 0;


Parameters.edffilename = 'DEF';  %EDF filename can only be a total of 8 characters!  So remember that the subject number will be added to this
Parameters.eyerealtime =1;    %track of the eye position in real time in *addition* to storing the information on the eyetrack computer  (warning, may slow down your experiment)
Parameters.eyedatastore =1 ;    %store every eye data point (warning,larger data files!)  You MUST have eyerealtime enabled for this to work
Parameters.eyesamplingrate = 40;   %this is used to calculate how much space is required to store all of the eye data.  This is an estimate of how manu times per second the eyes will move
Parameters.eyecursor =2;%display a cursor where the eyes are:  1 = always on,  2 = F1 triggered
Parameters.eyecursorcolor = [255,0,0]; %Set the color of the eye cursor
Parameters.eyecursorthreshold = 5;  %what is the threshold in pixels above which we redraw the eye cursor?


Parameters.extratimeallowance = 0;
Parameters.useCM5 = 0;  %somatosensory stimulator



