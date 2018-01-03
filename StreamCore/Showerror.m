function Showerror(err)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Stream
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A multi-purpose experimental toolkit for creating experiments easily using Matlab and Psychtoolbox-3
% Includes optional EEG and Eyelink functionality
% maintained by Brad Wyble, with helpful contributions
% from Patrick Craston, Srivas Chennu, Marcelo Gomez, Syed Rahman & Asli
% Kilic, Michael Romano and especially Greg Wade
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Showerror(err)
% Repackage an error into the same format as MATLAB typically shows them
% after a program crashes.
%
% Input
%    err: Error information generated by MATLAB
%
%Showerror is called by:
%    Runexp
%    Runblock
%    WriteDataFiles
%    Preparestimuli
%    CheckStimkuli
%    CheckTrials
%    Preparescreen

fp = fopen('lasterror.txt','w');
fprintf(fp, 'The error occured in function %s on line %d',err.stack(1).name,err.stack(1).line);
fprintf(fp,'and the error message is: \n %s',err.message);
fclose(fp);
beep
fprintf(2,'??? %s\n',err.message);
fprintf(2,'Error in  ==> %s at %d\n\n\n',err.stack(1).name, err.stack(1).line);



for(i =  2:length(err.stack))
    fprintf(2,'Error in  ==> %s at %d\n\n\n',err.stack(i).name, err.stack(i).line);
    
end

%If running windows bring back the taskbar after crashing
try
    if ispc
        try
            ShowHideWinTaskbarMex(1);
        catch ME
            ShowHideFullWinTaskbarMex(1);
        end
    end
end
end