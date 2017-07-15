dataDir = fullfile(toolboxdir('vision'),'visiondata','bookCovers');
bookCovers = imageDatastore(dataDir);
% Search Image Set Using Query Image
% imageIndex = indexImages(bookCovers);
% 
% save 'indexImagesForBookCovers.mat' imageIndex;

% % Select and display the query image
queryDir = fullfile(dataDir,'queries',filesep);

imageDatastore(fullfile('bookCovers','jpg'),'LabelSource','foldernames');

queryImage = imread([queryDir 'query3.jpg']);

% imageIDs = retrieveImages(queryImage,imageIndex);
% 
% bestMatch = imageIDs(1);
% bestImage = imread(imageIndex.ImageLocation{bestMatch});
% 
% figure
% imshowpair(queryImage,bestImage,'montage');