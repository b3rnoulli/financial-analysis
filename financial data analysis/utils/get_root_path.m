function [ path ] = get_root_path()
    if isempty(getenv('MATLAB_WORKSPACE_HOME'))
        path = '/Users/b3rnoulli/Development/Matlab workspace';
    else
        path = getenv('MATLAB_WORKSPACE_HOME');
    end
end

