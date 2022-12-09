load('cw1e.mat')
[xs1 xs2] = meshgrid(linspace(-8, 8, 900), linspace(-8, 8, 900));
xs = [reshape(xs1,900*900,1), reshape(xs2,900*900,1)];
%% Visualisation
surf(reshape(x(:,1),11,11),reshape(x(:,2),11,11),reshape(y,11,11));
xlabel('x1'); ylabel('x2');zlabel("y");

%% With covSEard
meanfunc = []; covfunc = @covSEard; likfunc = @likGauss; 
hyp1.cov = [-1 0 0]; hyp1.lik = 0;
hyp1 = minimize(hyp1, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
[mu s2] = gp(hyp1, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
[nlZ1 dnlZ1] = gp(hyp1, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
mesh(reshape(xs(:,1),900,900),reshape(xs(:,2),900,900),reshape(mu,900,900))
xlabel('x1'); ylabel('x2');zlabel("y");
%%
mesh(reshape(xs(:,1),900,900),reshape(xs(:,2),900,900),reshape(mu,900,900));
hold on;
mesh(reshape(xs(:,1),900,900),reshape(xs(:,2),900,900),reshape(mu+2*sqrt(s2),900,900));
mesh(reshape(xs(:,1),900,900),reshape(xs(:,2),900,900),reshape(mu-2*sqrt(s2),900,900));
xlabel('x1'); ylabel('x2');zlabel("y");
hold off;

%% With {@covSum, {@covSEard, @covSEard}}
meanfunc = []; covfunc = {@covSum, {@covSEard, @covSEard}}; likfunc = @likGauss; 
hyp2.cov = 0.1*randn(6,1); hyp2.lik = 0;
hyp2 = minimize(hyp2, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
[mu s2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
[nlZ2 dnlZ2] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
mesh(reshape(xs(:,1),900,900),reshape(xs(:,2),900,900),reshape(mu,900,900))
xlabel('x1'); ylabel('x2');zlabel("y");
%%
mesh(reshape(xs(:,1),900,900),reshape(xs(:,2),900,900),reshape(mu,900,900));
hold on;
mesh(reshape(xs(:,1),900,900),reshape(xs(:,2),900,900),reshape(mu+2*sqrt(s2),900,900));
mesh(reshape(xs(:,1),900,900),reshape(xs(:,2),900,900),reshape(mu-2*sqrt(s2),900,900));
xlabel('x1'); ylabel('x2');zlabel("y");
hold off;