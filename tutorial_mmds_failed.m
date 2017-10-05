% A. M. Bronstein, M. M. Bronstein, R. Kimmel, Numerical geometry of
% non-rigid shapes, Springer, 2008
%
% http://tosca.cs.technion.ac.il/book
%
% TUTORIAL
% Demonstration of multidimensional scaling using SMACOF algorithm
% with multigrid acceleration
%
% This tutorial is based on MDS RRE code, distributed as part of 
% TOSCA = Toolbox for Surface Comparison and Analysis
% Web: http://tosca.cs.technion.ac.il
%
% (C) Copyright Michael Bronstein, 2008
% All rights reserved.

% load and display Swiss roll dataset
load swissroll

figure(1), trisurf(swiss.TRIV,swiss.X,swiss.Y,swiss.Z); axis image;
title('Swiss roll surface');
drawnow

% embed using SMACOF
disp('Embedding the intrinsic geometry of the Swiss roll swiss into R^3 using SMACOF (no acceleration)...')
options.X0 = [swiss.X,swiss.Y,swiss.Z];
options.method = 'smacof';
options.xhistory = 'on';
[X_smacof,hist_smacof] = mds(swiss.D,options);

pause;

% load multigrid matrices
load mg_matrices

% embed using SMACOF with multigrid
disp('Embedding the intrinsic geometry of the Swiss roll swiss into R^3 using SMACOF with MG acceleration...')
options.method = 'mg';
options.atol = hist_smacof.s(end);      % stop when reaching the same stress as SMACOF
options.DOWNMTX = DOWNMTX;
options.UPMTX = UPMTX;
options.IND = IND;
[X_mg,hist_mg] = mds(swiss.D,options);

pause

% show result at each iteration
for k = 1:length(hist_mg.time),
    figure(2), trisurf(swiss.TRIV,hist_mg.X{k}(:,1),hist_mg.X{k}(:,2),hist_mg.X{k}(:,3)); axis image;
    title(sprintf('Iteration %d, Stress=%g',k,hist_smacof.s(k)));
    drawnow 
    pause(0.25);
end

pause;

% plot convergence
figure(3), semilogy(cumsum(hist_smacof.time),hist_smacof.s,'k:',...
                    cumsum(hist_mg.time),hist_mg.s,'r');
xlabel('CPU time (sec)'); ylabel('stress');
title('Convergence speed');
legend('SMACOF','MG');

