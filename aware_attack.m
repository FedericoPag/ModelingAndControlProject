% This function adds to k random measurements y(i), i=1,...,p,
% k aware adversarial attacks with the value of 1/2*y(i)
% Note that the algorithm has been thought for sparse attacks

function res = aware_attack(k, p, y)
    res = y;        %Initial condition

    count = 1;
    for i=1:2*p
        x = randi([1, p]);

        if res(x) == y(x)
            res(x) = y(x) + 0.5*y(x);
            count = count + 1;
        else
            continue;
        end

        if (count > k)
            break
        end
    end
end