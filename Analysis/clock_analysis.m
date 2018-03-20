cd ..
load data/ExpSub902.mat
fourbotcount = 0;
fourbot_matrix = zeros(8,1);
for trial = 1:length(FullUserdata.Blocks.Trials)
    
    if FullUserdata.Blocks.Trials(trial).Trial_Export.bot_mode && trial >1
        if FullUserdata.Blocks.Trials(trial).Trial_Export.pos_bot_choices == 4
            fourbotcount = fourbotcount + 1;
            fourbot_selected_segments_trial(fourbotcount) = FullUserdata.Blocks.Trials(trial).Trial_Export.selected_seg;
        fourbot_matrix(fourbot_selected_segments(fourbotcount),1)=1;
        end
    end
    
%     if FullUserdata.Blocks.Trials(
    
end
fourbot_selected_segments_all = (find(fourbot_matrix==1))';
cd Analysis
keyboard