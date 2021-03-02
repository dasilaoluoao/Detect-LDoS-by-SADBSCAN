clear;
clc;
load('wide2018.mat');
load('testbed.mat');
load('ns/ns1.mat');
M=[A600(1:2000,:);A600(4001:6000,:)];
%M=file;
%M=m1;
L=length(M);
DW=20; 
T=0.1;
load('ns/ns.mat');
N=[A600(1:6000,:);B600;C600;D600;B900(1:9000,:);C900(1:9000,:)];
%N=file;
%N=[m2;m3;m4;m5;m6;m7];
etcp_test=N(:,2); %wide 3
o_etcp=M(:,2);

z=2.58;
DS=1; %1-5s
s_etcp_train=zeros(1,L);
s0=mean(o_etcp);
k=2.7*std(o_etcp);
A=0.2;
for i=1:L
    if i==1
        e=o_etcp(i)-s0;
        if abs(e)>=k
            s_etcp_train(i)=s0+e;
        else
            s_etcp_train(i)=s0+e*(1-(1-A)*(1-(e/k)^2)^2);
        end
    else
        e=o_etcp(i)-s_etcp_train(i-1);
        if abs(e)>=k
            s_etcp_train(i)=s_etcp_train(i-1)+e;
        else
            s_etcp_train(i)=s_etcp_train(i-1)+e*(1-(1-A)*(1-(e/k)^2)^2);
        end
    end
end
n_DS=L*T/DS;
MD_train=zeros(1,n_DS);
for i=1:n_DS
    etcp_ds=s_etcp_train(((i-1)*(DS/T)+1):i*(DS/T));
    mean_x=mean(etcp_ds);
    temp=zeros(1,DS/T);
    for j=1:DS/T
        temp(j)=abs(etcp_ds(j)-mean_x);
    end
    MD_train(i)=sum(temp)/(DS/T);
end
omg_md=mean(MD_train)+z*std(MD_train);

NUM_tr=L/(DW/T);
RAFP_train=zeros(1,NUM_tr);
for k=1:NUM_tr
    s_etcp_train_k=s_etcp_train((k-1)*(DW/T)+1:k*(DW/T));
    n_DS=DW/DS;
    RAF=0;
    for i=1:n_DS
        etcp_ds=s_etcp_train_k((i-1)*(DS/T)+1:i*(DS/T));
        mean_x=mean(etcp_ds);
        temp=zeros(1,DS/T);
        for j=1:DS/T
            temp(j)=abs(etcp_ds(j)-mean_x);
        end
        md=sum(temp)/(DS/T);
        if md>omg_md
            RAF=RAF+1;
        end  
    end
    RAFP_train(k)=RAF/n_DS;
end
A_RAFP=mean(RAFP_train)+z*std(RAFP_train);

t=0;
a=0;
b=0;
Q_DW=zeros(1,DW/T);
while(true)
    o_etcp_test=etcp_test((t/T+1):(t/T+DW/T));
    s0=mean(o_etcp_test);
    k=2.7*std(o_etcp_test);
    s_etcp_test=zeros(1,length(o_etcp_test));
    for i=1:length(o_etcp_test)
        if i==1
            e=o_etcp_test(i)-s0;
            if abs(e)>=k
                s_etcp_test(i)=s0+e;
            else
                s_etcp_test(i)=s0+e*(1-(1-A)*(1-(e/k)^2)^2);
            end
        else
            e=o_etcp_test(i)-s_etcp_test(i-1);
            if abs(e)>=k
                s_etcp_test(i)=s_etcp_test(i-1)+e;
            else
                s_etcp_test(i)=s_etcp_test(i-1)+e*(1-(1-A)*(1-(e/k)^2)^2);
            end
        end
    end
    n_DS=DW/DS;
    RAF=0;
    for i=1:n_DS
        etcp_ds=s_etcp_test((i-1)*(DS/T)+1:i*(DS/T));
        mean_x=mean(etcp_ds);
        temp=zeros(1,DS/T);
        for j=1:DS/T
            temp(j)=abs(etcp_ds(j)-mean_x);
        end
        md=sum(temp)/(DS/T);
        if md>omg_md
            RAF=RAF+1;
        end  
    end
    RAFP=RAF/n_DS;
    
    if RAFP>A_RAFP
        fprintf('%d %f ',t/DW+1,RAFP);
        fprintf('true\n');a=a+1;Q_DW(a,:)=s_etcp_test;
    else
        fprintf('%d %f ',t/DW+1,RAFP);
        fprintf('false\n');b=b+1;
    end
    if t+DW>=length(etcp_test)*T
        break;
    else
        t=t+DW;
    end
end