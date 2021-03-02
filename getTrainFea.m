function [X,th]=getTrainFea(trainData,data_unit)
len=length(trainData(1:80000,:));
fea1=getFea(trainData(1:len/2,:),data_unit);
fea2=getFea(trainData(len/2+1:len,:),data_unit);
X=mean(fea1);
len=length(fea2);
theta=zeros(1,len);
for i=1:len
    theta(i)=getYu(X,fea2(i,:)); 
end
th=mean(theta);
end