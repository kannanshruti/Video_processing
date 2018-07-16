%% Deinterlacing filters- Implementation
% (a) vertical two-line averaging 
% (b) vertical four-line averaging
% (c) temporal zero-hold (?eld merging)
% (d) temporal two-?eld averaging
% (e) joint non-causal line and ?eld averaging
% (f) joint causal line and ?eld averaging

%% Vertical 2 line averaging
h = [1,2,1]/2;
n = linspace(-1,1,length(h));
subplot(3,3,1); stem(n,h, 'filled') % Impulse response
title('2line: Impulse Response, Y=1')
xlabel('y')
ylabel('h_t[y]')

fy = linspace(-1,1,21);
omega_y = linspace(-pi,pi,21);
H = 1 + cos(omega_y);
% stem(fy,(abs(H)), 'filled') % Magnitude response

ft = linspace(-1,1,21);
[X,~] = meshgrid(omega_y,ft);
[X1,Y1] = meshgrid(fy,ft);
Z = 1 + cos(X);
subplot(3,3,2); mesh(X1,Y1,Z)
xlabel('fy')
ylabel('ft')
title('Mag response- mesh') % (Y=1, fy=\pm1, \Omega=\pm\pi)')
colorbar
% view(90, 90)

subplot(3,3,3); [C,~] = contour(X1,Y1,Z);
clabel(C)
xlabel('fy')
ylabel('ft')
title('Mag response- contour') %  (Y=1, fy=\pm1, \Omega=\pm\pi)')
view(90, 90)

%% Vertical 4-line averaging
h = [1,0,7,16,7,0,1]'/16;
n = linspace(-1,1,length(h));
subplot(3,3,4); stem(n,h, 'filled') % Impulse response
title('4line: Impulse Response, Y=1')
xlabel('y')
ylabel('h_t[y]')

fy = linspace(-1,1,21);
omega_y = linspace(-pi,pi,21);
H = 1 + (7/8)*cos(omega_y) + (1/8)*cos(3*omega_y);

ft = linspace(-1,1,21);
[X,~] = meshgrid(omega_y,ft);
[X1,Y1] = meshgrid(fy,ft);
Z = 1 + (7/8)*cos(X) + (1/8)*cos(3*X);
subplot(3,3,5); mesh(X1,Y1,Z)
xlabel('fy')
ylabel('ft')
title('Mag response- mesh') % (Y=1, fy=\pm1, \Omega=\pm\pi)')
colorbar

subplot(3,3,6); [C,~] = contour(X1,Y1,Z);
clabel(C)
xlabel('fy')
ylabel('ft')
title('Mag response- contour') %  (Y=1, fy=\pm1, \Omega=\pm\pi)')
view(90, 90)

%% Temporal zero-hold (?eld merging)
h = [0,1,1];
n = linspace(-1,1,length(h));
subplot(3,3,7); stem(n,h, 'filled') % Impulse response
title('0hold: Impulse Response, T=1')
xlabel('t')
ylabel('h_y[t]')

fy = linspace(-1,1,21);
omega_t = linspace(-pi,pi,21);
H = 1 + exp(-1i*omega_t);

ft = linspace(-1,1,21);
[X,~] = meshgrid(omega_t,fy);
[X1,Y1] = meshgrid(ft,fy);
Z = abs(1 + cos(X) + 1i*sin(X));
subplot(3,3,8); mesh(X1,Y1,Z)
xlabel('ft')
ylabel('fy')
title('Mag response- mesh') % (Y=1, fy=\pm1, \Omega=\pm\pi)')
colorbar

subplot(3,3,9); [C,~] = contour(X1,Y1,Z);
clabel(C)
xlabel('ft')
ylabel('fy')
title('Mag response- contour') %  (Y=1, fy=\pm1, \Omega=\pm\pi)')

%% Temporal two-?eld averaging
h = [1,2,1]/2;
n = linspace(-1,1,length(h));
subplot(3,3,1); stem(n,h, 'filled') % Impulse response
title('2field: Impulse Response, T=1')
xlabel('t')
ylabel('h_y[t]')

fy = linspace(-1,1,21);
omega_t = linspace(-pi,pi,21);
H = 1 + exp(-1i*omega_t);

ft = linspace(-1,1,21);
[X,~] = meshgrid(omega_t,fy);
[X1,Y1] = meshgrid(ft,fy);
Z = abs(1 + cos(X));
subplot(3,3,2); mesh(X1,Y1,Z)
xlabel('ft')
ylabel('fy')
title('Mag response- mesh') % (Y=1, fy=\pm1, \Omega=\pm\pi)')
colorbar

subplot(3,3,3); [C,~] = contour(X1,Y1,Z);
clabel(C)
xlabel('ft')
ylabel('fy')
title('Mag response- contour') %  (Y=1, fy=\pm1, \Omega=\pm\pi)')

%% Joint non-causal line and ?eld averaging
h = [0,1,0;1,4,1;0,1,0]/4;
n1 = linspace(-1,1,3);
n2 = linspace(-1,1,3);
[N1,N2] = meshgrid(n1,n2);
subplot(3,3,4); stem3(N1,N2,h ,'filled') % Impulse response
title('Joint non causal:Imp Resp, Y=1,T=1')
xlabel('t')
ylabel('y')
zlabel('h[y,t]')

fy = linspace(-1,1,21);
omega_t = linspace(-pi,pi,21);
omega_y = linspace(-pi,pi,21);
H = 1 + exp(-1i*omega_t);

ft = linspace(-1,1,21);
[X,Y] = meshgrid(omega_t,omega_y);
[X1,Y1] = meshgrid(ft,fy);
Z = abs(1 + 0.25*cos(X) + 0.25*cos(Y));
subplot(3,3,5); mesh(X1,Y1,Z)
xlabel('ft')
ylabel('fy')
title('Mag response- mesh') % (Y=1, fy=\pm1, \Omega=\pm\pi)')
colorbar

subplot(3,3,6); [C,~] = contour(X1,Y1,Z);
clabel(C)
xlabel('ft')
ylabel('fy')
title('Mag response- contour') %  (Y=1, fy=\pm1, \Omega=\pm\pi)')

%% Joint causal line and ?eld averaging
h = [0,-1,0; 0,0,0; 0,9,0; 0,32,16; 0,9,0; 0,0,0; 0,-1,0]/32;
n1 = linspace(-1,1,3);
n2 = linspace(-1,1,7);
[N1,N2] = meshgrid(n1,n2);
subplot(3,3,7); stem3(N1,N2,h ,'filled') % Impulse response
title('Joint causal:Imp Resp, Y=1,T=1')
xlabel('t')
ylabel('y')
zlabel('h[y,t]')

fy = linspace(-1,1,21);
omega_t = linspace(-pi,pi,21);
omega_y = linspace(-pi,pi,21);
% H = 1 + exp(-1i*omega_t);

ft = linspace(-1,1,21);
[X,Y] = meshgrid(omega_t,omega_y);
[X1,Y1] = meshgrid(ft,fy);
Z = abs(1 + 0.5*exp(-1i*X) - (1/16)*cos(3*Y) + (9/16)*cos(Y));
subplot(3,3,8); mesh(X1,Y1,Z)
xlabel('ft')
ylabel('fy')
title('Mag response- mesh') % (Y=1, fy=\pm1, \Omega=\pm\pi)')
colorbar

subplot(3,3,9); [C,~] = contour(X1,Y1,Z);
clabel(C)
xlabel('ft')
ylabel('fy')
title('Mag response- contour') %  (Y=1, fy=\pm1, \Omega=\pm\pi)')

