function modelcell=model2cell(model)
% MODEL2CELL This function converts the result of a statistical model from fitlm or fitlme into cell array
%
% INPUT:
% model - result of a stat model (e.g.  model=fitlme(table_vars,formula) );
%
% OUTPUT:
% modelcell - result of a stat model in cell format;
% 
% Author: Marina Fernandez-Alvarez
% marina.fdez.alvarez@gmail.com

%Prepare data 
 get_varname=@(x) inputname(1);
 input_name=get_varname(model);
 modelcell=evalc(['disp(' char(input_name) ')']); 
 modelcell=strrep(strrep(modelcell,'<strong>',''),'</strong>',''); modelcell=cellstr(strrep(modelcell,'''','')); 
 modelcell=split(modelcell,[char(10) char(10)]);
 modelcell=string(modelcell);
 %Create split matrix
 new_mat=[]; xnull(1,1:15)="";
 for l1=1:length(modelcell)
     x=split(modelcell(l1,1),char(10)); 
     if length(x)==1
         x=transpose(x(~ismember(x,"")));
         for add=length(x)+1:15; x(1,add)=""; end 
         new_mat=[new_mat;x];
     else
         x=strrep(strrep(strrep(x,'   ','$'),' ','_'),'$',' ');
         x = regexprep(x, '\s+', ' '); x=strrep(x,' }','}');
         for l2=1:length(x)
             xx=split(x(l2,1),' '); xx=transpose(xx(~ismember(xx,"")));  for add=length(xx)+1:15; xx(1,add)=""; end 
            new_mat=[new_mat;xx];
         end
     end
     new_mat=[new_mat;xnull];
 end
 check=join(new_mat(1,:),''); %check first empty line
 if string(check)==""
    modelcell=cellstr(new_mat(2:end,:));
 else
    modelcell=cellstr(new_mat);
 end
 %%
end
