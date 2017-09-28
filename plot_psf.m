function h = plot_psf(x, y)
 
  [m, pixel] = max(max(y));;
  
  scatter(x,y(:,pixel));
 
  set(gca, 'XTick', -1:0.1:1); 

  grid on;

  title('PSF');
  xlabel('Position (mm)');
  ylabel('Intensity');
  
  
end
