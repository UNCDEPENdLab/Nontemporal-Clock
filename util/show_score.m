% load('wheel360');
function [add] = show_score(segment_score,add,scorecolormatrix,win,seg_values,color_response,change_spot,Trial)
if add ==0
    % load('pointsWheelLocations');
    
    persistent seg_scorekeeper
    
    if Trial == 1
        clear seg_scorekeeper
    end
    
    csvwrite('segment_score',segment_score);
    
    [selected_row,w,x]=find(seg_values==color_response);
    % selected_row;
    
    seg_score_startingpoint = change_spot(selected_row) - 1;
    
    % if add == 0
    current_seg_score = segment_score(selected_row,2);
    % current_seg_score = current_seg_score + 1;
    % % add = 1;
    % end
    % segment_score(selected_row,2) = current_seg_score;
    seg_score_currentpoint = seg_score_startingpoint +  current_seg_score - 30;
    seg_scorekeeper(seg_score_currentpoint)=win+1;
    % segment_score(selected_row,2) - 30;
    
%     if sum(seg_scorekeeper)>6
%         sca;keyboard
%     end
    
    for i = 1:length(seg_scorekeeper)
        if seg_scorekeeper(i) > 0
            [score_row,w,x] = find(seg_values==i);
            for wheel = 1:360
                [current_row,w,x]=find(seg_values==wheel);
                if current_row == score_row
                    if seg_scorekeeper(i) == 2
                        %             testwheel = testwheel + 1;
                        %             seg_score_currentpoint-seg_score_startingpoint+30;
                        %             for i = 1:(seg_score_currentpoint-seg_score_startingpoint+30)
                        %             scorecolormatrix(seg_score_startingpoint+i-30,:) = [255 255 0];
                        %             end
                        scorecolormatrix(i,:) = [255 255 0];
                    else
                        %             testwheel = testwheel -1;
                        scorecolormatrix(i,:) = [255 0 0];
                    end
                    %     else
                    %         selected_segment(wheel,:) = Parameters.backgroundcolor - 75;
                end
            end
        end
    end
                            csvwrite('scorecolormatrix.csv',scorecolormatrix);

%     if length(seg_scorekeeper) > 1
%     sca;keyboard
%     end
%     [score_row,w,x] = find(seg_values==seg_score_currentpoint);
%     
%     % current_row = 1;
%     % testwheel = 0;
%     for wheel = 1:360
%         [current_row,w,x]=find(seg_values==wheel);
%         sca;keyboard
%         if current_row == score_row
%             if win
%                 %             testwheel = testwheel + 1;
%                 %             seg_score_currentpoint-seg_score_startingpoint+30;
%                 %             for i = 1:(seg_score_currentpoint-seg_score_startingpoint+30)
%                 %             scorecolormatrix(seg_score_startingpoint+i-30,:) = [255 255 0];
%                 %             end
%                 scorecolormatrix(seg_score_currentpoint,:) = [255 255 0];
%                 csvwrite('scorecolormatrix.csv',scorecolormatrix);
%             else
%                 %             testwheel = testwheel -1;
%                 scorecolormatrix(seg_score_currentpoint,:) = [255 0 0];
%                 csvwrite('scorecolormatrix.csv',scorecolormatrix);
%             end
%             %     else
%             %         selected_segment(wheel,:) = Parameters.backgroundcolor - 75;
%         end
%     end
    add=1;
    % save('segment_score','segment_score');
    % csvwrite('scorecolormatrix.csv',scorecolormatrix);
    % save('scorecolormatrix','scorecolormatrix');
    % save('pointsWheelLocations','scorecolormatrix');
    % save('pointsWheelLocations','pointsWheelLocations','scorecolormatrix','seg_values','change_spot','color_response','win','selected_row','add');
end