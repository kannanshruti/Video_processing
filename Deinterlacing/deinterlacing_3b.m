% Description: Applying interlacing filters to frames from a video

%% Create empty rows in the interlaced frames for where the deinterlacing is to be done
folder = 'horses_interl';
directory = dir(strcat(folder, '/*.tif'));
no_frames = numel(directory);
F = make_movie(folder, no_frames);
F1 = get_interlaced_movie(F, no_frames);
movie(F1);

%% Own attempt - Vertical 2line filter
F2 = F1;
h = [1/2, 1, 1/2];
[rows, ~] = size(F1(1).cdata);
for frame = 1:no_frames
    for row = 1:rows*2
       if (row-1 < 1) || (row+1 > rows)
           continue
       end
       F2(frame).cdata(row,:,:) = F2(frame).cdata(row-1,:,:)*h(1) + ...
           F2(frame).cdata(row,:,:)*h(2) + ...
           F2(frame).cdata(row+1,:,:)*h(3);
    end
end
figure;
title('Vertical 2 line averaging');
axis off;
movie(F2)
mse_2line_2 = compute_mse(F2, F3, no_frames)

%% True Progressive result
figure;
F3 = make_movie('birds_prog', no_frames);
movie(F3); % for comparison

%% Vertical 2-line averaging
b = [0.5; 1; 0.5];
a = [1];
F4(no_frames) = struct('cdata', [], 'colormap', []);
figure(1);
for i = 1:no_frames
    y = filter(b,a,double(F1(i).cdata),[],1);
    imshow(uint8(y));
    title('Vertical 2 line averaging')
    F4(i) = getframe;
end
figure(2);
movie(F4)

mse_2line = compute_mse(F4, F3, no_frames)

%% Vertical 4-line averaging
b = [1/16, 0, 7/16, 1, 7/16, 0, 1/16];
a = [1];
F5(no_frames) = struct('cdata', [], 'colormap', []);
for i = 1:no_frames
    y = filter(b,a,double(F1(i).cdata),[],1);
    imshow(uint8(y));
    F5(i) = getframe;
end
figure;
title('Vertical 4 line averaging');
axis off;
movie(F5)
mse_4line = compute_mse(F5, F3, no_frames);

%% vertical 4-line own
h = [1/16, 0, 7/16, 1, 7/16, 0, 1/16];
F13(no_frames) = struct('cdata', [], 'colormap', []);
for frame = 1:no_frames
    for row = 1:rows
       if (row-3<1 || row-1 < 1 || row+1 > rows || row+3 > rows)
           F13(frame).cdata(row,:,:) = uint8(F1(frame).cdata(row,:,:));
           continue
       end
       F13(frame).cdata(row,:,:) = F1(frame).cdata(row-3,:,:)*h(1) + ...
           F1(frame).cdata(row-1,:,:)*h(3) + ...
           F1(frame).cdata(row,:,:)*h(4) + ...
           F1(frame).cdata(row+1,:,:)*h(5) + ...           
           F1(frame).cdata(row+3,:,:)*h(7) ;
    end
end
figure;
title('Vertical 4 line averaging');
axis off;
movie(F13)
mse_4line_2 = compute_mse(F13, F3, no_frames);

%% Temporal zero hold
b = [0;1;1];
a = [1];
F6(no_frames) = struct('cdata', [], 'colormap', []);
for i = 1:no_frames
    y = filter(b,a,double(F1(i).cdata),[],1);
    imshow(uint8(y));
    F6(i) = getframe;
end
figure;
title('Temporal zero-hold');
axis off;
movie(F6)
mse_0hold = compute_mse(F6, F3, no_frames)

%% Temporal zero hold own
h = [0,1,1];
F9(no_frames) = struct('cdata', [], 'colormap', []);
for frame = 2:no_frames
    for row = 1:rows
       if (frame-1 < 2) || (frame+1 > no_frames)
           F9(frame).cdata(row,:,:) = F1(frame).cdata(row,:,:);
           continue
       end
       F9(frame).cdata(row,:,:) = F1(frame-1).cdata(row,:,:).*h(1) + ...
           F1(frame).cdata(row,:,:)*h(2) + ...
           F1(frame+1).cdata(row,:,:)*h(3);
    end
