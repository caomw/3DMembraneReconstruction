function [  ] = exportCSV( cells,filename )
% export the result to excel
% 3/27/2016 Yao Zhao

%%
% open file
file=fopen(filename,'w');

% titles
% header data
fprintf(file,'Cell Id,');
% contour data
fprintf(file,'Channel Label,');


%cell data
celluserdatafieldnames = cells.getUserDataFieldNames();
numcelluserdata = length(celluserdatafieldnames);
% celldatafieldnames = {[]};
% numcelldata = length(celldatafieldnames);
% print cell userdata
for ii=1:numcelluserdata
    switch celluserdatafieldnames{ii}
        otherwise
            ext='';
    end
    fprintf(file,[celluserdatafieldnames{ii},ext,',']);
end

%contour data
contours=[cells.contours];
if ~isempty(contours)
    contouruserdatafilednames = getUserDataFieldNames(contours);
else
    contouruserdatafilednames = [];
end
numcontouruserdata = length(contouruserdatafilednames);

% contourdatafieldnames = {'contour center x', 'contour center y',...
%     'contour center z', 'contour average radius'};
% numcontourdata = length(contourdatafieldnames);
% % print cell userdata
% for ii=1:numcontourdata
%     fprintf(file,[contourdatafieldnames{ii},',']);
% end
% print cell userdata
for ii=1:numcontouruserdata
    switch contouruserdatafilednames{ii}
        case 'mean_radius'
            ext = ' (um)';
        case 'volume'
            ext = ' (um^3)';
        otherwise
            ext='';
    end
    fprintf(file,[contouruserdatafilednames{ii},ext,',']);
end

%particle data
particles=[cells.particles];
if ~isempty(particles)
    particleuserdatafilednames = getUserDataFieldNames(particles);
else
    particleuserdatafilednames = [];
end
numparticleuserdata = length(particleuserdatafilednames);
% particledatafieldnames = {[]};
% numparticledata = length(particledatafieldnames);


% print cell userdata
for ii=1:numparticleuserdata
    switch particleuserdatafilednames{ii}
        case 'particle_pair_distance'
            ext = ' (um)';
        case 'particle_contour_distance'
            ext = ' (um)';
        otherwise
            ext='';
    end
    fprintf(file,[particleuserdatafilednames{ii},ext,',']);
end
fprintf(file,'\n');

% start data
for icell=1:length(cells)
    contours=cells(icell).contours;
    for icontour=1:length(contours)
        contour=contours(icontour);
        for iframe=1:contour.numframes
            fprintf(file,'%d,',icell);
            fprintf(file,'%s,',contour.label);
            for idata=1:numcontouruserdata
                try
                    fprintf(file,'%f,',contour.userdata.(contouruserdatafilednames{idata}));
                catch
                    fprintf(file,',');
                end
            end
            fprintf(file,'\n');
        end
    end
    particles=cells(icell).particles;
    for iparticle=1:length(particles)
        particle=particles(iparticle);
        for iframe=1:particle.numframes
            fprintf(file,'%d,',icell);
            fprintf(file,'%s,',particle.label);
            for idata=1:numcontouruserdata
                fprintf(file,',');
            end
            for idata=1:numparticleuserdata
                try
                    fprintf(file,'%f,',particle.userdata.(particleuserdatafilednames{idata}));
                catch
                    fprintf(file,',');
                end
            end
            fprintf(file,'\n');
        end
    end
end


fclose(file);
end

