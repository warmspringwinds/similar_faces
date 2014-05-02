function [ projected_data ] = project( project_matrix, data_to_project, data_mean )
    % Projects specified data into new coordinate system which is described
    % by projecting matrix. If data mean is specified it is subtracted from
    % each data sample.
    % Input:
    % @project_matrix - matrix where each column is a vector specifing a
    % new coordinate axe
    % @data_to_project - matrix where each row is a data sample to project
    % @data_mean - row that represents mean of data matrix to project
    % Output:
    % @projected_data - matrix where each row is a according projected data
    % sample from @data_to_project
    
    if (nargin > 2)
        % If mean value of data was specified, then subtract it from each
        % data sample.
        data_to_project = data_to_project - repmat(data_mean, size(data_to_project, 1), 1);
    end
    
    projected_data = data_to_project * projecting_matrix; 

end

