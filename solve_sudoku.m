function x = solve_sudoku(x)
%SOLVE_SUDOKU Solve sudoku.

if any(size(x) ~= 9)
    error('Wrong sudoku size.')
end

is_new = true;
while is_new
    is_new = false;
    if nnz(x) == numel(x)
        if is_valid_answer(x)
            break
        else
            error('No answer!')
        end
    end
    for k = find(x == 0)'
        % Eliminate candidates that duplicate existing numbers.
        [r, c] = ind2sub([9 9], k);
        candidates = 1:9;
        candidates = candidates .* ~ismember(1:9, x(r,:));
        candidates = candidates .* ~ismember(1:9, x(:,c));
        candidates = candidates .* ~ismember(1:9, subsquare(x,r,c));
        switch nnz(candidates)
        case 0
            error('Cannot find any answer.')
        case 1
            x(r,c) = candidates(candidates ~= 0);
            is_new = true;
        end
    end
end

end

function y = subsquare(x, irow, icol)
%SUBSQUARE Get sub-square at specified position from sudoku main square.
k = [irow icol] - mod([irow icol] - 1, 3);
y = x(k(1) : k(1)+2, k(2) : k(2)+2);
end

function y = is_valid_answer(x)
%IS_VALID_ANSWER Check if the answer is a valid one.
y = true;
% cols
for v = x
    y = y && all(ismember(1:9, v));
end
% rows
for v = x'
    y = y && all(ismember(1:9, v));
end
% sub-squares
for m = 1 : 3 : 9
    for n = 1 : 3 : 9
        y = y && all(ismember(1:9, subsquare(x, m, n)));
    end
end
end
