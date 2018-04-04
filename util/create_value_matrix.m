col_count = 1; row_count = 0;
for i = 1:(num_wheel_boxes*num_rings)
    row_count = row_count + 1;
    if ~mod(i-1,num_wheel_boxes) && i ~= 1
        col_count = col_count + 1;
        row_count = 1;
    end
    value_matrix(row_count,col_count) = i;
end