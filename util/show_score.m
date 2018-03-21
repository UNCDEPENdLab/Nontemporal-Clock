function [add] = show_score(segment_score,add,scorecolormatrix,scorecolormatrix2,win,seg_values,segment_response,change_spot,Trial,num_wheel_boxes,num_segments,change_trial2)

if ~add
    
    global scorewheelcolor
    
    persistent seg_scorekeeper seg_scorekeeper2 firstslotcolor firstslotcolor2
    
    if Trial == change_trial2
        clear seg_scorekeeper seg_scorekeeper2 firstslotcolor firstslotcolor2
        scorecolormatrix = repmat(scorewheelcolor,num_wheel_boxes,3);
        for add_partition = 1:num_segments
            if add_partition == num_segments
                scorecolormatrix(359,:) = [0 0 0];
            else
                scorecolormatrix(change_spot(add_partition)-1,:) = [0 0 0];
            end
        end
        for add_partition = 1:num_segments
            if add_partition == num_segments
                scorecolormatrix2(359,:) = [0 0 0];
            else
                scorecolormatrix2(change_spot(add_partition)-1,:) = [0 0 0];
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
    try
        if seg_score_currentpoint < 1; seg_score_currentpoint = 1;end
        if selected_row == 1
        if current_seg_score <= score_offset+1
            seg_scorekeeper(seg_score_currentpoint) = win + 1;
        elseif current_seg_score == score_offset+2
            seg_scorekeeper2(seg_score_currentpoint-(score_offset*2)-1) = win+1;
        else
            seg_scorekeeper2(seg_score_currentpoint-(score_offset*2)-2) = win+1;
        end
        else
            if current_seg_score <= score_offset
                seg_scorekeeper(seg_score_currentpoint) = win + 1;
            else
                seg_scorekeeper2(seg_score_currentpoint-(score_offset*2)) = win+1;
            end
        end
    catch
        sca;keyboard
    end
    
    win_color_value = 145;
    
    for i = 1:length(seg_scorekeeper)
        if seg_scorekeeper(i) > 0
            [score_row,w,x] = find(seg_values==i);
            for wheel = 1:360
                [current_row,w,x]=find(seg_values==wheel);
                if current_row == score_row
                    if seg_scorekeeper(i) == 2
                        scorecolormatrix(i,:) = [255 255 0];
                    else
                        scorecolormatrix(i,:) = [240 0 0];
                    end
                    if score_row == 1 && segment_score(selected_row,2) == 1
                        firstslotcolor = scorecolormatrix(i,:);
                    else
                        scorecolormatrix(i+1,:) = repmat(scorewheelcolor,1,3);
                    end
                end
            end
        end
    end
    
    for add_partition = 1:num_segments
        if add_partition == num_segments
            scorecolormatrix(359,:) = [0 0 0];
        else
            scorecolormatrix(change_spot(add_partition)-1,:) = [0 0 0];
        end
    end
    
    try
        scorecolormatrix(360,:) = firstslotcolor;
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
                            scorecolormatrix2(i,:) = [255 255 0];
                        else
                            scorecolormatrix2(i,:) = [240 0 0];
                        end
                        if score_row == 1 && segment_score(selected_row,2) == score_offset+2
                            firstslotcolor2 = scorecolormatrix2(i,:);
                        else
                            scorecolormatrix2(i+1,:) = repmat(scorewheelcolor,1,3);
                        end
                    end
                end
            end
        end
    end
    
    for add_partition = 1:num_segments
        if add_partition == num_segments
            scorecolormatrix2(359,:) = [0 0 0];
        else
            scorecolormatrix2(change_spot(add_partition)-1,:) = [0 0 0];
        end
    end
    
    try
        scorecolormatrix2(360,:) = firstslotcolor2;
        scorecolormatrix2(1,:) = repmat(scorewheelcolor,1,3);
    end
    
    csvwrite('scorecolormatrix2.csv',scorecolormatrix2);
    
    add=1;
    
end