% Create a search index
flowerImageIndex = indexImages(flowerImageSet, colorBag, 'SaveFeatureLocations', false);

% Load the pre-saved index
% load('savedColorBagOfFeatures.mat', 'flowerImageIndex');