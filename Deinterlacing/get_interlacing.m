function frame = get_interlacing(curr_frame, curr_frame_no)
% Description: Returns frame with gaps where the corresponding interlacing
% is occuring
% Input: curr_frame: Frame where blank rows representing interlacing are
% ommitted
%        curr_frame_no: To check if even or odd
% Output: frame: Frame with empty rows where the corresponding deinterlacing
% is to be done
    [rows, cols, ch] = size(curr_frame);
    frame = zeros(rows*2, cols, ch); % Final frame will have twice the number of rows
    r = 1;
    for i = 1:rows*2
        if mod(curr_frame_no, 2) ~= 0 % odd frame 1-3-5
            if mod(i,2) ~=0 % odd rows 1-3-5
                frame(i,:,:) = curr_frame(r,:,:);
                r = r+1;
            else 
                frame(i,:,:) = 0;
            end
        else
            if mod(i,2) ~=0 % odd rows 1-3-5
                frame(i,:,:) = 0;
            else
                frame(i,:,:) = curr_frame(r,:,:);
                r = r+1;
            end
        end
    end
end