%1(a)
x = 10;
y = -2;
z = pi;
save A1.dat z -ascii

%1(b)
x + y - z
save A2.dat ans -ascii

%1(c)
x^3
save A3.dat ans -ascii

%1(d)
exp(-y)
save A4.dat ans -ascii

%1(e)
cos(y * z)
save A5.dat ans -ascii

%2(a)
x = [1;2;-1];
A=[-1 2 1; 3 1 -1];
y = [-2;0;1];
save A6.dat x -ascii

%2(b) 
A(2,:)
save A7.dat ans -ascii

%2(c)
x-y;
save A8.dat ans -ascii

%2(d)
A*y
save A9.dat ans -ascii

%2(e)
A*(x + y)
save A10.dat ans -ascii
