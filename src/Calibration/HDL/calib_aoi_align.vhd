------------------------------------------------------------------
--!   @file : calib_aoi_align
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;
use work.calib_define.all;

entity calib_aoi_align is
   generic (CAL_AOI_ALIGN : boolean := false
   );
   port(
      AOI_PARAM_IN      : in aoi_param_type; 
      AOI_PARAM_ALIGNED : out aoi_param_type
   );
end calib_aoi_align;

architecture rtl of calib_aoi_align is 
   
begin
   
   GEN1: 
      -- Pour HerculesD et PelicanD, on génère des lignes avec un multiple adéquat (x8)
      -- pour l'offsetx et le width qui respecte les contraintes d'alignement du datamover.
      -- Les données excédentaires seront éliminées plus tard dans la chaîne par un cropper.
      if CAL_AOI_ALIGN = true generate 
         AOI_PARAM_ALIGNED.height <= AOI_PARAM_IN.height;
         AOI_PARAM_ALIGNED.offsety <= AOI_PARAM_IN.offsety;
         AOI_PARAM_ALIGNED.width <= AOI_PARAM_IN.width_aligned;
         AOI_PARAM_ALIGNED.offsetx <= AOI_PARAM_IN.offsetx_aligned;
      -- Pour les autres détecteurs, on effectue un simple pass-through
      else generate
         AOI_PARAM_ALIGNED <= AOI_PARAM_IN;
      end generate GEN1;
      
end rtl;
