function out = crosscheck(point1, point2, point3, point4)
%point1---->point2   point3---->point4

%line1: u1x+v1y=w1
u1 = point2(2)-point1(2);
v1 = point1(1)-point2(1);
w1 = det([point1(1), point1(2); point2(1), point2(2)]);

%line2: u2x+v2y=w2
u2 = point4(2)-point3(2);
v2 = point3(1)-point4(1);
w2 = det([point3(1), point3(2); point4(1), point4(2)]);

%intersection of L1 and L2
if det([u1 v1; u2 v2])==0
    out = false;
else
    x = det([v2 v1;w2 w1])/det([u1 v1; u2 v2]);
    y = det([u1 u2;w1 w2])/det([u1 v1; u2 v2]);
    out = (pdist2([x,y],point1)<pdist2(point2,point1))&&(pdist2([x,y],point3)<pdist2(point4,point3));
end
%out = false for no cross and vice-versa
end