% Location of the compressed data set
url = 'http://www.robots.ox.ac.uk/~vgg/data/flowers/17/17flowers.tgz';

% Store the output in a temporary folder
outputFolder = fullfile('', '17Flowers'); % define output folder

if ~exist(outputFolder, 'dir') % download only once
    disp('Downloading 17-Category Flower Dataset (58 MB)...');
    untar(url, outputFolder);
end

flowerImageSet = imageDatastore(fullfile(outputFolder,'jpg'),'LabelSource','foldernames');

imageIndex = indexImages(flowerImageSet);

save 'flowerImageIndex.mat' imageIndex;

% Total number of images in the data set
% numel(flowerImageSet.Files)