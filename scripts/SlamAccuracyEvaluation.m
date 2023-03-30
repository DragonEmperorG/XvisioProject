clearvars;
close all;
dbstop error;
% clc;
addpath(genpath(pwd));

TAG = 'SlamAccuracyEvaluation';

cXvisioDatasetRootFolderPath = 'E:\GitHubRepositories\XvisioProject\datasets';
cXvisioDatasetFolderName = '2023-03-30T16-32-58';
cXvisioDatasetEdgeDataFileName = 'edge.csv';
cXvisioDatasetHostDataFileName = 'host.csv';

% cXvisioDatasetEdgeDataFilePath = fullfile(cXvisioDatasetFolderPath,cXvisioDatasetEdgeDataFileName);
% cXvisioDatasetEdgeData = loadXvisioSdkViewerWindowSlamData(cXvisioDatasetEdgeDataFilePath);

cXvisioDatasetHostDataFilePath = fullfile(cXvisioDatasetRootFolderPath,cXvisioDatasetFolderName,cXvisioDatasetHostDataFileName);
cXvisioDatasetHostData = loadXvisioSdkViewerWindowSlamData(cXvisioDatasetHostDataFilePath);

plotSEBracket3Pose(cXvisioDatasetHostData);

cXvisioDatasetHostDataSize = size(cXvisioDatasetHostData,1);
deltaPosition = cXvisioDatasetHostData(2:cXvisioDatasetHostDataSize,3:5) - cXvisioDatasetHostData(1:(cXvisioDatasetHostDataSize-1),3:5);
distance = sum(sqrt(sum(deltaPosition.^2,2)));

deltaHeadTailPosition = cXvisioDatasetHostData(cXvisioDatasetHostDataSize,3:5) - cXvisioDatasetHostData(1,3:5);
closingError = sum(sqrt(sum(deltaHeadTailPosition.^2,2)));
closingErrorRelative = closingError / distance * 100;

logMsg = sprintf('Xvisio slam data track length %.3f m, closing error %.3f m, relative %.3f %%',distance,closingError,closingErrorRelative);
log2terminal('I',TAG,logMsg);

