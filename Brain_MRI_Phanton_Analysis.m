clear all;
clc;
close all;


% Create the modified Shepp-Logan phantom image
P = phantom('Modified Shepp-Logan', 200);
figure;
subplot(121);
imshow(P);
colorbar
colormap(gray)
title('Brain-Simulating Digital Phantom with 10 Ellipses');


% Define the parameters for the first 7 ellipses
E = [
     1,   0.69,   0.92,  0,    0,       0;    
   -0.8,  0.662,  0.874, 0,   -0.0184,  0;    
   -0.2,  0.11,   0.31,  0.22, 0,      -18;    
   -0.2,  0.16,   0.41, -0.22, 0,       18;    
    0.1,  0.21,   0.25,  0,    0.35,    0;    
    0.1,  0.046,  0.046, 0,    0.1,     0;    
    0.1,  0.046,  0.046, 0,   -0.1,     0   
];

% Generate the phantom image
n = 128;  
P = phantom(E, n);
subplot(122);
imshow(P);
colorbar;
colormap(gray);
title('Brain-Simulating Digital Phantom with 7 Ellipses');


%% 

% Q2-a

% Parameters for the first 7 ellipses with modified Proton densities
E_PD = [
    0.9,   0.69,   0.92,  0,    0,      0;    
   -0.1,  0.662,  0.874, 0,    -0.0184, 0;    
    0.2,  0.11,   0.31,  0.22,  0,     -18;    
    0.2,  0.16,   0.41, -0.22,  0,      18;    
   -0.1,  0.21,   0.25,  0,     0.35,   0;    
    0  ,  0.046,  0.046, 0,     0.1,    0;    
    0  ,  0.046,  0.046, 0,    -0.1,    0   
];

% Generate the phantom image
n=128;
Ph_PD = phantom(E_PD, n);
figure;
imshow(Ph_PD);
colorbar;
colormap(gray);
title('PD Map with Modified Intensities');

%%

% Parameters for the first 7 ellipses with modified T2
E_T2 = [
    300,  0.69,   0.92,  0,     0,      0;    
   -220,  0.662,  0.874, 0,    -0.0184, 0;    
    420,  0.11,   0.31,  0.22,  0,     -18;    
    420,  0.16,   0.41, -0.22,  0,      18;    
   -10 ,  0.21,   0.25,  0,     0.35,   0;    
    20 ,  0.046,  0.046, 0,     0.1,    0;    
    20 ,  0.046,  0.046, 0,    -0.1,    0   
];

% Generate the phantom image
n=128;
Ph_T2 = phantom(E_T2, n);
figure;
imshow(Ph_T2, []);
colorbar;
colormap(gray);
title('T2 Map with Modified Intensities');

%%

% Define the TE values
TE = 10:20:200;

% Mean for the Gaussian noise
Gau = 4;
m = (5*Gau + 5)/100;
images = zeros([size(Ph_PD), length(TE)]);

% Generate the images
figure;
for i = 1:length(TE)
    I = Ph_PD .* exp(-TE(i)./Ph_T2);
    I = imnoise(I, 'gaussian', 0, m);
    images(:,:,i) = I;
    subplot(2, ceil(length(TE)/2), i);
    imshow(images(:,:,i), []);
    colorbar;
    colormap(gray);
    title(['TE = ', num2str(TE(i))]);
end
sgtitle(sprintf('Set of 10 images with gaussian noise\nPrajwal Mohan, ID-1232306844'));


%%

%Define function
func = @(x, TE) x(1) .* exp(-TE ./ x(2));
x0 = [0.5, 1];

% Reshape the image
[nRows, nCols, nTE] = size(images);
reshaped_images = reshape(images, [], nTE);

options = optimoptions('lsqcurvefit','Display','off');
PD_map = zeros(nRows, nCols);

% Voxel wise fit
for i = 1:nRows
    for j = 1:nCols
        intensities_PD = reshaped_images((i-1)*nCols + j, :);
        [fit_params, ~] = lsqcurvefit(func, x0, TE, intensities_PD, [], [],options);
        PD_map(i, j) = fit_params(1);
    end
end


figure;
imshow(PD_map', [0,1]);
colorbar;
colormap(gray);
sgtitle(sprintf('Prajwal Mohan, ID-1232306844\nCalculated PD Map'));

%%

%Define function
func = @(x, TE) x(1) .* exp(-TE ./ x(2));
x0 = [0.5, 1];

% Reshape the images for lsqcurvefit
[nRows, nCols, nTE] = size(images);
reshaped_images = reshape(images, [], nTE);

options = optimoptions('lsqcurvefit','Display','off');
T2_map = zeros(nRows, nCols);

% Voxel wise fit
for i = 1:nRows
    for j = 1:nCols
        intensities_T2 = reshaped_images((i-1)*nCols + j, :);
        [fit_params, ~] = lsqcurvefit(func, x0, TE, intensities_T2, [], [],options);
        T2_map(i, j) = fit_params(2);
    end
end


figure;
imshow(T2_map', [0,500]);
colorbar;
colormap(gray);
sgtitle(sprintf('Prajwal Mohan, ID-1232306844\nCalculated T2 Map'));

