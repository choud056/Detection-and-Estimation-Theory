function L = redlikelihood(I)
% Extracts a likelihood of the amount of "redness" in pixels
%   in the imput image I.  Uses a heuristic!
%
% Input:
%    I -- current observations (image in 3-panel RGB format with entries
%         ranging from 0 to 255)
% Output:
%    L -- a matrix having the same dimensions as I (in the first 2 
%         coordinates) that contains a non-negative value proportional
%         to the likelihood value for each corresponding coordinate 
%         of the image I
%
% Jarvis Haupt
% University of Minnesota
% EE 8581 Spring 2016

% Specify a "blob" (to be used in the likelihood model below...)
[xx,yy] = meshgrid(-50:1:50,-50:1:50);
blob = exp(-(1e-2)*(xx.^2 + yy.^2));

% Get the likelihood
Idouble = double(I); % Cast as a double-precision
L = Idouble(:,:,1) - Idouble(:,:,2) - Idouble(:,:,3); % look for "redness"
L = L.*(L>0); % keep just the non-negative values
%if (max(max(L))==0); L = 1; end  % in case no "redness"
if (max(max(L))==0); L = ones(size(L)); end  % in case no "redness"
L = L./max(max(L)); % rescale
L = L + 0.001; % add a small offset to each
L = filter2(blob,L); % then filter by the "blob"