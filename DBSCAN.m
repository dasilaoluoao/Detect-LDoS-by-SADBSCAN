function [IDX,isnoise]=DBSCAN(test_fea,epsilon,MinPts)
%ε-领域：确定对象的领域，即对象o的ε-领域是以o为中心，以ε为半径的空间。
%领域的密度：可用领域内的对象数度量。稠密区域的密度阀值由参数Minpts确定（用户指定）。
C=0;
X=test_fea;
n=size(X,1);
IDX=zeros(n,1);  
D=pdist2(X,X);
visited=false(n,1);
isnoise=false(n,1);
    
for i=1:n
    if ~visited(i)
        visited(i)=true;
            
        Neighbors=RegionQuery(i);
        if numel(Neighbors)<MinPts
            % X(i,:) is NOISE
            isnoise(i)=true;
        else
            C=C+1;
            ExpandCluster(i,Neighbors,C);
        end   
    end
end
    
function ExpandCluster(i,Neighbors,C)
    IDX(i)=C;
        
    k = 1;
    while true
        j = Neighbors(k);
            
        if ~visited(j)
            visited(j)=true;
            Neighbors2=RegionQuery(j);
            if numel(Neighbors2)>=MinPts
                Neighbors=[Neighbors Neighbors2];   %#ok
            end
        end
        if IDX(j)==0
            IDX(j)=C;
        end
            
        k = k + 1;
        if k > numel(Neighbors)
            break;
        end
    end
end
    
function Neighbors=RegionQuery(i)
    Neighbors=find(D(i,:)<=epsilon);
end
end
