function [F] = make_movie(folder, no_frames)
% Description: Creates a structure of frames
% Input: folder: folder containing the image frames
%        no_frames: number of frames
% Output: F: Struct with the movie frames
    F(no_frames) = struct('cdata', [], 'colormap', []);
    for i = 1:no_frames
        filename = strcat(folder, '/', folder, '_' , int2str(i), '.tif');
        frame = imread(filename);
        imshow(frame);
        F(i) = getframe;
    end
end