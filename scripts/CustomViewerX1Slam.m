clearvars;
close all;
dbstop error;
% clc;
addpath(genpath(pwd));

TAG = 'CustomViewerX1Slam';

cHiTargetDatasetRootFolderPath = 'E:\DoctorRelated\20230516中海达模组研究\X1 SLAM';
cHiTargetDatasetFolderName = '2023-05-15-102857';

cHiTargetDatasetFolderPath = fullfile(cHiTargetDatasetRootFolderPath,cHiTargetDatasetFolderName);
cHiTargetDatasetPoseData = loadHiTargetLixelX1Data(cHiTargetDatasetFolderPath);

cHiTargetDatasetPoseDataSize = size(cHiTargetDatasetPoseData,1);
pIndex = 1:cHiTargetDatasetPoseDataSize;
pPose = cHiTargetDatasetPoseData(pIndex,:);
pPoseTransition = cHiTargetDatasetPoseData(:,2:4);
pPoseRotationQuaternionValues = zeros(cHiTargetDatasetPoseDataSize,4);
pPoseRotationQuaternionValues(:,1) =  cHiTargetDatasetPoseData(:,5);
pPoseRotationQuaternionValues(:,2:4) =  cHiTargetDatasetPoseData(:,6:8);
pPoseRotationQuaternion = quaternion(pPoseRotationQuaternionValues);
plotSEBracket3Pose(pPoseTransition,pPoseRotationQuaternion);


deltaPosition = cHiTargetDatasetPoseData(2:cHiTargetDatasetPoseDataSize,2:4) - cHiTargetDatasetPoseData(1:(cHiTargetDatasetPoseDataSize-1),2:4);
distance = sum(sqrt(sum(deltaPosition.^2,2)));

deltaHeadTailPosition = cHiTargetDatasetPoseData(cHiTargetDatasetPoseDataSize,2:4) - cHiTargetDatasetPoseData(1,2:4);
closingError = sum(sqrt(sum(deltaHeadTailPosition.^2,2)));
closingErrorRelative = closingError / distance * 100;

logMsg = sprintf('Lixel X1 pose data track length %.3f m, closing error %.3f m, relative %.3f %%',distance,closingError,closingErrorRelative);
log2terminal('I',TAG,logMsg);
