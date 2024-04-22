% This function adds to k random measurements y(i), i=1,...,p,
% k aware adversarial attacks with the value of 1/2*y(i)
% Note that the algorithm has been thought for sparse attacks

function res = aware_attack(k, p, y, sup)
    res = y;        %Initial condition
    
    if sup ~= 0
        for i=1:length(sup)
            res(sup(i)) = y(sup(i)) + 0.5*y(sup(i));
        end
        return
    end
       
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