end
figure;
title('Temporal zero-hold');
axis off;
movie(F9)
mse_0hold_2 = compute_mse(F9, F3, no_frames)

%% Temporal 2-field averaging
b = [1/2,1,1/2];
a = [1];
F7(no_frames) = struct('cdata', [], 'colormap', []);
for i = 1:no_frames
    y = filter(b,a,double(F1(i).cdata));
    imshow(uint8(y));
    F7(i) = getframe;
end
figure;
title('Temporal 2-field averaging');
axis off;
movie(F7)
mse_2field = compute_mse(F7, F3, no_frames)

%% Temporal 2-field averaging own
h = [1/2, 1, 1/2];
F8(no_frames) = struct('cdata', [], 'colormap', []);
for frame = 1:no_frames
    for row = 1:rows
       try
           if (frame-1 < 2) || (frame+1 > no_frames)
           F8(frame).cdata(row,:,:) = F1(frame).cdata(row,:,:);
           continue
           end
       catch
           continue
       end
       F8(frame).cdata(row,:,:) = F1(frame-1).cdata(row,:,:).*h(1) + ...
           F1(frame).cdata(row,:,:)*h(2) + ...
           F1(frame+1).cdata(row,:,:)*h(3);
    end
end
figure;
title('Temporal 2-field averaging');
axis off;
movie(F8)
mse_2field_2 = compute_mse(F8, F3, no_frames)

%% spatio-temporal non causal
b = [0,1/4,0;1/4,1,1/4;0,1/4,0];
a = [1];
F10(no_frames) = struct('cdata', [], 'colormap', []);
for i = 1:no_frames
%     y = filter2(b,double(F1(i).cdata));
    for j = 1:3
        aa = filter2(b, double(F1(i).cdata(:,:,j)));
        y(1:size(aa,1),1:size(aa,2),j) = aa;
    end
    imshow(uint8(y));
    F10(i) = getframe;
end
figure;
title('joint non causal');
axis off;
movie(F10)
mse_jointc = compute_mse(F10, F3, no_frames)

%%
h = [0,1/4,0;1/4,1,1/4;0,1/4,0];
F11(no_frames) = struct('cdata', [], 'colormap', []);
for frame = 1:no_frames
    for row = 1:rows
        for h_ind = 1:3
           if (row-1 < 1) || (row+1 > rows || frame-1 < 1) || (frame+1 > no_frames)
               continue
           end
           F11(frame).cdata(row,:,:) = F1(frame).cdata(row-1,:,:)*h(1,h_ind) + ...
               F1(frame).cdata(row,:,:)*h(2,h_ind) + ...
               F1(frame).cdata(row+1,:,:)*h(3,h_ind) + ...
               F1(frame-1).cdata(row,:,:).*h(h_ind,1) + ...
               F1(frame).cdata(row,:,:)*h(h_ind,2) + ...
               F1(frame+1).cdata(row,:,:)*h(h_ind,3);
        end
    end
end
movie(F11)

%% spatio-temporal causal
b = [0,-1,0; 0,0,0; 0,9,0; 0,32,16; 0,9,0; 0,0,0; 0,-1,0]/32;
a = [1];
F12(no_frames) = struct('cdata', [], 'colormap', []);
for i = 1:no_frames
%     y = filter2(b,double(F1(i).cdata));
    for j = 1:3
        aa = filter2(b, double(F1(i).cdata(:,:,j)));
        y(1:size(aa,1),1:size(aa,2),j) = aa;
    end
    imshow(uint8(y));
    F12(i) = getframe;
end
figure;
title('joint causal');
axis off;
movie(F12)
mse_jointnc = compute_mse(F12, F3, no_frames)