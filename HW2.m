close all, clear all, clc

% Manipulator var's:
syms th1 th2

% Manipulator para's
L1 = 1; L2 = 1;

% Problem givens:
% phi = 45;
phi = NaN;
% Px = (L1+L2)*cosd(phi);
Px = 1;
% Py = (L1+L2)*sind(phi);
Py = 1;

% Pos/Ori matrix:
H = [cos(phi) -sin(phi) 0 Px;
     sin(phi)  cos(phi) 0 Py;
        0         0     1 0;
        0         0     0 1]; % 4x4
    
% Transformations matrices:
T01 = [cos(th1) -sin(th1) 0 L1*cos(th1);
       sin(th1)  cos(th1) 0 L1*sin(th1);
          0         0     1     0;
          0         0     0     1];
      
T12 = [cos(th2) -sin(th2) 0 L2*cos(th2);
       sin(th2)  cos(th2) 0 L2*sin(th2);
          0         0     1     0;
          0         0     0     1];
      
T02 = T01 * T12; % 4x4

%%

% Construct a matrix of equations H == T02:
for i=1:4
    for j=1:4
        EQ(i,j) = H(i,j) == T02(i,j);
    end
end

%%

% Solution
TH = solve(EQ(1,4), EQ(2,4));

th1 = rad2deg(double(TH.th1))
th2 = rad2deg(double(TH.th2))