clc;
clear;
close all;
%检测单元大小
data_unit=200;
[trainData,testData]=inputData(data_unit);
train_fea=getFea(trainData,data_unit);
test_fea=getFea(testData,data_unit);
len=length(test_fea);
%ns2
a=ones(1,5);
b=zeros(1,20);
target=[a,b,a,a,b,a];
target0=[target,target,target,target];
target1=[target,target,target,target,target];
target1=[target1,target1,target1,target1,target1,target1,target1,target1];

%testbed
%a1=ones(1,10);
%b1=zeros(1,10);
%a2=ones(1,15);
%b2=zeros(1,15);
%target=[a1,b1,a1];
%target0=target';
%target1=[target,target,target,a2,b2,a2,a2,b2,a2];

fea0=normal(train_fea,1,0);
fea1=normal(test_fea,1,0);

%协方差矩阵分析-小波分析-主成分分析-熵-基于统计数据流-隐马尔科夫模型
%KNN-强化学习-SVM-混合聚类-深度学习-贝叶斯网络

%SVM
%plot(fea0);
%svm=fitcsvm(fea0,target0','Standardize',true,'KernelFunction','RBF','KernelScale','auto');
%result=predict(svm,fea1);

%DT
%dt=fitctree(fea0,target0');
%result=predict(dt,fea1);

%朴素贝叶斯
%bayes=fitcnb(fea0,target0');
%result=predict(bayes,fea1);

%ramdom forest
%nTree = 300;
%rf = TreeBagger(nTree,fea0,target0');
%result = str2double(predict(rf,fea1));

%逻辑回归
%lr=fitclinear(fea0,target0);
%result = predict(lr,fea1);

%BPNN
load('ns2net');
net=ns2net;
result=sim(net,fea1');
%1-no 0-ldos
%fp_fn=target1-result;
for i=1:length(result)
    if result(i)>0.5
        result(i)=1;
    elseif result(i)<0.5
        result(i)=0;
    end
end
%fn=tabulate(fp_fn);
%tp=sum(target1);

%adaboost 失败
%t = templateTree();
%adaboost = fitensemble(fea0,target0,'AdaBoostM1',100,'tree','type','classification');
%result = predict(adaboost,fea1);

%隐马尔科夫 失败
%mc = dtmc(fea0);
%bins = classify(mc);
%numSteps=50;
%X = simulate(mc,numSteps);
%通过观测估计隐马尔科夫模型参数
%hmmtrain();
%通过状态和观测估计参数
%hmmestimate();


