% A. M. Bronstein, M. M. Bronstein, R. Kimmel, Numerical geometry of
% non-rigid shapes, Springer, 2008
%
% http://tosca.cs.technion.ac.il/book
%
% TUTORIAL
% Demonstration of embedding of a non-Euclidean metric using classic MDS on a toy example.
%
% (C) Copyright Michael Bronstein, 2008
% All rights reserved.

% show the original data
figure(1),
[X,Y,Z] = sphere(20);
h = surf(X,Y,Z),
set(h,'FaceAlpha',0.75)
axis image, shading interp, colormap([1 1 1]*0.9)
lighting phong, camlight, axis off
hold on
plot3([0; 0; 0; -1],[1; 0; -1; 0],[0; 1; 0; 0],'r*');
text([0; 0; 0; -1]+0.025,[1; 0; -1; 0],[0; 1; 0; 0],{'A','B','C','D'})

% matrix of distances
disp('Matrix of distances');
D = [0 1 2 1;...
     1 0 1 1;...
     2 1 0 1;...
     1 1 1 0]

pause;

% matrix of squared distances
D2 = D.^2;

% centered matrix of squared distances
disp('Matrix K_X');
K = 0.5*(repmat(D2(:,1),[1 4]) + repmat(D2(1,:),[4 1]) - D2)

pause;

% perform eigendecomposition
[V,L] = eig(K);

display('Eigenvalues');
diag(L)

display('Eigenvectors');
V

pause;

% compute canonical form in 2D
idx = find(diag(L)>0);
Z = V(:,idx)*sqrt(L(idx,idx))

% visualize the embedding
figure(2),
plot(Z(:,1),Z(:,2),'r*')
text(Z(:,1)+0.025,Z(:,2),{'A','B','C','D'})
axis image
