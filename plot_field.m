function plot_field(n, H, L, M, n_iter)
    
    W = H*L;
    room_grid = zeros(2,n);


    for i=1:n
	    room_grid(1,i) = floor(W/2)+ mod(i-1,L)*W; 
	    room_grid(2,i) = floor(W/2)+ floor((i-1)/L)*W;
    end
    
    xtrue = zeros(n,1);
    support = randperm(n);
    support = support(1:3); % I consider 3 targets
    xtrue(support) = 1;
    target = find(xtrue);

    for move = 1:n_iter
        xtrue = M(1:n,move);
        target = find(xtrue);
    
        plot(room_grid(1,target), room_grid(2,target),'s','MarkerSize',9, 'MarkerEdgeColor',1/255*[40 208 220],'MarkerFaceColor',1/255*[40 208 220])
        grid on
        legend( 'Targets','Location','eastoutside')
       
        xticks(100:100:1000)
        yticks(100:100:1000)
        xlabel('(cm)')
        ylabel('(cm)')
        axis([0 1000 0 1000])
        axis square
        str = sprintf(' Time = %d', move);
        text(1100,900,str);
        pause(1)
        hold off
    end

end