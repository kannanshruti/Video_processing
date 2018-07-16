% Description: Motion estimation by Phase correlation

img1a = double(imread('Fall_trees_0.tif'));
img1b = double(imread('Fall_trees_5.tif'));
[rows, cols] = size(img1a);

%% Phase correlation on the whole image
[max3_fullimage, ~, R_tilda] = phase_correlation(img1b, img1a);
R1 = fftshift(R_tilda);

x = 1:cols;
y = 1:rows;
[X,Y] = meshgrid(x,y);
scatter3(x,y,R1);
plot3(X,Y,R1)

%% Phase correlation on blocks in the image
N = 32; % Block size
max3_blocks32 = phase_correlation_blocks(img1a, img1b, N);

tmp = 1; % temporary variable to increment row number
for i = 2:size(max3_blocks32,1) % Storing more points per block for plotting vector field
    vector_field(tmp,1:10) = max3_blocks32(i-1,1:10);
    vector_field(tmp+1,1) = max3_blocks32(i-1,1) + 4;
    vector_field(tmp+1,2) = max3_blocks32(i-1,2);
    vector_field(tmp+2,1) = max3_blocks32(i-1,1);
    vector_field(tmp+2,2) = max3_blocks32(i-1,2) + 4;
    vector_field(tmp+3,1:10) = max3_blocks32(i-1,1:10) + 4;
    vector_field(tmp+1:tmp+3,3:10) = repmat(max3_blocks32(i-1,3:10),3,1);
    tmp = tmp+4;
end

fig = figure;
quiver(vector_field(:,1), vector_field(:,2), vector_field(:,9), vector_field(:,10),0);
camroll(-90);
figure, imshow(fftshift(R_tilda))