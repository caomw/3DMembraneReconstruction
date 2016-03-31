classdef ImageSegmenterFluorescentMembrane3D <  CellVision3D.Object3D...
       ... & CellVision3D.ImageSegmenterFluorescentMembrane2D ...
        
    % the image segmentation for 3D fluorscent membrane, near spherical
    % shapes
    % Yao Zhao 12/4/2015
    
    properties 
    end
    
    methods 
        out=segment(obj,image3,varargin)
        out=segmentLarge(obj,image3,varargin)
    end
    
    methods (Access=public, Static)
            % get second derivatives by eign values
        [ l1,v1,l2,v2,l3,v3 ] = getEigenSecondDerivatives( img3 );
        
        % 3d surface canny detection
        [bw]=getEigenSecondDerivativesEdge(img,th)        
        
        % surf edge
        [ bwedge ] = getSurfEdge( bw, v1, dirth)
    end
    
end

