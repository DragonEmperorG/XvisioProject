clearvars;
close all;
dbstop error;
% clc;
addpath(genpath(pwd));

TAG = 'CustomViewerSdkViewerSlam';

cXvisioDatasetRootFolderPath = 'E:\GitHubRepositories\XvisioProject\datasets';
cXvisioDatasetFolderName = '2023-03-30T15-13-23';
cXvisioDatasetEdgeDataFileName = 'edge.csv';
cXvisioDatasetHostDataFileName = 'host.csv';

% cXvisioDatasetEdgeDataFilePath = fullfile(cXvisioDatasetRootFolderPath,cXvisioDatasetFolderName,cXvisioDatasetEdgeDataFileName);
% cXvisioDatasetEdgeData = loadXvisioSdkViewerWindowSlamData(cXvisioDatasetEdgeDataFilePath);

cXvisioDatasetHostDataFilePath = fullfile(cXvisioDatasetRootFolderPath,cXvisioDatasetFolderName,cXvisioDatasetHostDataFileName);
cXvisioDatasetHostData = loadXvisioSdkViewerWindowSlamData(cXvisioDatasetHostDataFilePath);

cXvisioDatasetHostDataSize = size(cXvisioDatasetHostData,1);
pIndex = 1:cXvisioDatasetHostDataSize;
pPose = cXvisioDatasetHostData(pIndex,:);
plotSEBracket3Pose(pPose);
