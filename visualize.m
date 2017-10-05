function   visualize( filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load(filename, 'human_face_4k');
d = human_face_4k;
trisurf(d.TRIV, d.X, d.Y, d.Z);
end