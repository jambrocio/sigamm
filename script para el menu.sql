--------------------------------------------------------
-- Archivo creado  - sábado-noviembre-07-2015   
--------------------------------------------------------
REM INSERTING into SIS_MENU
SET DEFINE OFF;
Insert into SIS_MENU (CODIGO_MENU,DESCRIPCION,ORDEN,ESTADO) values ('5','Servicios','5','1');
REM INSERTING into SIS_MENU_USUARIO
SET DEFINE OFF;
Insert into SIS_MENU_USUARIO (CODIGO_MENU_USUARIO,CODIGO_NIVELES,CODIGO_USUARIO) values ('7','4','2');
REM INSERTING into SIS_MENU_NIVELES
SET DEFINE OFF;
Insert into SIS_MENU_NIVELES (CODIGO_NIVELES,DESCRIPCION,LINK,ORDEN,NIVEL,ESTADO,CODIGO_MENU) values ('4','Recibo Luz','recibo_luz','1','1','1','5');
