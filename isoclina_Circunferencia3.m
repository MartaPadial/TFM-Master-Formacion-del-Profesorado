% Rango de la gráfica
tmin = -3; tmax = 3;
xmin = -3; xmax = 3;

% ===== 1) Isoclinas =====
figure;
hold on; grid on; axis equal
title('Isoclinas t^2 + x^2 = m');
xlabel('t'); ylabel('x');
cs = [0.5, 1, 2, 3, 5, 7, 9]; % valores de c
theta = linspace(0, 2*pi, 200);
for c = cs
    r = sqrt(c);
    tt = r*cos(theta);
    xx = r*sin(theta);
    plot(tt, xx, 'LineWidth', 1);
    text(r/sqrt(2), r/sqrt(2), sprintf('c=%.1f', c), 'FontSize', 8);
end
xlim([tmin tmax]); ylim([xmin xmax]);

% ===== 2) Campo de direcciones =====
[tg, xg] = meshgrid(linspace(tmin, tmax, 20), linspace(xmin, xmax, 20));
S = tg.^2 + xg.^2;
dt = 1 ./ sqrt(1 + S.^2);
dx = S ./ sqrt(1 + S.^2);

figure;
quiver(tg, xg, dt, dx, 0.5, 'k');
grid on; axis equal
xlabel('t'); ylabel('x');
title('Campo de direcciones x'' = t^2 + x^2');
xlim([tmin tmax]); ylim([xmin xmax]);

% ===== 3) Soluciones numéricas con ode45 =====
f = @(t, x) t.^2 + x.^2;
ics = [-2, -1, -0.5, 0, 0.5, 1, 2]; % condiciones iniciales
figure; hold on; grid on; axis equal
quiver(tg, xg, dt, dx, 0.5, 'k', 'ShowArrowHead', 'off', 'AutoScale','off');

for x0 = ics
    [tR, xR] = ode45(f, [0 tmax], x0);
    [tL, xL] = ode45(f, [0 tmin], x0); % hacia atrás en el tiempo
    plot([flipud(tL); tR(2:end)], [flipud(xL); xR(2:end)], 'LineWidth', 1.5);
end
xlabel('t'); ylabel('x(t)');
title('Soluciones numéricas de x'' = t^2 + x^2');
xlim([tmin tmax]); ylim([xmin xmax]);
