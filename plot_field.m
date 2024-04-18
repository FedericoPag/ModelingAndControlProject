function plot_field(n, H, L, M, n_iter)
    load("localization.mat")
    W = H*L;
    room_grid = zeros(2,n);


    for i=1:n
	    room_grid(1,i) = floor(W/2)+ mod(i-1,L)*W; 
	    room_grid(2,i) = floor(W/2)+ floor((i-1)/L)*W;
    end
    
    xtrue1 = zeros(n,1);
    support1 = randperm(n);
    support1 = support1(1:3); % I consider 3 targets
    xtrue1(support1) = 1;
    target1 = find(xtrue1);

    for move = 1:n_iter
        xtrue1 = A*xtrue1;
        target1 = find(xtrue1)
    
        plot(room_grid(1,target1), room_grid(2,target1),'s','MarkerSize',9, 'MarkerEdgeColor',[1 0 0],'MarkerFaceColor',[1 0 0])
        hold on
        grid on
        xtrue = M(1:n,move);
        target = find(xtrue)
        
        plot(room_grid(1,target), room_grid(2,target),'*','MarkerSize',9, 'MarkerEdgeColor',1/255*[40 208 220],'MarkerFaceColor',1/255*[40 208 220])
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