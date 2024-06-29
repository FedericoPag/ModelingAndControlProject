function graph_plot(Adj1)

% Matrice di adiacenza
Adj = Adj1';

% Trova le dimensioni della matrice di adiacenza
[nR, nC] = size(Adj);

% Inizializza i vettori sorgente e destinazione
s = zeros(1,nR);
t = zeros(1,nR);
si = 1;
ti = 1;
% Popola i vettori sorgente e destinazione
for i = 1:nR
    for j = 1:nC
        if Adj(i, j) ~= 0
            s(si) = i;
            t(ti) = j;
            si = si+1;
            ti = ti+1;
        end
    end
end

% Crea il grafo orientato
G = digraph(s, t);

numNodes = nR;

% Crea le etichette dinamiche per i nodi partendo da 0
nodeLabels = arrayfun(@(x) ['', num2str(x-1)], 1:numNodes, 'UniformOutput', false);
nodeLabels{1} = '0-Leader';  % Etichetta del primo nodo
% Plotta il grafo con personalizzazioni
figure;
h = plot(G);
h.NodeColor = 'r';
h.EdgeColor = 'b';
h.LineWidth = 1;
h.MarkerSize = 4;
% Aggiungi etichette ai nodi
labelnode(h, 1:numnodes(G), nodeLabels);
h.NodeLabel = nodeLabels; % Assicurarsi che le etichette siano applicate
h.NodeFontSize = 10;
end