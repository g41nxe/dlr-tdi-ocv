function h = plot_contour(x)
  
  pixelCount  = size(x)(2);
  [m, center] = max(max(x));
  [amp, line] = max(x(:, center));
  
  start_row = max(line - round(pixelCount/2), 1);
  end_row   = min(line + round(pixelCount/2), size(x)(1));
  
  if (mod(pixelCount,2) == 0)
    end_row -= 1;    
  
  ydata = x(start_row:end_row, :);  
  
  x = linspace(1,32,32);
  y = x';
  [X, Y] = meshgrid(x, y);
  
  xdata(:,:,1) = X;
  xdata(:,:,2) = Y;
  
  [my, cy] = max(max(ydata));
  [mx, cx] = max(ydata(:,cy));
    
  mx = mean(ydata(:, cy));
  my = mean(ydata(cx, :));  
  dx = std(ydata(:, cy));
  dy = std(ydata(cx, :));
  
  x0 = [amp, mx, dx, my, dy];
  gauss2d = @(x,xdata)x(1)*exp(-((xdata(:,:,1)-x(2)).^2/(2*x(3)^2)+(xdata(:,:,2)-x(4)).^2/(2*x(5)^2) ));
  x = lsqcurvefit(gauss2d, x0, xdata, ydata);
  
  fig = figure();
  
  [c, h] = contour(ydata); 
  set(h, 'Fill', 'on');
  set(h, 'LineColor', 'none');
 
  hold on;
  
  [c, h2] = contour(gauss2d(x,xdata));   
  set(h2, 'LineColor', [1,0.7,0.7]);
  set(h2, 'LineWidth', 1.2);
  
  set(h2, 'Visible', 'off');
  
  b = uicontrol('Style', 'pushbutton', ...
                'String', 'Toggle Gauss', 'Callback', {@toggle_visibility, h2});

  set(gca, 'YTick', [1:1:pixelCount]);
  set(gca, 'XTick', [1:1:pixelCount]);
  
  colorbar;
  colormap('gray');
  
  axis equal; 
  grid on;
    
  xlabel('Aufnahme');
  ylabel('Pixel');
  title('Data vs. Fitted 2d Gauss Curve');  
  
  
  h3 = legend('Data', ['2D Gauss \delta_x = ' num2str(dx) ' \delta_y = ' num2str(dy)]);
  legend (h3, "location", "northeast");
  legend boxoff;
  set (h3, 'TextColor', [1 1 1]);  
  
 
end