function plotstep(particles, I, partsize,stp, sidelen)
% Plots the intermediate tracking results using a blue square
% of sidelength 'sidelen' centered at the empirical posterior mean
%
% Displays prediction density particles, posterior particles,
%   observed image, and observed image with tracking square superimposed 
%
% Inputs:
%    particles -- 4xn matrix of n particles, each a 4-d state variable
%                 where the first two coordinates represent position
%    I -- current observations (image in 3-panel RGB format with entries
%         ranging from 0 to 255)
%    partsize -- sizes of the particles (proportional to the likelihoods)
%    stp -- index of the current iteration (integer)
%    sidelen -- the tracking square is (2*sidelen+1)x(2*sidelen+1) except
%               when the tracking square is near a boundary
%
% MAKE SURE TO EDIT THE TITLE ON THE FOURTH FIGURE TO YOUR NAME!
% 
%
% Jarvis Haupt
% University of Minnesota
% EE 8581 Spring 2016

% initialize some parameters
n1 = size(I,1);
n2 = size(I,2);
numpart = size(particles,2);

% approximate the empirical mean of the posterior
partsizepmf = partsize/sum(partsize);
pave = sum(particles.*repmat(partsizepmf,4,1),2);
pave = round(pave); % to get an integer-valued coordiate

% Produce images for plotting
% prediction density and posterior images...
prediction_density_image = zeros(n1,n2);
posterior_image = zeros(n1,n2);
for n = 1:numpart
    coords = particles(1:2,n); coords = coords';
    prediction_density_image(coords(1),coords(2)) = 1;
    posterior_image(coords(1),coords(2)) = ...
        prediction_density_image(coords(1),coords(2)).*partsize(n);
end

% tracked image...
bluemark = zeros(size(prediction_density_image));
whitemask = ones(size(prediction_density_image));
r = sidelen; % sidelength of tracking 'square'
cxmin = max(1,pave(1)-r); cxmax = min(pave(1)+r,n1);
cymin = max(1,pave(2)-r); cymax = min(pave(2)+r,n2);
bluemark(cxmin:cxmax,cymin:cymax) = 255;
whitemask = double(bluemark ~= 255);
It = double(I);
It(:,:,1) = It(:,:,1).*whitemask; % zero the red frame in tracking square
It(:,:,2) = It(:,:,2).*whitemask; % zero the green frame in tracking square
It(:,:,3) = It(:,:,3) + bluemark; % boost the blue frame in tracking square
It(:,:,3) = 255*(It(:,:,3)>255) + It(:,:,3).*(It(:,:,3)<=255); % bounds
It = It./max(max(max(It))); % for plotting

figure(1)
subplot(2,2,1)
imagesc(prediction_density_image); colormap gray
title(['pred. density particles (position only), k= ', num2str(stp)])
subplot(2,2,3)
image(I)
title(['observations in step ', num2str(stp)])
subplot(2,2,2)
imagesc(posterior_image); colormap gray
title(['posterior particles (position only), k= ',num2str(stp)])
subplot(2,2,4)
image(It)
title('image w/tracking (YOUR NAME)')

drawnow