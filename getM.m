function MinPts=getM(test_fea,epsilon)
X=test_fea;
DM=pdist2(X,X);
len=length(test_fea);
MP=zeros(1,len);
for i=1:len
    MP(i)=length(find(DM(i,:)<=epsilon));
end
maxMP=max(MP);
minMP=min(MP);
%meanMP=mean(MP);
a=minMP/maxMP;
%b=meanMP/maxMP;
if a<0.1
    a=0.1;
end
nMP=normal(MP',1,a);
for i=1:len
    MinPts(i)=floor(nMP(i)*maxMP);
end
end
