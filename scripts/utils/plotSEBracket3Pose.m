function [] = plotSEBracket3Pose(poseData)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明

ViridisColerPalette06 = ["#fde725" "#7ad151" "#22a884" "#2a788e" "#414487" "#440154"];

poseDataSize = size(poseData,1);

posePosition = poseData(:,3:5);
poseRotationQuaternionValues = zeros(poseDataSize,4);
poseRotationQuaternionValues(:,1) =  poseData(:,9);
poseRotationQuaternionValues(:,2:4) =  poseData(:,6:8);
poseRotationQuaternion = quaternion(poseRotationQuaternionValues);

figure;
hold on;
grid on;
axis equal;
pAxisLength = 0.6;
pAxisLineWidth = 0.4;
% A = [0 0 0 1; l 0 0 1; 0 0 0 1; 0 l 0 1; 0 0 0 1; 0 0 l 1]';
for i=1:5:poseDataSize
  tSE3Rotation = (rotmat(poseRotationQuaternion(i),'frame'))';
  tSE3Position = posePosition(i,:)';
  tSEBracket3FromS2N = SE3(tSE3Rotation,tSE3Position).double;
  A = [0 0 0 1; pAxisLength 0 0 1; 0 0 0 1; 0 pAxisLength 0 1; 0 0 0 1; 0 0 pAxisLength 1]';
  B = tSEBracket3FromS2N * A;
  plot3(B(1,1:2),B(2,1:2),B(3,1:2),'Color',ViridisColerPalette06(1),'LineStyle','-','LineWidth',pAxisLineWidth); % x: red
  plot3(B(1,3:4),B(2,3:4),B(3,3:4),'Color',ViridisColerPalette06(3),'LineStyle','-','LineWidth',pAxisLineWidth); % y: green
  plot3(B(1,5:6),B(2,5:6),B(3,5:6),'Color',ViridisColerPalette06(5),'LineStyle','-','LineWidth',pAxisLineWidth); % z: blue
end

xlabel('x (m)','FontSize',12);
ylabel('y (m)','FontSize',12);
zlabel('z (m)','FontSize',12);

view([0 -1 0]);
hold off;

set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0, 0, 9, 6.75]);
set(gca, 'lineWidth', 1.1, 'FontSize', 9, 'FontName', 'Times');
print(gcf,'f','-dpng','-r600');

end
