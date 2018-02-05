function [seg_values scorecolormatrix change_spot num_wheel_boxes] = segment_wheel(num_segments,seg_colors,add_wheel_borders)
%This function creates a 360 degree color wheel, segmented by distinct colors

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Enter the number of segments you want to create
if nargin < 1
    num_segments = 12;
    seg_colors{1} = [0 0 0];
    seg_colors{2} = [255 255 255];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_wheel_boxes = 359;
fullcolormatrix = zeros(num_wheel_boxes,3);
boxes_in_segment = round(num_wheel_boxes/num_segments);

for add_seg = 1:num_segments
    change_spot(add_seg) = boxes_in_segment*add_seg+1;
    if add_seg == 1
        seg_values(add_seg,:) = 1:change_spot(add_seg)-1;
    else
        seg_values(add_seg,:) = change_spot(add_seg-1):change_spot(add_seg)-1;
    end
end

spot = 1;
for box = 1:num_wheel_boxes
    
    if box >= change_spot(spot)
        spot = spot + 1;
    end
    
    box_color = seg_colors{mod(spot,2)+1};
    
    fullcolormatrix(box,:) = box_color;
    
end
% sca;keyboard
if add_wheel_borders
    num_wheel_boxes = 359;
%     fullcolormatrix = repmat(180,num_wheel_boxes,3);
    for add_partition = 1:num_segments
        if add_partition == num_segments
            fullcolormatrix(1,:) = [0 0 0];
        else
            try
                fullcolormatrix(change_spot(add_partition)-1,:) = [0 0 0];
                %         catch
                %             sca;keyboard
            end
        end
    end
end

scorecolormatrix = repmat(180,359,3);
for add_partition = 1:num_segments
    if add_partition == num_segments
        scorecolormatrix(1,:) = [0 0 0];
    else
        try
            scorecolormatrix(change_spot(add_partition)-1,:) = [0 0 0];
            %         catch
            %             sca;keyboard
        end
    end
end

save('wheel360','fullcolormatrix','num_wheel_boxes');

end