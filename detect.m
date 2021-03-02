clc;
clear;
close all;
%检测单元大小
data_unit=200;

[trainData,testData]=inputData(data_unit);
avg=getsvg(testData,20);
%画图
figure
plot(testData(:,1),testData(:,2),'-')%,testData(:,1),testData(:,3),'-',testData(:,1),avg,'--');
title('测试数据集');
xlabel('Time(s)');
ylabel('Bags Number');
legend('TCP','UDP','AVGTCP');
%测试数据特征
test_fea=getFea(testData,data_unit);
len=length(test_fea);

%ns2
%a=ones(1,5);
%b=zeros(1,20);
%target=[a,b,a,a,b,a];

%testbed
%a=ones(1,15);
%b=zeros(1,15);
%target=[a,b,a];

target=ones(1,2654);

fea=normal(test_fea,1,0);
%Y = tsne(fea);
%gscatter(Y(:,1),Y(:,2),target);
figure
plot(fea);
title('测试数据集');
set(gca,'xtick',0:1:len);
legend('tcp方差','tcp平均差','udp方差','udp平均差');

epsilon=getE(fea);
MinPts=getM(fea,epsilon);
[IDX,isnoise]=SADBSCAN(fea,epsilon,MinPts);%SAdbscan
%[IDX,isnoise]=DBSCAN(fea,0.5,5);
%画图
figure
PlotClusterinResult(fea, IDX);
title(['SA-DBSCAN Clustering \epsilon = ' num2str(epsilon)]);

c_num=max(IDX);
c=zeros(1,c_num);
[X,theta]=getTrainFea(trainData,data_unit);
theta=0.96;
cos=0;
for i=1:len
    if IDX(i)==0
        Y=test_fea(i,:);
        cos=getYu(X,Y);
        if cos>=theta
            result(i)=1;
        else
            result(i)=0;
        end
    else
        %c1=testData((i-1)*data_unit+1:i*data_unit,:);
        if c(IDX(i))==0
            Y=test_fea(i,:);
            cos=getYu(X,Y);
            if cos>=theta
                c(IDX(i))=1;
                result(i)=1;
            else
                c(IDX(i))=-1;
                result(i)=0;
            end
        else
            if c(IDX(i))==1
                result(i)=1;
            else
                result(i)=0;
            end
        end    
    end
end

dw=zeros(1,32);
j=1;
for i=1:length(result)
    if result(i)==0
        dw(j)=i;
        j=j+1;
    end
end
%1-no 0-ldos
fp_fn=target-result;

%auc=AUC(target,result);


