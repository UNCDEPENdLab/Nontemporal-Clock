global scorewheelcolor

load('wheel360');

[selected_row,w,x]=find(seg_values==segment_response);

cut_count = 0;
for wheel = 1:num_wheel_boxes
    [current_row,w,x]=find(seg_values==wheel);
    if current_row == selected_row
        if add_wheel_borders
            selected_segment(wheel,:) = seg_colors{1};
            if current_row == size(seg_values,1) && size(seg_values,1) == 4
                cut_count = cut_count + 1;
                if cut_count > 88
                    selected_segment(wheel,:) = repmat(scorewheelcolor,1,3);
                end
            end
            for add_partition = 1:num_segments
                if add_partition == num_segments
                    fullcolormatrix(359,:) = [0 0 0];
                else
                    fullcolormatrix(change_spot(add_partition)-1,:) = [0 0 0];
                end
            end
        else
            selected_segment(wheel,:) = fullcolormatrix(wheel,:);
        end
    else
        selected_segment(wheel,:) = repmat(scorewheelcolor,1,3);
    end
    if selected_row == 1
        for j = 1:30
            selected_segment(j,:) = seg_colors{1};
        end
        for k = 359:360
            selected_segment(k,:) = seg_colors{1};
        end
    end
end

save('selected_segment','selected_segment');