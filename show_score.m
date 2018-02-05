% load('wheel360');
function [add scorecolormatrix] = show_score(segment_score,add,scorecolormatrix,win,seg_values,color_response,change_spot)
if add ==0
% load('pointsWheelLocations');

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
% segment_score(selected_row,2) - 30;

[score_row,w,x] = find(seg_values==seg_score_currentpoint);

% current_row = 1;
% testwheel = 0;
for wheel = 1:360
    [current_row,w,x]=find(seg_values==wheel);
    if current_row == score_row
        if win
%             testwheel = testwheel + 1;
%             seg_score_currentpoint-seg_score_startingpoint+30;
%             for i = 1:(seg_score_currentpoint-seg_score_startingpoint+30)
%             scorecolormatrix(seg_score_startingpoint+i-30,:) = [255 255 0];
%             end
        scorecolormatrix(seg_score_currentpoint,:) = [255 255 0];
        else
%             testwheel = testwheel -1;
        scorecolormatrix(seg_score_currentpoint,:) = [255 0 0];
        end
%     else
%         selected_segment(wheel,:) = Parameters.backgroundcolor - 75;
    end
end
add=1;
% save('segment_score','segment_score');
save('scorecolormatrix','scorecolormatrix');
% save('pointsWheelLocations','scorecolormatrix');
% save('pointsWheelLocations','pointsWheelLocations','scorecolormatrix','seg_values','change_spot','color_response','win','selected_row','add');
end