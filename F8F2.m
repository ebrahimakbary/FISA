function f=F8F2(x)
f2=100.*(x(:,1).^2-x(:,2)).^2+(1-x(:,1)).^2;
f=1+f2.^2./4000-cos(f2);