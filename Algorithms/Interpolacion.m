% Beatriz Herguedas Pinedo

fprintf("¿Qué tipo de interpolación desea?\n");
fprintf("1- Función por puntos\n");
opcion = input("2- Tabla de valores\n");

while (opcion ~= 1 && opcion ~= 2)
    fprintf("Opción no válida. Seleccione la opción 1 o la 2\n");
    fprintf("¿Qué tipo de interpolación desea?\n");
    fprintf("1- Función por puntos\n");
    opcion = input("2- Tabla de valores\n");
end

puntos = [];
imagenes = [];

% Si elige la opción 1: función por puntos equiespaciados
if(opcion == 1)
    % Para introduir la ecuación: @(x)
    f = input("Introduzca la función que desea interpolar (@(x)): \n");
    puntos = input("Introduzca los puntos que desea utilizar: \n");
    
    num = size(puntos, 2);
    imagenes = zeros(1, num);
    
    for i = 1:num
        imagenes(i) = f(puntos(i));
    end
end

% Si elige la opción 2: tabla de valores
if(opcion == 2)
    puntos = input("Introduzca la coordenada x de los puntos que desea utilizar: \n");
    imagenes = input("Introduzca la coordenada y de los puntos anteriores: \n");
    
    if(size(puntos,2) ~= size(imagenes,2))
        error("ERROR: el número de puntos y de imágenes no coincide\n");
    end
end

n = size(puntos,2) - 1;
polinomio = [];
pi = ones(1);

for k = 0:n
    % Calculamos el polinomio con el pi anterior
    polinomio = [0, polinomio] + pi*imagenes(1);
    
    % Calculamos el productorio hasta esta iteracion
    pi = [pi, 0] - [0, pi.*puntos(k+1)];
    
    for i = 1:n-k
        imagenes(i) = (imagenes(i) - imagenes(i+1))/(puntos(i) - puntos(i+k+1));
    end
end

espacio = linspace(min(puntos(:)), max(puntos(:)), 200);

% Representamos la gráfica
if(opcion == 1)
    hold on;
    plot(espacio, f(espacio(:)));
    plot(espacio, polyval(polinomio, espacio));
    hold off;
end

if(opcion == 2)
    plot(espacio, polyval(polinomio, espacio));
end

% Prguntamos si quiere interpolar en más puntos
fprintf("¿Desea seguir interpolando?\n");
fprintf("1- No\n");
s = input("2- Sí\n");

while(s ~= 1)
    % Ampliamos el polinomio (y por tanto los vectores)
    if(opcion == 1)
        p = input("Introduzca el nuevo punto: \n");
        puntos =[puntos, p];
        imagenes =[imagenes, f(p)];
        
    end    
    if(opcion == 2)
        p = input("Introduzca el nuevo punto: \n");
        im = input("Introduzca su imagen: \n");
        puntos =[puntos, p];
        imagenes =[imagenes, im];
    end
    
    n = n+1;
    
    for i = n:-1:1
        imagenes(i) = (imagenes(i) - imagenes(i+1))/(puntos(i) - puntos(n+1));
    end
    
    polinomio = [0, polinomio] + pi*imagenes(1);
    pi = [pi, 0] - [0, pi.*puntos(n+1)];
    
    espacio = linspace(min(puntos(:)), max(puntos(:)), 200);
    
    % Pintamos la gráfica
    if(opcion == 1)
        hold on;
        plot(espacio, f(espacio(:)));
        plot(espacio, polyval(polinomio, espacio));
        hold off;
    end
    
    if(opcion == 2)
        plot(espacio, polyval(polinomio, espacio));
    end

    % Prguntamos si quiere interpolar en más puntos
    fprintf("¿Desea seguir interpolando?\n");
    fprintf("1- No\n");
    s = input("2- Sí\n");
end
