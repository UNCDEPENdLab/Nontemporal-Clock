function [add] = show_score(segment_score,add,scorecolormatrix,win,seg_values,color_response,change_spot,Trial)

persistent seg_scorekeeper

if add ==0
    
    if Trial == 1
        clear seg_scorekeeper
    end
    
    csvwrite('segment_score',segment_score);
    
    [selected_row,w,x]=find(seg_values==color_response);
    
    seg_score_startingpoint = change_spot(selected_row) - 1;
    
    current_seg_score = segment_score(selected_row,2);
    seg_score_currentpoint = seg_score_startingpoint +  current_seg_score - 30;
    
    seg_scorekeeper(seg_score_currentpoint)=win+1;
    
    for i = 1:length(seg_scorekeeper)
        if seg_scorekeeper(i) > 0
            [score_row,w,x] = find(seg_values==i);
            for wheel = 1:360
                [current_row,w,x]=find(seg_values==wheel);
                if current_row == score_row
                    if seg_scorekeeper(i) == 2
                        scorecolormatrix(i,:) = [255 255 0];
                    else
                        scorecolormatrix(i,:) = [255 0 0];
                    end
                end
            end
        end
    end
    
    csvwrite('scorecolormatrix.csv',scorecolormatrix);
    
    add=1;
    
end