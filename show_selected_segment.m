% function
% show_selected_segment(seg_values,color_response)

load('wheel360');

[selected_row,w,x]=find(seg_values==segment_response);

current_row = 1;
for wheel = 1:num_wheel_boxes
    [current_row,w,x]=find(seg_values==wheel);
    if current_row == selected_row
        if add_wheel_borders
            selected_segment(wheel,:) = seg_colors{1};
            for add_partition = 1:num_segments
                if add_partition == num_segments
                    fullcolormatrix(1,:) = [0 0 0];
                else
                    try
                        fullcolormatrix(change_spot(add_partition)-1,:) = [0 0 0];
                    end
                end
            end
        else
            selected_segment(wheel,:) = fullcolormatrix(wheel,:);
        end
    else
%         if add_wheel_borders
%             selected_segment(wheel,:) = Parameters.backgroundcolor;
%         else
            selected_segment(wheel,:) = Parameters.backgroundcolor - 75;
%         end
    end
end
% sca;keyboard
save('selected_segment','selected_segment');

% end