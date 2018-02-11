hold on;
height = 0.85;
rasters = cell(1,length(solutions));
maxlength = 0;
for i = 1:length(solutions)
    sol = solutions{i,1};
    raster = rasterize(sol.x,sol.y(1,:));
    if length(raster) > maxlength
        maxlength = length(raster);
    end
    rasters{i,1} = raster;
end

colors = colorcube(maxlength);
for i = 1:length(rasters)
    raster = rasters{i,1};
    for j = 1:length(raster)
        line(raster(j)*ones(1,2),[(i-1) (i-1+height)],...
                'Color',colors(j,:),'LineWidth',1.5);
    end
end