function [add] = show_score(segment_score,add,scorecolormatrix,scorecolormatrix2,win,seg_values,segment_response,change_spot,Trial,num_wheel_boxes,num_segments)

if ~add
    
    if Trial == 1
        clear seg_scorekeeper seg_scorekeeper2
    end
    
    global scorewheelcolor
    
    persistent seg_scorekeeper seg_scorekeeper2 firstslotcolor firstslotcolor2
    
    csvwrite('segment_score',segment_score);
    load('seg_values','seg_values');
    [selected_row,w,x]=find(seg_values==segment_response);
    
    seg_score_startingpoint = change_spot(selected_row) - 1;
    
    current_seg_score = segment_score(selected_row,2);
    
    if current_seg_score == 1
        seg_score_currentpoint = seg_score_startingpoint +  current_seg_score - num_wheel_boxes/num_segments;
    else
        seg_score_currentpoint = seg_score_startingpoint +  current_seg_score - num_wheel_boxes/num_segments + current_seg_score - 1;
    end
    
    if selected_row == 1 && current_seg_score > 1
        seg_score_currentpoint = seg_score_startingpoint +  current_seg_score - num_wheel_boxes/num_segments + current_seg_score - 2;
    end
    
    score_offset = 22;
    if seg_score_currentpoint < 1; seg_score_currentpoint = 1;end
    if current_seg_score < score_offset
        seg_scorekeeper(seg_score_currentpoint) = win + 1;
    else
        seg_scorekeeper2(seg_score_currentpoint-(score_offset*2-2)) = win+1;
    end
    
%     csvwrite('seg_scorekeeper',seg_scorekeeper);
%     csvwrite('seg_scorekeeper',seg_scorekeeper2);
    
    win_color_value = 145;
    
    for i = 1:length(seg_scorekeeper)
        if seg_scorekeeper(i) > 0
            [score_row,w,x] = find(seg_values==i);
            for wheel = 1:360
                [current_row,w,x]=find(seg_values==wheel);
                if current_row == score_row
                    if seg_scorekeeper(i) == 2
                        %                         scorecolormatrix(i,:) = repmat(win_color_value,1,3);
                        scorecolormatrix(i,:) = [255 255 0];
                    else
                        scorecolormatrix(i,:) = [240 0 0];
                    end
                    if score_row == 1 && segment_score(selected_row,2) == 1
                        %                         scorecolormatrix(360,:) = scorecolormatrix(i,:);
                        %                         scorecolormatrix(1,:) = repmat(scorewheelcolor,1,3);
                        %                         scorecolormatrix(i+1,:) = [255 255 255];
                        firstslotcolor = scorecolormatrix(i,:);
                    else
                        %                         scorecolormatrix(i+1,:) = scorecolormatrix(i,:);
                        scorecolormatrix(i+1,:) = repmat(scorewheelcolor,1,3);
                    end
                end
            end
        end
    end
    
    try
        scorecolormatrix(360,:) = firstslotcolor;
        %         repmat(scorewheelcolor,1,3);
        %         scorecolormatrix(1,:) = firstslotcolor;
        scorecolormatrix(1,:) = repmat(scorewheelcolor,1,3);
    end
    
    csvwrite('scorecolormatrix.csv',scorecolormatrix);
    
    try
    for i = 1:length(seg_scorekeeper2)
        if seg_scorekeeper2(i) > 0
            [score_row,w,x] = find(seg_values==i);
            for wheel = 1:360
                [current_row,w,x]=find(seg_values==wheel);
                if current_row == score_row
                    if seg_scorekeeper2(i) == 2
                        %                         scorecolormatrix(i,:) = repmat(win_color_value,1,3);
                        scorecolormatrix2(i,:) = [255 255 0];
                    else
                        scorecolormatrix2(i,:) = [240 0 0];
                    end
                    if score_row == 1 && segment_score(selected_row,2) == 1
                        %                         scorecolormatrix(360,:) = scorecolormatrix(i,:);
                        %                         scorecolormatrix(1,:) = repmat(scorewheelcolor,1,3);
                        %                         scorecolormatrix(i+1,:) = [255 255 255];
                        firstslotcolor2 = scorecolormatrix2(i,:);
                    else
                        %                         scorecolormatrix(i+1,:) = scorecolormatrix(i,:);
                        scorecolormatrix2(i+1,:) = repmat(scorewheelcolor,1,3);
                    end
                end
            end
        end
    end
    catch
        sca;keyboard
    end
    try
        scorecolormatrix2(360,:) = firstslotcolor2;
        %         repmat(scorewheelcolor,1,3);
        %         scorecolormatrix(1,:) = firstslotcolor;
        scorecolormatrix2(1,:) = repmat(scorewheelcolor,1,3);
    end
    
    csvwrite('scorecolormatrix2.csv',scorecolormatrix2);    
    
    add=1;
    
end