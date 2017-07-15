% Define a query image
queryImage = readimage(flowerImageSet, 502);

% figure
% imshow(queryImage)

% Search for the top 20 images with similar color content
[imageIDs, scores] = retrieveImages(queryImage, flowerImageIndex);

% Display results using montage. Resize images to thumbnails first.
helperDisplayImageMontage(flowerImageSet.Files(imageIDs))