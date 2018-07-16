function F_out = get_interlaced_movie(F_in, no_frames)
% Description: Creates a structure of frames, with gaps for de-interlacing
% Input: F_in: Input struct with the interlaced frames
%        no_frames: number of frames
% Output: F_out: Struct with the de-interlaced movie frames
    F_out(no_frames) = struct('cdata', [], 'colormap', []);
    for i = 1:no_frames 
        inter_frame = uint8(get_interlacing(F_in(i).cdata, i));
        imshow(inter_frame);
        title('Interlaced frames');
        F_out(i) = getframe;
    end
end