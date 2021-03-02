function test()
clc;
clear;

load('iris_dbscan');

X=iris_dbscan;
e1=getE(X);
m1=getM(X,e1);
[IDX1,isnoise]=SADBSCAN(X,e1,m1);
%»­Í¼
figure
PlotClusterinResult(X, IDX1);
title(['DBSCAN Clustering \epsilon = ' num2str(e1)]);

%e2=0.4;
%m2=9;
%[IDX2,isnoise]=DBSCAN(iris_dbscan,e2,m2);
%»­Í¼
%figure
%PlotClusterinResult(iris_dbscan, IDX2);
%title(['DBSCAN Clustering \epsilon = ' num2str(e2)]);


%k-means
%[idx,C]=kmeans(X,3);
%figure
%plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
%hold on
%plot(X(idx==2,1),X(idx==2,2),'g.','MarkerSize',12)
%hold on
%plot(X(idx==3,1),X(idx==3,2),'b.','MarkerSize',12) 
%legend('C1','C2','C3')

%mean shift
%[C,idx,clustMembsCell] = MeanShiftCluster(X',0.85);
%numClust = length(clustMembsCell);
%figure
%plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
%hold on
%plot(X(idx==2,1),X(idx==2,2),'g.','MarkerSize',12)
%hold on
%plot(X(idx==3,1),X(idx==3,2),'b.','MarkerSize',12)
%hold on
%plot(X(idx==4,1),X(idx==4,2),'y.','MarkerSize',12)
%legend('C1','C2','C3','C4')

end