function [y,z,img] = detectemotion( input_args )
%DETECTEMOTION Summary of this function goes here

% Similar to the eigenfeatures and recognition code, here we find the eigenfaces for
% all the 4 emotions and then calculate the score from each of the eigenfaces

%   Detailed explanation goes here
input_dir = 'neutral/faces';
neutralfiles = dir(fullfile(input_dir,'*.png'));
files = neutralfiles;
image_num = numel(files);
image_dimensions = [64,64];
images = [];
for n=1:image_num
    file = fullfile(input_dir,files(n).name);
    image = imread(file);
    if(n==1)
        images = zeros(prod(image_dimensions),image_num);
    end
    images(:,n) = image(:);
end
mean_faces = mean(images,2);
mean_shifted_images = images - repmat(mean_faces,1,image_num);
[coefs,scores, variances] = princomp(images');
eigenfaces = 30;
coefs = coefs(:,1:eigenfaces);

features = coefs' * mean_shifted_images;

testimg = imread('test.png');
testimg = imresize(testimg,[image_dimensions]); 
mean_test = double(testimg(:)) - mean_faces;
test_featurevector = coefs' * mean_test;
similarity_score = arrayfun(@(n) 1/(1+norm(features(:,n)-test_featurevector)),1:image_num);

[neutral_score,neutralimg] = max(similarity_score)




input_dir = 'happy/faces';
happyfiles = dir(fullfile(input_dir,'*.png'));
files = happyfiles;
image_num = numel(files);
image_dimensions = [64,64];
images = [];
for n=1:image_num
    file = fullfile(input_dir,files(n).name);
    image = imread(file);
    if(n==1)
        images = zeros(prod(image_dimensions),image_num);
    end
    images(:,n) = image(:);
end
mean_faces = mean(images,2);
mean_shifted_images = images - repmat(mean_faces,1,image_num);
[coefs,scores, variances] = princomp(images');
eigenfaces = 30;
coefs = coefs(:,1:eigenfaces);

features = coefs' * mean_shifted_images;

testimg = imread('test.png');
testimg = imresize(testimg,[image_dimensions]); 
mean_test = double(testimg(:)) - mean_faces;
test_featurevector = coefs' * mean_test;
similarity_score = arrayfun(@(n) 1/(1+norm(features(:,n)-test_featurevector)),1:image_num);

[happy_score,happyimg] = max(similarity_score);


input_dir = 'surprised/faces';
surprisedfiles = dir(fullfile(input_dir,'*.png'));
files = surprisedfiles;
image_num = numel(files);
image_dimensions = [64,64];
images = [];
for n=1:image_num
    file = fullfile(input_dir,files(n).name);
    image = imread(file); 
    if(n==1)
        images = zeros(prod(image_dimensions),image_num);
    end
    images(:,n) = image(:);
end
mean_faces = mean(images,2);
mean_shifted_images = images - repmat(mean_faces,1,image_num);
[coefs,scores, variances] = princomp(images');
eigenfaces = 30;
coefs = coefs(:,1:eigenfaces);

features = coefs' * mean_shifted_images;

testimg = imread('test.png');
testimg = imresize(testimg,[image_dimensions]); 
mean_test = double(testimg(:)) - mean_faces;
test_featurevector = coefs' * mean_test;
similarity_score = arrayfun(@(n) 1/(1+norm(features(:,n)-test_featurevector)),1:image_num);

[surprised_score,surprisedimg] = max(similarity_score);


input_dir = 'sad/faces';
sadfiles = dir(fullfile(input_dir,'*.png'));
files = sadfiles;
image_num = numel(files);
image_dimensions = [64,64];
images = [];
for n=1:image_num
    file = fullfile(input_dir,files(n).name);
    image = imread(file);
    if(n==1)
        images = zeros(prod(image_dimensions),image_num);
    end
    images(:,n) = image(:);
end
mean_faces = mean(images,2);
mean_shifted_images = images - repmat(mean_faces,1,image_num);
[coefs,scores, variances] = princomp(images');
eigenfaces = 30;
coefs = coefs(:,1:eigenfaces);

features = coefs' * mean_shifted_images;

testimg = imread('test.png');
testimg = imresize(testimg,[image_dimensions]); 
mean_test = double(testimg(:)) - mean_faces;
test_featurevector = coefs' * mean_test;
similarity_score = arrayfun(@(n) 1/(1+norm(features(:,n)-test_featurevector)),1:image_num);

[sad_score,sadimg] = max(similarity_score);


z = [neutral_score happy_score sad_score surprised_score]

[emotion_score,emotion] = max(z);

if(emotion ==1)
    y = 'Neutral';
    img1 =neutralimg;
    files = neutralfiles;
elseif (emotion==2)
    y = 'Happy';
    img1 = happyimg;
    files = happyfiles;
elseif (emotion ==3)
    y = 'Sad';
    img1 = sadimg;
    files = sadfiles;
else
    y = 'Surprised';
    img1 = surprisedimg;
    files = surprisedfiles; 
end

img = imread(files(img1).name);
if(ndims(img1)>2)
    img = rgb2gray(img1);
end

end

