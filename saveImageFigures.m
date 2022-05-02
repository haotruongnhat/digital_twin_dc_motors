function n_images = saveImageFigures(output_folder)
    mkdir(output_folder)
    figHandle = sortFigureHandles(findobj('Type','figure'));
    n_fig = size(figHandle,1);
    
    for i=1:n_fig
        saveas(figHandle(i), fullfile(output_folder, join([int2str(i), '.png'])))
    end
    
    n_images = n_fig;
end

function figSorted = sortFigureHandles(figs)
    [tmp, idx] = sort([figs.Number]);
    figSorted = figs(idx);
end