function [ vector_autoimagenes ] = Crear_n_Autoimagenes( tp2_folder, accuracy, n, mx_chica_grande_o_grandetraspuesto )
%CREAR_N_AUTOIMAGENES Importa las imagenes y construye los primeros n
%autovectores. Nota importante, para acceder a la imagen i se usa
%vector_autoimagenes(:,:,i).
%   Le das la carpeta donde están las imagenes y calcula Mx
%   En mi caso tp2_folder es '~/Documents/MetNum/TP2/archivos_tp2/' o 
%   '/home/leandro/Documents/MetNum/TP2/archivos_tp2/',
%   "~/" en matlab, hace que empiece la busqueda desde la carpeta home del 
%   sistema operativo ubuntu.
%   Realiza el método de la potencia solo para los n primeros autovectores
%   pedidos, y finalmente convierte aquellos autovectores, en matrices del
%   tamaño de las imagenes originales, y coloca esas matrices en un vector.
%   sonImagenesChicas es un int, si es 0, utiliza las imagenes chicas
%   en la carpeta dada, si es 1 usa las grandes, si es 2 usa las grandes pero con X*X'.
    if(mx_chica_grande_o_grandetraspuesto == 0)
        Mx = CalcularMxChicas(tp2_folder);
    elseif (mx_chica_grande_o_grandetraspuesto == 1)
        Mx = CalcularMx(tp2_folder);
    else
        Mx = CalcularMxAlRevez(tp2_folder);
    end
    V = CalcularAutoValoresVectores(Mx,accuracy,n);
    matrix_height = size(Mx);
    matrix_height = matrix_height(1);
    if(mx_chica_grande_o_grandetraspuesto == 0)
        anchoim = 23;
        altoim = 28;
        
    elseif(mx_chica_grande_o_grandetraspuesto == 1) 
        anchoim = 92;
        altoim = 112;
    else
        anchoim = 92;
        altoim = 112;
        imgs = double(importar_imagenes(tp2_folder));
        Vm = VectorMedias(imgs);
        X = MatrizSemivarianza(imgs, Vm);
        Xt = X';
        V = Xt * V;
        V = normalizarVcolumnas(V);
    end
    vector_autoimagenes = zeros(altoim, anchoim, n);
    for i = 1:n
        img = Autovector_a_Autoimagen( V(:,i), anchoim, altoim);
        vector_autoimagenes(:,:,i) = img; %guardo la img i en la iesima posicion
    end
end
