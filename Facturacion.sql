create or replace PACKAGE         "PKG_FACTURACION" AS 
  
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_GRABAR_FACTURACION_CABECERA(vi_codigo_usuario            IN NUMBER,
                                           vi_serie                     IN VARCHAR,
                                           vi_secuencia                 IN VARCHAR,
                                           vi_codigo_usuario_registro   IN NUMBER,
                                           vo_facturacion_cabecera      OUT NUMBER,
                                           vo_indicador                 OUT VARCHAR,
                                           vo_mensaje                   OUT VARCHAR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_GRABAR_FACTURACION_DETALLE(vi_facturacion_cabecera     IN NUMBER,
                                          vi_codigo_deuda_socio       IN NUMBER,
                                          vi_monto                    IN VARCHAR,
                                          vo_facturacion_detalle      OUT NUMBER,
                                          vo_indicador                OUT VARCHAR,
                                          vo_mensaje                  OUT VARCHAR);                             
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_DEUDA_SOCIO(vi_codigo_socio                  IN NUMBER,
                                   vi_codigo_servicio_detalle       IN NUMBER,
                                   vo_result                        OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_LISTAR_CONCEPTO(vi_rubro           IN VARCHAR,
                               vo_result          OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    
END PKG_FACTURACION;








create or replace PACKAGE BODY         "PKG_FACTURACION" AS

  PROCEDURE SP_GRABAR_FACTURACION_CABECERA(vi_codigo_usuario            IN NUMBER,
                                           vi_serie                     IN VARCHAR,
                                           vi_secuencia                 IN VARCHAR,
                                           vi_codigo_usuario_registro   IN NUMBER,
                                           vo_facturacion_cabecera      OUT NUMBER,
                                           vo_indicador                 OUT VARCHAR,
                                           vo_mensaje                   OUT VARCHAR) AS
  vl_codigo                 NUMBER;                                           
  BEGIN
      
      SELECT SEQ_SIS_FACTURACION_CAB.NEXTVAL INTO vl_codigo FROM DUAL;
      INSERT INTO sis_facturacion_cab (codigo_facturacion_cab, codigo_usuario, serie, secuencia, estado, usuario_creacion, fecha_creacion)
      VALUES (vl_codigo, vi_codigo_usuario, vi_serie, vi_secuencia, 1, vi_codigo_usuario_registro, SYSDATE);
      
      vo_facturacion_cabecera := vl_codigo;
      vo_indicador := '00';
      vo_mensaje := 'Se registro satisfactoriamente la facturacion.';
  
  EXCEPTION 
    WHEN OTHERS THEN
      vo_facturacion_cabecera := 0;
      vo_indicador := '01';
      vo_mensaje := SQLCODE || ' - ' || SQLERRM;
      ROLLBACK;
      
  END SP_GRABAR_FACTURACION_CABECERA;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_GRABAR_FACTURACION_DETALLE(vi_facturacion_cabecera     IN NUMBER,
                                          vi_codigo_deuda_socio       IN NUMBER,
                                          vi_monto                    IN VARCHAR,
                                          vo_facturacion_detalle      OUT NUMBER,
                                          vo_indicador                OUT VARCHAR,
                                          vo_mensaje                  OUT VARCHAR) AS
  vl_codigo                 NUMBER;                                          
  BEGIN
      
      SELECT SEQ_SIS_FACTURACION_DET.NEXTVAL INTO vl_codigo FROM DUAL;
      INSERT INTO sis_facturacion_det (codigo_facturacion_det, codigo_deuda_socio, monto, codigo_facturacion_cab)
      VALUES (vl_codigo, vi_codigo_deuda_socio, TO_NUMBER(REPLACE(vi_monto, '.', ',')), vi_facturacion_cabecera);
      
      vo_facturacion_detalle := vl_codigo;
      vo_indicador := '00';
      vo_mensaje := 'Se registro satisfactoriamente la facturacion.';
  
  EXCEPTION 
    WHEN OTHERS THEN
      vo_facturacion_detalle := 0;
      vo_indicador := '01';
      vo_mensaje := SQLCODE || ' - ' || SQLERRM;
      ROLLBACK;
      
  END SP_GRABAR_FACTURACION_DETALLE;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_DEUDA_SOCIO(vi_codigo_socio                  IN NUMBER,
                                   vi_codigo_servicio_detalle       IN NUMBER,
                                   vo_result                        OUT SYS_REFCURSOR) AS
  BEGIN
    
    OPEN vo_result FOR
        SELECT ds.codigo_deuda_socio, ds.codigo_servicio_detalle, CASE WHEN INSTR(REPLACE(ds.importe, ',', '.'),'.') = 1 THEN 0 || REPLACE(ds.importe, ',', '.') ELSE REPLACE(ds.importe, ',', '.') END AS importe, ds.fec_periodo, ds.codigo_socio 
        FROM sis_deuda_socio ds
        LEFT JOIN sis_servicio_detalle sd ON ds.codigo_servicio_detalle = sd.codigo_servicio_detalle
        LEFT JOIN sis_servicio s ON sd.codigo_servicio = s.codigo_servicio
        WHERE ds.codigo_socio = vi_codigo_socio
        AND s.codigo_servicio = vi_codigo_servicio_detalle
        ORDER BY ds.codigo_deuda_socio;

  END SP_REPORTE_DEUDA_SOCIO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_LISTAR_CONCEPTO(vi_rubro           IN VARCHAR,
                               vo_result          OUT SYS_REFCURSOR) AS
  BEGIN
      OPEN vo_result FOR
        SELECT CODIGO_CONCEPTO, NOMBRE_CONCEPTO, ESTADO 
        FROM SIS_CONCEPTO 
        WHERE ESTADO = 1 AND RUBRO = vi_rubro;
      
  END SP_LISTAR_CONCEPTO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  
  
END PKG_FACTURACION;