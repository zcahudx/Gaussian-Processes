load('cw1a.mat')
meanfunc = []; covfunc = @covSEiso; likfunc = @likGauss; 
xs = linspace(-3, 3, 900)'; % 900 test points from -3 to 3
hyp.cov = [-1  0]; hyp.lik = 0;
hyp = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
[mu s2] = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
f = [mu+2*sqrt(s2); flipdim(mu-2*sqrt(s2),1)];
fill([xs; flipdim(xs,1)], f, [7 7 7]/8)
hold on; plot(xs, mu); plot(x, y, '+');xlabel('x'); ylabel('y');
hold off;


