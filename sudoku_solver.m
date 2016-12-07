function y = sudoku_solver(x)
%SUDOKU_SOLVER Sudoku solver.

backtrack(1)

function backtrack(index)
    %BACKTRACK Find solution by backtracking.
    if index > 81
        y = x;
        return
    end
    if x(index) == 0
        for i = 1 : 9
            x(index) = i;
            if isunique(index)
                backtrack(index + 1)
            end
            x(index) = 0;
        end
        x(index) = 0;
    else
        backtrack(index+1)
    end
end

function y = isunique(index)
    %ISUNIQUE Determine if the specified grid is unique in sudoku rules.
    c = x(index);
    [row, col] = ind2sub([9 9], index);
    y = nnz(c == x(row,:)) == 1 & ...
        nnz(c == x(:,col)) == 1 & ...
        nnz(c == subbox(row,col)) == 1;
end

function y = subbox(row, col)
    %SUBBOX Get the sub 3x3 box at specified grid.
    k = [row col] - mod([row col] - 1, 3);
    y = x(k(1) : k(1)+2, k(2) : k(2)+2);
end

end
