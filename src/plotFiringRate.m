function plotFiringRate(solutionGrid, tau_init, tau_step, I_init, I_step)

tau_n = size(solutionGrid,1);
I_n = size(solutionGrid,2);
firingRates = zeros(size(solutionGrid));
for tau_index = 1:tau_n
    for I_index = 1:I_n
        sol = solutionGrid{tau_index,I_index};
        raster = rasterize(sol.x, sol.y(1,:));

        rate = (length(raster)-1)/raster(length(raster));
        firingRates(tau_index,I_index) = rate;
    end
end
tau_end = tau_step*tau_n + tau_init;
I_end = I_step*I_n + I_init;
imagesc([I_init, I_end],...
    [tau_init, tau_end], firingRates)
end