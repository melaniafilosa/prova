 
% Calculate the error changing the size of the grid in PS
alpha = 0.1;
clear errors
clear all_intensity_ps

load('all_vectors.mat')
all_intensity_ps = [];
load('mc_vector.mat');
mc_intensity;
exact_mc_vector = mc_vector;
Nr = length(mc_vector.xin);
exact_intensity = mc_total;
Nbins = length(mc_total);

  for i = 1:5
     Nr_ps(i) = length(all_vectors(i).xin);
     vector = all_vectors(i);
     plot_boundaries;
     % compute_intensity;
     % intensity_ps = ps_total./norm(ps_total,1);
     ps_total = ps_total./norm(ps_total,1);
     %[all_intensity_ps] = [all_intensity_ps, ps_total'];
     [all_intensity_ps] = [all_intensity_ps, ps_total'];
    % disp([' intensity = ', num2str(size(all_intensity_ps))]);
    % errors(i) = sum(abs(intensity_mc./Nr - all_intensity_ps(:,i)))/Nbins;
  end
  for k = 1: size(all_intensity_ps, 2)
      errors(k) = sum(abs(exact_intensity./Nr - all_intensity_ps(:,k)))/Nbins;
  end
  % Plot the error 
  hold on
  plot(Nr_ps, errors)
  plot(Nr_ps, errors, '* r');
  set(gca, 'Xscale', 'log');
  set(gca, 'Yscale', 'log');
  clear errors2;

% Calculate the error increasing the number os rays for MC
% Assume that MC for a large number of rays (2* 10^6) is correct

all_intensity_mc = [];
all_mc_vectors = [];
for i = 1: 5
  mc_vector.xin = exact_mc_vector.xin(1:1.9*10^(i+1));
  mc_vector.tauout = exact_mc_vector.tauout(1:1.9*10^(i+1));
  [all_mc_vectors] = [all_mc_vectors, mc_vector];
  mc_intensity; 
  Nr_mc(i) = length(all_mc_vectors(i).xin);
  [all_intensity_mc] = [all_intensity_mc, mc_total];
  errors2(i) = sum(abs(exact_intensity./Nr - all_intensity_mc(:,i)./Nr_mc(i)))/Nbins;
end
hold on
plot(Nr_mc, errors2, 'c')
plot(Nr_mc, errors2, '* g');
loglog(Nr_mc, (0.1)./sqrt(Nr_mc), '--');
set(gca, 'Xscale', 'log');
set(gca, 'Yscale', 'log');
