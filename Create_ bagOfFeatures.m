% Pick a random subset of the flower images
trainingSet = splitEachLabel(flowerImageSet, 0.4, 'randomized');

% Create a custom bag of features using the 'CustomExtractor' option
colorBag = bagOfFeatures(trainingSet, ...
  'CustomExtractor', @exampleBagOfFeaturesColorExtractor, ...
  'VocabularySize', 10000);

% Load pre-trained bagOfFeatures
% load('savedColorBagOfFeatures.mat','colorBag');