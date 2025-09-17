function edo_interactiva
    % Rango inicial
    tmin = -3; tmax = 3;
    xmin = -3; xmax = 3;

    % Crear figura
    figure('Name','x'' = t^2 + x^2 - Interactiva','NumberTitle','off');
    ax = axes('Position',[0.08 0.15 0.85 0.8]);
    hold(ax, 'on'); grid(ax, 'on');
    xlabel(ax,'t'); ylabel(ax,'x');
    xlim(ax,[tmin tmax]); ylim(ax,[xmin xmax]);
    axis equal;

    % Slider para cantidad de isoclinas
    uicontrol('Style','slider','Min',3,'Max',10,'Value',7,...
        'Units','normalized','Position',[0.15 0.03 0.3 0.05],...
        'Callback',@(src,~) dibujar(ax, round(get(src,'Value'))));
    uicontrol('Style','text','String','# isoclinas',...
        'Units','normalized','Position',[0.02 0.03 0.12 0.05]);

    % Dibujar inicial
    dibujar(ax, 7);
end

function dibujar(ax, nIso)
    cla(ax); % limpiar

    % Definir ODE
    f = @(t,x) t.^2 + x.^2;
    tmin = ax.XLim(1); tmax = ax.XLim(2);
    xmin = ax.YLim(1); xmax = ax.YLim(2);

    % ===== Isoclinas =====
    cs = linspace(0.5, 9, nIso);
    theta = linspace(0, 2*pi, 200);
    for c = cs
        r = sqrt(c);
        tt = r*cos(theta);
        xx = r*sin(theta);
        plot(ax, tt, xx, 'Color',[1 0 0.5], 'LineWidth', 1);
    end

    % ===== Campo de direcciones =====
    color_gris = [0.5 0.5 0.5]; % RGB: (rojo, verde, azul)
    [tg, xg] = meshgrid(linspace(tmin, tmax, 20), linspace(xmin, xmax, 20));
    S = f(tg, xg);
    dt = 1 ./ sqrt(1 + S.^2);
    dx = S ./ sqrt(1 + S.^2);
    quiver(ax, tg, xg, dt, dx, 0.5, 'Color', color_gris);
    
    % ===== Soluciones numéricas =====
    ics = [-2, -1, -0.5, 0, 0.5, 1, 2];
    for x0 = ics
        [tR, xR] = ode45(f, [0 tmax], x0);
        [tL, xL] = ode45(f, [0 tmin], x0);
        plot(ax, [flipud(tL); tR(2:end)], [flipud(xL); xR(2:end)], 'LineWidth', 2);
    end

    title(ax, sprintf("x'(t) = t^2 + x^2(t) | isoclinas | campo de direcciones | soluciones"));
    % legend('Isoclinas','Campo de direcciones', 'Solución EDO');


end
