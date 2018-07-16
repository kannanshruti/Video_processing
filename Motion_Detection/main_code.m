% Description: 
%% Image reading

img1_a = imread('missa_1.tif');
img1_b = imread('missa_50.tif');

img2_a = imread('container_1.tif');
img2_b = imread('container_30.tif');

img3_a = imread('coastguard_90.tif');
img3_b = imread('coastguard_95.tif');

%% Fixed Threshold

variance_s = 15;
theta = 1;

fixed_res1 = fixed_threshold(img1_a, img1_b, variance_s, theta);
fixed_res2 = fixed_threshold(img2_a, img2_b, variance_s, theta);
fixed_res3 = fixed_threshold(img3_a, img3_b, variance_s, theta);

%% Variable threshold - 1st order

sigma_ratio = 5;
T = 10;
var1_res1 = variable_thres_1(img1_a, img1_b, sigma_ratio, T, variance_s, theta);
var1_res2 = variable_thres_1(img2_a, img2_b, sigma_ratio, T, variance_s, theta);
var1_res3 = variable_thres_1(img3_a, img3_b, sigma_ratio, T, variance_s, theta);

%% Variable threshold - 2nd order

var2_res1 = variable_thres_2(img1_a, img1_b, sigma_ratio, T, variance_s, theta);
var2_res2 = variable_thres_2(img2_a, img2_b, sigma_ratio, T, variance_s, theta);
var2_res3 = variable_thres_2(img3_a, img3_b, sigma_ratio, T, variance_s, theta);

%% Plots

figure(1);
subplot(2,2,1), subimage(img1_a);
title('Original missa');
subplot(2,2,2), subimage(fixed_res1);
title('Fixed Threshold');
subplot(2,2,3), subimage(var1_res1);
title('Variable Threshold 1st order');
subplot(2,2,4), subimage(var2_res1);
title('Variable Threshold 2nd order');

figure(2);
subplot(2,2,1), subimage(img2_a);
title('Original Container');
subplot(2,2,2), subimage(fixed_res2);
title('Fixed Threshold');
subplot(2,2,3), subimage(var1_res2);
title('Variable Threshold 1st order');
subplot(2,2,4), subimage(var2_res2);
title('Variable Threshold 2nd order');

figure(3);
subplot(2,2,1), subimage(img3_a);
title('Original Coastguard');
subplot(2,2,2), subimage(fixed_res3);
title('Fixed Threshold');
subplot(2,2,3), subimage(var1_res3);
title('Variable Threshold 1st order');
subplot(2,2,4), subimage(var2_res3);
title('Variable Threshold 2nd order');

%% Video
v = VideoReader('street.mp4');
numframes = v.FrameRate*v.Duration;

v1 = VideoWriter('var_threshold2.avi');
open(v1);
for k = 2 : numframes  
    img_a = read(v, k-1);
    img_a = rgb2gray(img_a);

    img_b = read(v,k);
    img_b = rgb2gray(img_b);
%     fixed_vid = fixed_threshold(img_a, img_b, variance_s, theta);
%     var1_vid = variable_thres_1(img_a, img_b, sigma_ratio, T, variance_s, theta);
    var2_vid = variable_thres_2(img_a, img_b, sigma_ratio, T, variance_s, theta);
    writeVideo(v1, var2_vid);
end
close(v1);