function cos=getYu(X,Y)
n=length(X);
if n==0
    cos=0;
else
    %dot ������� norm ������ģ
    cos=dot(X,Y)/(norm(X)*norm(Y));
end
end


