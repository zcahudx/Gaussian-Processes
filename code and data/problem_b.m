load('cw1a.mat')
Cov = [[-3 -1];[-1 1]; [0 2]; [1 4]];
Lik = [0 3 5 7];
Hyp = {};
NLZ = {}
xs = linspace(-3, 3, 900)'; % 900 test points from -3 to 3
for j = 1: length(Cov)
    for k = 1: length(Lik)
        meanfunc = []; covfunc = @covSEiso;  likfunc = @likGauss; 
        hyp = struct('mean', [], 'cov', Cov(j,:), 'lik', Lik(k));
        hyp = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
        [mu s2] = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xs);
        Hyp{length(Lik)*(j-1)+k} = hyp;
        [nlZ dnlZ] = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
        NLZ{length(Lik)*(j-1)+k} = nlZ;
        f = [mu+2*sqrt(s2); flipdim(mu-2*sqrt(s2),1)];
        subplot(length(Cov),length(Lik), length(Lik)*(j-1)+k)
        fill([xs; flipdim(xs,1)], f, [7 7 7]/8)
        hold on; plot(xs, mu); plot(x, y, '+'); xlabel('x'); ylabel('y');
        title(strcat('hyp.cov = ', mat2str(Cov(j,:)),' and hyp.lik = ', mat2str(Lik(k))))
        hold off;
    end
end



