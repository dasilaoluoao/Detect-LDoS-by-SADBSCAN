clc;
clear;
close all;
%��ⵥԪ��С
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

%Э����������-С������-���ɷַ���-��-����ͳ��������-������Ʒ�ģ��
%KNN-ǿ��ѧϰ-SVM-��Ͼ���-���ѧϰ-��Ҷ˹����

%SVM
%plot(fea0);
%svm=fitcsvm(fea0,target0','Standardize',true,'KernelFunction','RBF','KernelScale','auto');
%result=predict(svm,fea1);

%DT
%dt=fitctree(fea0,target0');
%result=predict(dt,fea1);

%���ر�Ҷ˹
%bayes=fitcnb(fea0,target0');
%result=predict(bayes,fea1);

%ramdom forest
%nTree = 300;
%rf = TreeBagger(nTree,fea0,target0');
%result = str2double(predict(rf,fea1));

%�߼��ع�
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

%adaboost ʧ��
%t = templateTree();
%adaboost = fitensemble(fea0,target0,'AdaBoostM1',100,'tree','type','classification');
%result = predict(adaboost,fea1);

%������Ʒ� ʧ��
%mc = dtmc(fea0);
%bins = classify(mc);
%numSteps=50;
%X = simulate(mc,numSteps);
%ͨ���۲����������Ʒ�ģ�Ͳ���
%hmmtrain();
%ͨ��״̬�͹۲���Ʋ���
%hmmestimate();


