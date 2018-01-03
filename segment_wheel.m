function [seg_values] = segment_wheel(num_segments,seg_colors)
%This function creates a 360 degree color wheel, segmented by distinct colors

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Enter the number of segments you want to create
if nargin < 1
num_segments = 12;
seg_colors{1} = [0 0 0];
seg_colors{2} = [255 255 255];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_wheel_boxes = 360;
fullcolormatrix = zeros(num_wheel_boxes,3);
boxes_in_segment = num_wheel_boxes/num_segments;

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

save('wheel360','fullcolormatrix','num_wheel_boxes');

end