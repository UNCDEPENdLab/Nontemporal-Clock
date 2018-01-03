% function
% show_selected_segment(seg_values,color_response)

load('wheel360');

[selected_row,w,x]=find(seg_values==color_response);

current_row = 1;
for wheel = 1:num_wheel_boxes
    [current_row,w,x]=find(seg_values==wheel);
    if current_row == selected_row
        selected_segment(wheel,:) = fullcolormatrix(wheel,:);
    else
        selected_segment(wheel,:) = Parameters.backgroundcolor;
    end
end
% sca;keyboard
save('selected_segment','selected_segment');

% end