function [trainData,testData]=inputData(data_unit)
load('wide2018.mat');
%load('ns2.mat');
load('testbed.mat');
%load('t');
load('ns/ns.mat');
%file0=m6;
%file0=[B600;C600;D600;B900;C900];
file0=file;
len=floor(length(file0)/data_unit)*data_unit;

time=file0(1:len,1);
tcp=file0(1:len,2);
udp=file0(1:len,3);
%{
time=file(1001:2000,1);
tcp=file(1001:2000,2);
udp=file(1001:2000,3);
%}

testData=[time tcp udp];

load('ns/ns2A.mat');
file1=file;
load('ns/ns3A.mat');
file1=[file1;file];
load('ns/ns4A.mat');
file1=[file1;file];
load('ns/ns5A.mat');
file1=[file1;file];
load('ns/ns1.mat');
load('ns/nor_red');
load('ns/nor_dt');
%file1=[file;nor_red;nor_dt]; %ns2
%file1=A600; testbed
len1=floor(length(file1)/data_unit)*data_unit;
time1=file1(1:len1,1);
tcp1=file1(1:len1,2);
udp1=file1(1:len1,3);
trainData=[time1 tcp1 udp1];


end