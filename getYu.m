function cos=getYu(X,Y)
n=length(X);
if n==0
    cos=0;
else
    %dot 向量点乘 norm 向量的模
    cos=dot(X,Y)/(norm(X)*norm(Y));
end
end


