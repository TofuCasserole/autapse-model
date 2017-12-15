hold on;
for i = 1:length(solutions)
    sol = solutions{i,1};
    raster = rasterize(sol.x,sol.y(1,:));
    scatter(raster,(i-1) * ones(1,length(raster)),'+','MarkerEdgeColor','k');
end