function epsilon=getE(test_fea)
A=test_fea(:,3);
Kvalue=4;
len=length(A);
Kdist=zeros(len,Kvalue);
[IDX0,Dist]=knnsearch(A(2:len,:),A(1,:),'K',Kvalue);
Kdist(1,:)=Dist;
for i=2:len
	[IDX0,Dist] = knnsearch(A([1:i-1,i+1:len],:),A(i,:),'K',Kvalue);
	Kdist(i,:)=Dist;
end
Kdist1=reshape(Kdist,size(Kdist,1)*size(Kdist,2),1);
[sortKdist,sortKdistIdx]=sort(Kdist1,'descend');

epsilon=getMax(sortKdist);
    
    function epsilon=getMax(sortKdist)
        max=0;
        f=0;
        k_len=length(sortKdist);
        for j=1:k_len-1
            temp=sortKdist(j)-sortKdist(j+1);
            if temp>max
                max=temp;
                f=j;
            end
        end
        epsilon=sortKdist(f)-max/2;
    end
end
