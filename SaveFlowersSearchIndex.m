function SaveFlowersSearchIndex()
    % Location of the compressed data set
    url = 'http://www.robots.ox.ac.uk/~vgg/data/flowers/17/17flowers.tgz';

    % Store the output in a temporary folder
    outputFolder = fullfile('', '17Flowers'); % define output folder

    if ~exist(outputFolder, 'dir') % download only once
        disp('Downloading 17-Category Flower Dataset (58 MB)...');
       untar(url, outputFolder);
    end

    flowerImageSet = imageDatastore(fullfile(outputFolder,'jpg'),'LabelSource','foldernames');

    % Total number of images in the data set
    numel(flowerImageSet.Files)

    % Pick a random subset of the flower images
    trainingSet = splitEachLabel(flowerImageSet, 0.4, 'randomized');
    
    imageIndex = indexImages(flowerImageSet);

    save 'flowerImageIndex.mat' imageIndex;

    % Create a custom bag of features using the 'CustomExtractor' option
    colorBag = bagOfFeatures(trainingSet, ...
      'CustomExtractor', @exampleBagOfFeaturesColorExtractor, ...
      'VocabularySize', 10000);
    save 'colorFlowersBagOfFeatures.mat' colorBag;
    % Load pre-trained bagOfFeatures
    % load('savedColorBagOfFeatures.mat','colorBag');
    
    % Create a search index
    flowerImageIndex = indexImages(flowerImageSet, colorBag, 'SaveFeatureLocations', false);
    save 'flowerImageIndexColor.mat' flowerImageIndex;
    % Load the pre-saved index
    % load('savedColorBagOfFeatures.mat', 'flowerImageIndex');
end

