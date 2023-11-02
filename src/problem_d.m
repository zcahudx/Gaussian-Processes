load('cw1a.mat')
covfunc = {@covProd, {@covPeriodic, @covSEiso}}; hyp.cov = [-0.5 0 0 2 0];             
x = linspace(-5,5,200)';
K = feval(covfunc{:}, hyp.cov, x);
y1 = chol(K+1e-6*eye(200))'*randn(200, 1);
y2 = chol(K+1e-6*eye(200))'*randn(200, 1);
y3 = chol(K+1e-6*eye(200))'*randn(200, 1);
y4 = chol(K+1e-6*eye(200))'*randn(200, 1);
subplot(2,2,1)
plot(x, y1 ,"r"); xlabel('x'); ylabel('y');
%%
subplot(2,2,2)
plot(x, y2, "b"); xlabel('x'); ylabel('y');
%%
subplot(2,2,3)
plot(x, y3, "black"); xlabel('x'); ylabel('y');
%%
subplot(2,2,4)
plot(x, y4, "green"); xlabel('x'); ylabel('y');