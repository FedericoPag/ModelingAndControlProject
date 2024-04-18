function plot_field(n, H, L, M, n_iter, init_cond)    
    W = H*L;
    room_grid = zeros(2,n);
    load("localization.mat");

    for i=1:n
	    room_grid(1,i) = floor(W/2)+ mod(i-1,L)*W; 
	    room_grid(2,i) = floor(W/2)+ floor((i-1)/L)*W;
    end

    x_true = zeros(n,1);
    support = init_cond;
    x_true(support) = 1;

    for move = 1:n_iter
        x_obtained = M(1:n,move);
        target = find(x_obtained);

        x_true = A*x_true;
        real_pos = find(x_true);

        plot(room_grid(1,real_pos), room_grid(2,real_pos),'s','MarkerSize',9, 'MarkerEdgeColor',[1 0 0],'MarkerFaceColor',[1 0 0])
        grid on
        hold on
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