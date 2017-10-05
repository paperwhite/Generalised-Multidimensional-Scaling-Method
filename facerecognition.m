
% load('human_face1_1_4k.mat');
% tosca_x = remesh(human_face_4k, set_options('vertices',1000));
% [tosca_x] = init_surface (tosca_x);
% 
% 
% s=what;
% matfiles=s.mat;
% 
% for a=1:numel(matfiles)
% load(char(matfiles(a)));
% tosca_y = remesh(human_face_4k, set_options('vertices',1000));
% [tosca_y] = init_surface (tosca_y);
% N = 50;
% disp(char(matfiles(a)));
% [tx, ux, ty, uy, f, rmsdist, maxdist, local_stress] = gmds (tosca_x, tosca_y, N);
% clearvars human_face_4k;
% end

function [] = facerecognition (input_file)
load(char(input_file));
tosca_x = remesh(human_face_4k, set_options('vertices',1000));
[a] = init_surface (tosca_x);
A = zeros(3,3);
max = zeros(3,3);
rms = zeros(3,3);
N = 50;
fmin=Inf;
note_k=0;
for k = 1:4
	% Create a mat filename, and load it into a structure called matData.
    for l = 1:3
        matFileName = sprintf('human_face%d_%d_4k.mat', k, l);        
        if char(input_file) == matFileName
            continue;
        else if exist(matFileName, 'file')
                matData = load(matFileName);
                tosca_y = remesh(matData.human_face_4k, set_options('vertices',1000));      
                [b] = init_surface (tosca_y);
                disp(matFileName);
                if k == 4 && l == 2
                    [tx, ux, ty, uy, f, rmsdist, maxdist, local_stress] = gmds (b, a, N);
                else 
                     [tx, ux, ty, uy, f, rmsdist, maxdist, local_stress] = gmds (a, b, N);
                    
                end
            A(k,l) = f;
            if f<fmin
                fmin=f;
                note_k=k;
            end
            max(k,l) = maxdist;
            rms(k,l) = rmsdist; 
            else
                fprintf('File %s does not exist.\n', matFileName);
        end
    end
    end
    
end
    if note_k==0
        fprintf('Face does not exist in dataset. Cannot Recognize \n');
    else
        fprintf('Face belongs to Person %d. \n', note_k);
    end
plot(reshape(A',1,12),'--gs','LineWidth',2,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor',[0.5,0.5,0.5]);ylabel('Stress');xlabel('face');axis([1 12 0 350]);title('human face 4.3 vs Dataset.')
end
