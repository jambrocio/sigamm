--------------------------------------------------------
-- Archivo creado  - martes-noviembre-17-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type MIGR_FILTER
--------------------------------------------------------

  CREATE OR REPLACE TYPE "ACMMH"."MIGR_FILTER" IS OBJECT (
  FILTER_TYPE INTEGER, -- Filter Types are 0-> ALL, 1->NAMELIST, 2->WHERE CLAUSE, 3->OBJECTID LIST
  OBJTYPE VARCHAR2(40),
  OBJECTIDS OBJECTIDLIST,
  NAMES NAMELIST,
  WHERECLAUSE VARCHAR2(1000));

/
--------------------------------------------------------
--  DDL for Type MIGR_FILTER_SET
--------------------------------------------------------

  CREATE OR REPLACE TYPE "ACMMH"."MIGR_FILTER_SET" IS TABLE OF MIGR_FILTER;

/
--------------------------------------------------------
--  DDL for Type MIGR_REPORT_DETAIL_ROW
--------------------------------------------------------

  CREATE OR REPLACE TYPE "ACMMH"."MIGR_REPORT_DETAIL_ROW" AS OBJECT
 (CAPTURED_ID            NUMBER(38),
  CAPTURED_NAME          VARCHAR2(4000),
  CONVERTED_NAME          VARCHAR2(4000),
  CAPTURED_TYPE          VARCHAR2(4000),
  CONVERTED_TYPE          VARCHAR2(4000),
  CAPTURE_STATUS         VARCHAR2(20),
  CONVERT_STATUS         VARCHAR2(20),
  GENERATE_STATUS        VARCHAR2(20),
  LOGTEXT               VARCHAR2(4000)
 );

/
--------------------------------------------------------
--  DDL for Type MIGR_REPORT_DETAIL_TABLE
--------------------------------------------------------

  CREATE OR REPLACE TYPE "ACMMH"."MIGR_REPORT_DETAIL_TABLE" AS TABLE OF MIGR_REPORT_DETAIL_ROW;

/
--------------------------------------------------------
--  DDL for Type MIGR_REPORT_SUM_ROW
--------------------------------------------------------

  CREATE OR REPLACE TYPE "ACMMH"."MIGR_REPORT_SUM_ROW" AS OBJECT
       (LABEL           VARCHAR2(50),
	    SCHEMA_SUM      NUMBER,
        TABLE_SUM       NUMBER,
		INDEX_SUM       NUMBER,
		CONSTRAINT_SUM  NUMBER,
		VIEW_SUM        NUMBER,
		TRIGGER_SUM     NUMBER,
		SP_SUM          NUMBER		
        );

/
--------------------------------------------------------
--  DDL for Type MIGR_REPORT_SUM_TABLE
--------------------------------------------------------

  CREATE OR REPLACE TYPE "ACMMH"."MIGR_REPORT_SUM_TABLE" AS TABLE OF MIGR_REPORT_SUM_ROW;

/
--------------------------------------------------------
--  DDL for Type NAME_AND_COUNT_ARRAY
--------------------------------------------------------

  CREATE OR REPLACE TYPE "ACMMH"."NAME_AND_COUNT_ARRAY" IS VARRAY(30) OF name_and_count_t;

/
--------------------------------------------------------
--  DDL for Type NAME_AND_COUNT_T
--------------------------------------------------------

  CREATE OR REPLACE TYPE "ACMMH"."NAME_AND_COUNT_T" IS OBJECT (
  OBJECT_NAME varchar2(30),
  UPDATE_COUNT INTEGER);

/
--------------------------------------------------------
--  DDL for Type NAMELIST
--------------------------------------------------------

  CREATE OR REPLACE TYPE "ACMMH"."NAMELIST" IS TABLE OF VARCHAR2(40);

/
--------------------------------------------------------
--  DDL for Type OBJECTIDLIST
--------------------------------------------------------

  CREATE OR REPLACE TYPE "ACMMH"."OBJECTIDLIST" IS TABLE OF INTEGER;

/
--------------------------------------------------------
--  DDL for Sequence ACTIVIDAD_SOCIO_ACTI_TRAN_IDE_
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."ACTIVIDAD_SOCIO_ACTI_TRAN_IDE_"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence AUXILIAR_AUXI_IDE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."AUXILIAR_AUXI_IDE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence DBOBJECTID_SEQUENCE
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."DBOBJECTID_SEQUENCE"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 50 START WITH 1 CACHE 50 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence LOCALIDAD_LOCA_IDE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."LOCALIDAD_LOCA_IDE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PAIS_PAIS_IDE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."PAIS_PAIS_IDE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SECTOR_SOCIO_SECT_TRAN_IDE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SECTOR_SOCIO_SECT_TRAN_IDE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_SIS_CODIGO_PUESTO
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SEQ_SIS_CODIGO_PUESTO"  MINVALUE 1 MAXVALUE 9999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_SIS_CODIGO_USUARIO
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SEQ_SIS_CODIGO_USUARIO"  MINVALUE 1 MAXVALUE 9999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_SIS_FACTURACION_CAB
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SEQ_SIS_FACTURACION_CAB"  MINVALUE 1 MAXVALUE 9999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_SIS_FACTURACION_DET
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SEQ_SIS_FACTURACION_DET"  MINVALUE 1 MAXVALUE 9999999999999999999999999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_BOLETA
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SQ_BOLETA"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 2273 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_FACTURA
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SQ_FACTURA"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_GENERAL
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SQ_GENERAL"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 6894 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_RECIBO_LUZ_ORIGINAL
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SQ_RECIBO_LUZ_ORIGINAL"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_RECIBO_LUZ_SOCIO
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SQ_RECIBO_LUZ_SOCIO"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_REUNIONES
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SQ_REUNIONES"  MINVALUE 1 MAXVALUE 99999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_REUNIONES_SOCIO
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SQ_REUNIONES_SOCIO"  MINVALUE 1 MAXVALUE 999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_SERVICIO_DETALLE
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SQ_SERVICIO_DETALLE"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 118 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_SERVICIOS
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SQ_SERVICIOS"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 201 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SQ_SOCIO
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."SQ_SOCIO"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 50 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence TIPO_SOCIO_TIPO_TRAN_IDE_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "ACMMH"."TIPO_SOCIO_TIPO_TRAN_IDE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table SIS_CONCEPTO
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_CONCEPTO" 
   (	"CODIGO_CONCEPTO" NUMBER, 
	"NOMBRE_CONCEPTO" VARCHAR2(200 BYTE), 
	"ESTADO" NUMBER, 
	"RUBRO" CHAR(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_FACTURACION_CAB
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_FACTURACION_CAB" 
   (	"CODIGO_FACTURACION_CAB" NUMBER, 
	"CODIGO_USUARIO" NUMBER, 
	"SERIE" VARCHAR2(4 BYTE), 
	"SECUENCIA" VARCHAR2(8 BYTE), 
	"ESTADO" NUMBER(1,0) DEFAULT 1, 
	"USUARIO_CREACION" VARCHAR2(20 BYTE), 
	"FECHA_CREACION" DATE, 
	"USUARIO_MODIFICACION" VARCHAR2(20 BYTE), 
	"FECHA_MODIFICACION" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_FACTURACION_DET
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_FACTURACION_DET" 
   (	"CODIGO_FACTURACION_DET" NUMBER, 
	"CODIGO_PUESTO" NUMBER, 
	"CODIGO_CONCEPTO" NUMBER, 
	"MONTO" NUMBER, 
	"CODIGO_FACTURACION_CAB" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_GIRO_COMERCIAL
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_GIRO_COMERCIAL" 
   (	"CODIGO_GIRO" NUMBER, 
	"NOMBRE_GIRO" VARCHAR2(200 BYTE), 
	"SECTOR" VARCHAR2(2 BYTE), 
	"ESTADO" NUMBER(1,0) DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_MENU
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_MENU" 
   (	"CODIGO_MENU" NUMBER, 
	"DESCRIPCION" VARCHAR2(200 BYTE), 
	"ORDEN" NUMBER, 
	"ESTADO" NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_MENU_NIVELES
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_MENU_NIVELES" 
   (	"CODIGO_NIVELES" NUMBER, 
	"DESCRIPCION" VARCHAR2(200 BYTE), 
	"LINK" VARCHAR2(200 BYTE), 
	"ORDEN" NUMBER, 
	"NIVEL" NUMBER, 
	"ESTADO" NUMBER(1,0), 
	"CODIGO_MENU" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_MENU_USUARIO
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_MENU_USUARIO" 
   (	"CODIGO_MENU_USUARIO" NUMBER, 
	"CODIGO_NIVELES" NUMBER, 
	"CODIGO_USUARIO" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_PUESTO
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_PUESTO" 
   (	"CODIGO_PUESTO" NUMBER, 
	"CODIGO_USUARIO" NUMBER, 
	"NRO_PUESTO" VARCHAR2(4 BYTE), 
	"CODIGO_GIRO" NUMBER, 
	"USUARIO_REGISTRO" VARCHAR2(20 BYTE), 
	"FECHA_REGISTRO" DATE, 
	"USUARIO_MODIFICACION" VARCHAR2(20 BYTE), 
	"FECHA_MODIFICACION" DATE, 
	"ESTADO" NUMBER(1,0) DEFAULT 1, 
	"RECIBO_LUZ" CHAR(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_RECIBOLUZ_ORG
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_RECIBOLUZ_ORG" 
   (	"COD_ORGRECIBO_LUZ" NUMBER, 
	"NUM_LECTURA_INICIAL" NUMBER(12,4), 
	"NUM_LECTURA_FINAL" NUMBER(12,4), 
	"NUM_MONTO" NUMBER(12,4), 
	"NUM_COSTO_WATS" NUMBER(12,4), 
	"FEC_PERIODO" VARCHAR2(20 BYTE), 
	"NUM_PENDIENTE_FAC" NUMBER(12,4), 
	"NUM_ESTADO" NUMBER, 
	"REPOMANCNX" NUMBER(12,4), 
	"CARGOFIJO" NUMBER(12,4), 
	"ALUMPUBLIC" NUMBER(12,4), 
	"SUBTOTALMES" NUMBER(12,4), 
	"IGV" NUMBER(12,4), 
	"TOTALMESACT" NUMBER(12,4), 
	"APORTELEY" NUMBER(12,4), 
	"CUOTACONV" NUMBER(12,4), 
	"REDONMESACT" NUMBER(12,4), 
	"REDONMESANT" NUMBER(12,4), 
	"INTERESCONVENIO" NUMBER(12,4), 
	"ENERGACTFRAPTAACTUAL" NUMBER(12,4), 
	"ENERGACTFRAPTAANTERI" NUMBER(12,4), 
	"ENERGACTFRAPTADIFER" NUMBER(12,4), 
	"ENERGACTFRAPTAFACTOR" NUMBER(12,4), 
	"ENERGACTFRAPTACONSU" NUMBER(12,4), 
	"ENERGACTFRAPTACONFA" NUMBER(12,4), 
	"ENERGACTFRAPTAPREUNI" NUMBER(12,4), 
	"ENERGACTFRAPTATOTAL" NUMBER(12,4), 
	"ENERGACTHORPTAACTU" NUMBER(12,4), 
	"ENERGACTHORPTAANT" NUMBER(12,4), 
	"ENERGACTHORPTADIF" NUMBER(12,4), 
	"ENERGACTHORPTAFAC" NUMBER(12,4), 
	"ENERGACTHORPTACONS" NUMBER(12,4), 
	"ENERGACTHORPTACONFAC" NUMBER(12,4), 
	"ENERGACTHORPTAPREUNI" NUMBER(12,4), 
	"ENERGACTHORPTATOTAL" NUMBER(12,4), 
	"ENERGREACINICIAL" NUMBER(12,4), 
	"ENERGREACANTERI" NUMBER(12,4), 
	"ENERGREACDIFERE" NUMBER(12,4), 
	"ENERGREACFACTOR" NUMBER(12,4), 
	"ENERGREACCONSU" NUMBER(12,4), 
	"ENERGREACFACCONS" NUMBER(12,4), 
	"ENERGREACPREUNI" NUMBER(12,4), 
	"ENERGREACTOTAL" NUMBER(12,4), 
	"POTENCIAFPINI" NUMBER(12,4), 
	"POTENCIAFPANTE" NUMBER(12,4), 
	"POTENCIAFPDIF" NUMBER(12,4), 
	"POTENCIAFPFAC" NUMBER(12,4), 
	"POTENCIAFPCONS" NUMBER(12,4), 
	"POTENCIAHPACT" NUMBER(12,4), 
	"POTENCIAHPANT" NUMBER(12,4), 
	"POTENCIAHPDIF" NUMBER(12,4), 
	"POTENCIAHPFAC" NUMBER(12,4), 
	"POTENCIAHPCONS" NUMBER(12,4), 
	"POTUSOREDDISTCONFAC" NUMBER(12,4), 
	"POTUSOREDDISTPREUNI" NUMBER(12,4), 
	"POTGENFPCONFAC" NUMBER(12,4), 
	"POTGENFPPREUNI" NUMBER(12,4), 
	"POTUSOREDDISTTOTAL" NUMBER(12,4), 
	"POTGENFPTOTAL" NUMBER(12,4), 
	"FECVENCIMIENTO" VARCHAR2(20 BYTE), 
	"FECEMISION" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table SIS_RECIBOLUZ_SOCIO
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_RECIBOLUZ_SOCIO" 
   (	"CODIGOSOCIO" NUMBER(*,0), 
	"CODIGORECIBO" NUMBER(*,0), 
	"CORRELATIVO" NUMBER(*,0), 
	"LECTURAINICIAL" NUMBER(*,0), 
	"LECTURAFINAL" NUMBER(*,0), 
	"CONSUMOMES" NUMBER(*,0), 
	"CARGOFIJO" NUMBER(9,2), 
	"CARGOENERGIA" NUMBER(9,2), 
	"ALUMBRADOPUBLICO" NUMBER(9,2), 
	"SERVICIOMANTENIMIENTO" NUMBER(9,2), 
	"DEUDAANTERIOR" NUMBER(9,2) DEFAULT 0.00, 
	"RECONEXION" NUMBER(9,2) DEFAULT 0.00, 
	"SUBTOTALMES" NUMBER(9,2), 
	"IGV" NUMBER(9,2), 
	"TOTALMES" NUMBER(9,2), 
	"REDONDEO" NUMBER(9,2), 
	"TOTAL" NUMBER(9,2), 
	"ESTADO" NUMBER DEFAULT 1, 
	"FECHACARGA" TIMESTAMP (6) DEFAULT systimestamp, 
	"IMPRESO" NUMBER DEFAULT 0, 
	"USUARIO" VARCHAR2(20 BYTE), 
	"FECHAMODIFICACION" VARCHAR2(20 BYTE), 
	"USUARIOMODIFICACION" TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_ROL
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_ROL" 
   (	"CODIGO_ROL" NUMBER, 
	"NOMBRE_ROL" VARCHAR2(200 BYTE), 
	"ESTADO" NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_ROL_X_UNIDAD
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_ROL_X_UNIDAD" 
   (	"CODIGO_ROL_X_UNIDAD" NUMBER, 
	"CODIGO_UNIDAD" NUMBER, 
	"CODIGO_ROL" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_UNIDAD
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_UNIDAD" 
   (	"CODIGO_UNIDAD" NUMBER, 
	"NOMBRE_UNIDAD" VARCHAR2(200 BYTE), 
	"ESTADO" NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SIS_USUARIO
--------------------------------------------------------

  CREATE TABLE "ACMMH"."SIS_USUARIO" 
   (	"CODIGO_USUARIO" NUMBER, 
	"USUARIO" VARCHAR2(20 BYTE), 
	"CLAVE" VARCHAR2(40 BYTE), 
	"DNI" VARCHAR2(8 BYTE), 
	"APELLIDO_PATERNO" VARCHAR2(30 BYTE), 
	"APELLIDO_MATERNO" VARCHAR2(30 BYTE), 
	"NOMBRES" VARCHAR2(40 BYTE), 
	"FECHA_NACIMIENTO" DATE, 
	"CORREO" VARCHAR2(200 BYTE), 
	"ESTADO" NUMBER(1,0), 
	"USUARIO_CREACION" VARCHAR2(20 BYTE), 
	"FECHA_CREACION" DATE, 
	"USUARIO_MODIFICACION" VARCHAR2(20 BYTE), 
	"FECHA_MODIFICACION" DATE, 
	"TELEFONO" VARCHAR2(10 BYTE), 
	"CODIGO_ROL_X_UNIDAD" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for View MGV_ALL_CAPTURED_SQL
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_CAPTURED_SQL" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME", "NATIVE_SQL", "LINECOUNT") AS 
  SELECT d."OBJTYPE",d."OBJNAME",d."OBJID",d."MAINOBJTYPE",d."MAINOBJNAME",d."MAINOBJID",d."SCHEMANAME",d."SCHEMAID",d."CATALOGNAME",d."CATALOGID",d."CONNNAME",d."CONNID",d."PROJECTNAME",d."PROJECTID",d."CAPTUREDORCONVERTED",d."QUALIFIEDNAME", p.native_sql,p.linecount 
FROM md_stored_programs p , mgv_all_programs_details d
WHERE p.id = d.objid
AND d.capturedorconverted = 'CAPTURED'
UNION ALL
SELECT d."OBJTYPE",d."OBJNAME",d."OBJID",d."MAINOBJTYPE",d."MAINOBJNAME",d."MAINOBJID",d."SCHEMANAME",d."SCHEMAID",d."CATALOGNAME",d."CATALOGID",d."CONNNAME",d."CONNID",d."PROJECTNAME",d."PROJECTID",d."CAPTUREDORCONVERTED",d."QUALIFIEDNAME",v.native_sql,v.linecount
FROM md_views v , mgv_all_view_details d
WHERE v.id = d.objid
AND d.capturedorconverted = 'CAPTURED'
UNION ALL
SELECT d."OBJTYPE",d."OBJNAME",d."OBJID",d."MAINOBJTYPE",d."MAINOBJNAME",d."MAINOBJID",d."SCHEMANAME",d."SCHEMAID",d."CATALOGNAME",d."CATALOGID",d."CONNNAME",d."CONNID",d."PROJECTNAME",d."PROJECTID",d."CAPTUREDORCONVERTED",d."QUALIFIEDNAME" ,t.native_sql,t.linecount
FROM md_triggers t , mgv_all_trigger_details d
WHERE t.id = d.objid
AND d.capturedorconverted = 'CAPTURED';
--------------------------------------------------------
--  DDL for View MGV_ALL_CATALOG_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_CATALOG_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME") AS 
  SELECT 'MD_CATALOGS' objtype, cat.catalog_name objname, cat.id objid,  'MD_CATALOGS' MainObjType,cat.catalog_name MAINOBJNAME, cat.id MAINOBJID,null SchemaName,null schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid,proj.project_name projectname,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN cat.catalog_name ELSE NULL END QualifiedName
FROM  MD_CATALOGS cat,MD_CONNECTIONS conn, MD_PROJECTS proj
WHERE  cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_CATALOGS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_CATALOGS" ("PROJECT_ID", "PROJECT_NAME", "CONNECTION_ID", "HOST", "PORT", "USERNAME", "DBURL", "CATALOG_ID", "CATALOG_NAME") AS 
  SELECT md_projects.id project_id ,
    md_projects.project_name project_name,
    md_connections.id connection_id ,
    md_connections.host host ,
    md_connections.port port ,
    md_connections.username username ,
    md_connections.dburl dburl ,
    md_catalogs.id catalog_id ,
    md_catalogs.catalog_name catalog_name
  FROM md_projects ,
    md_connections,
    md_catalogs
  WHERE md_catalogs.connection_id_fk = md_connections.id
  AND md_connections.project_id_fk   = md_projects.id
WITH READ ONLY;
--------------------------------------------------------
--  DDL for View MGV_ALL_COLUMN_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_COLUMN_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME") AS 
  SELECT 'MD_COLUMNS' objtype, c.COLUMN_NAME objname, c.Id objid,  'MD_TABLES' MainObjType,t.table_name MAINOBJNAME, t.id MAINOBJID, s.name SchemaName, s.id schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid,proj.project_name projectname,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN cat.catalog_name||'.' ELSE '' END || s.name||'.'||t.table_name ||'.'||c.COLUMN_NAME QualifiedName
FROM MD_COLUMNS c, MD_TABLES t,MD_SCHEMAS s, MD_CATALOGS cat,MD_CONNECTIONS conn, MD_PROJECTS proj
WHERE c.table_id_fk = t.id
AND t.schema_id_fk = s.id
AND s.catalog_id_fk = cat.id
AND cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_COLUMNDT_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_COLUMNDT_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME", "DATATYPE", "ISIDENTITY") AS 
  SELECT 'MD_COLUMNS' objtype, c.COLUMN_NAME objname, c.Id objid,  'MD_TABLES' MainObjType,t.table_name MAINOBJNAME, t.id MAINOBJID, s.name SchemaName, s.id schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid,proj.project_name projectname ,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN cat.catalog_name||'.' ELSE '' END || s.name||'.'||t.table_name ||'.'||c.COLUMN_NAME QualifiedName,
c.column_type datatype,
CASE WHEN p.PROP_KEY='SEEDVALUE' THEN 'Y' ELSE 'N' END IsIdentity
FROM MD_COLUMNS c LEFT OUTER JOIN MD_ADDITIONAL_PROPERTIES p ON c.id =p.ref_id_fk
, MD_TABLES t,MD_SCHEMAS s, MD_CATALOGS cat,MD_CONNECTIONS conn,MD_PROJECTS proj
WHERE c.table_id_fk = t.id
AND t.schema_id_fk = s.id
AND s.catalog_id_fk = cat.id
AND cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_CONNECTIONS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_CONNECTIONS" ("PROJECT_ID", "PROJECT_NAME", "CONNECTION_ID", "HOST", "PORT", "USERNAME", "DBURL") AS 
  SELECT md_projects.id project_id ,
    md_projects.project_name project_name,
    md_connections.id connection_id ,
    md_connections.host host ,
    md_connections.port port ,
    md_connections.username username ,
    md_connections.dburl dburl
  FROM md_projects,
    md_connections
  WHERE md_connections.project_id_fk = md_projects.id
WITH READ ONLY;
--------------------------------------------------------
--  DDL for View MGV_ALL_CONSTRAINTS_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_CONSTRAINTS_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME") AS 
  SELECT 'MD_CONSTRAINTS' objtype, c.name objname, c.Id objid,  'MD_TABLES' MainObjType,t.table_name MAINOBJNAME, t.id MAINOBJID, s.name SchemaName, s.id schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid,proj.project_name projectname,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN cat.catalog_name||'.' ELSE '' END || s.name||'.'||t.table_name ||'.'||c.name QualifiedName
FROM MD_CONSTRAINTS c, MD_TABLES t,MD_SCHEMAS s, MD_CATALOGS cat,MD_CONNECTIONS conn, MD_PROJECTS proj
WHERE c.table_id_fk = t.id
AND t.schema_id_fk = s.id
AND s.catalog_id_fk = cat.id
AND cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME") AS 
  SELECT "OBJTYPE","OBJNAME","OBJID","MAINOBJTYPE","MAINOBJNAME","MAINOBJID","SCHEMANAME","SCHEMAID","CATALOGNAME","CATALOGID","CONNNAME","CONNID","PROJECTNAME","PROJECTID","CAPTUREDORCONVERTED","QUALIFIEDNAME" FROM MGV_ALL_CATALOG_DETAILS
UNION
SELECT "OBJTYPE","OBJNAME","OBJID","MAINOBJTYPE","MAINOBJNAME","MAINOBJID","SCHEMANAME","SCHEMAID","CATALOGNAME","CATALOGID","CONNNAME","CONNID","PROJECTNAME","PROJECTID","CAPTUREDORCONVERTED","QUALIFIEDNAME" FROM MGV_ALL_SCHEMA_DETAILS
UNION
SELECT "OBJTYPE","OBJNAME","OBJID","MAINOBJTYPE","MAINOBJNAME","MAINOBJID","SCHEMANAME","SCHEMAID","CATALOGNAME","CATALOGID","CONNNAME","CONNID","PROJECTNAME","PROJECTID","CAPTUREDORCONVERTED","QUALIFIEDNAME" FROM MGV_ALL_TABLES_DETAILS
UNION
SELECT "OBJTYPE","OBJNAME","OBJID","MAINOBJTYPE","MAINOBJNAME","MAINOBJID","SCHEMANAME","SCHEMAID","CATALOGNAME","CATALOGID","CONNNAME","CONNID","PROJECTNAME","PROJECTID","CAPTUREDORCONVERTED","QUALIFIEDNAME" FROM MGV_ALL_COLUMN_DETAILS
UNION
SELECT "OBJTYPE","OBJNAME","OBJID","MAINOBJTYPE","MAINOBJNAME","MAINOBJID","SCHEMANAME","SCHEMAID","CATALOGNAME","CATALOGID","CONNNAME","CONNID","PROJECTNAME","PROJECTID","CAPTUREDORCONVERTED","QUALIFIEDNAME" FROM MGV_ALL_CONSTRAINTS_DETAILS
UNION
SELECT "OBJTYPE","OBJNAME","OBJID","MAINOBJTYPE","MAINOBJNAME","MAINOBJID","SCHEMANAME","SCHEMAID","CATALOGNAME","CATALOGID","CONNNAME","CONNID","PROJECTNAME","PROJECTID","CAPTUREDORCONVERTED","QUALIFIEDNAME" FROM MGV_ALL_INDEX_DETAILS
UNION
SELECT "OBJTYPE","OBJNAME","OBJID","MAINOBJTYPE","MAINOBJNAME","MAINOBJID","SCHEMANAME","SCHEMAID","CATALOGNAME","CATALOGID","CONNNAME","CONNID","PROJECTNAME","PROJECTID","CAPTUREDORCONVERTED","QUALIFIEDNAME" FROM MGV_ALL_TRIGGER_DETAILS
UNION
SELECT "OBJTYPE","OBJNAME","OBJID","MAINOBJTYPE","MAINOBJNAME","MAINOBJID","SCHEMANAME","SCHEMAID","CATALOGNAME","CATALOGID","CONNNAME","CONNID","PROJECTNAME","PROJECTID","CAPTUREDORCONVERTED","QUALIFIEDNAME" FROM MGV_ALL_VIEW_DETAILS
UNION
SELECT "OBJTYPE","OBJNAME","OBJID","MAINOBJTYPE","MAINOBJNAME","MAINOBJID","SCHEMANAME","SCHEMAID","CATALOGNAME","CATALOGID","CONNNAME","CONNID","PROJECTNAME","PROJECTID","CAPTUREDORCONVERTED","QUALIFIEDNAME" FROM MGV_ALL_PROGRAMS_DETAILS;
--------------------------------------------------------
--  DDL for View MGV_ALL_INDEX_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_INDEX_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME") AS 
  SELECT 'MD_INDEXES' objtype,i.index_name objname, i.Id objid,  'MD_TABLES' MainObjType,t.table_name MAINOBJNAME,t.id MAINOBJID, s.name SchemaName, s.id schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid, proj.project_name projectname,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN cat.catalog_name||'.' ELSE '' END || s.name||'.'||i.index_name  QualifiedName
FROM MD_INDEXES i, MD_TABLES t,MD_SCHEMAS s, MD_CATALOGS cat,MD_CONNECTIONS conn,MD_PROJECTS proj
WHERE i.table_id_fk = t.id
AND t.schema_id_fk = s.id
AND s.catalog_id_fk = cat.id
AND cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_PROGRAMS_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_PROGRAMS_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME") AS 
  SELECT 'MD_STORED_PROGRAMS' objtype,p.name objname, p.Id objid,  'MD_STORED_PROGRAMS' MainObjType,p.name MAINOBJNAME,p.id MAINOBJID, s.name SchemaName, s.id schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid,proj.project_name projectname,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN cat.catalog_name||'.' ELSE '' END || s.name||'.'||p.name  QualifiedName
FROM MD_STORED_PROGRAMS p,MD_SCHEMAS s, MD_CATALOGS cat,MD_CONNECTIONS conn, MD_PROJECTS proj
WHERE p.schema_id_fk = s.id
AND s.catalog_id_fk = cat.id
AND cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_SCHEMA
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_SCHEMA" ("PROJECT_ID", "PROJECT_NAME", "CONNECTION_ID", "HOST", "PORT", "USERNAME", "CATALOG_ID", "CATALOG_NAME", "SCHEMA_ID", "SCHEMA_NAME") AS 
  SELECT md_projects.id project_id ,
    md_projects.project_name project_name,
    md_connections.id connection_id ,
    md_connections.host host ,
    md_connections.port port ,
    md_connections.username username ,
    md_catalogs.id catalog_id ,
    md_catalogs.catalog_name catalog_name,
    md_schemas.id schema_id ,
    md_schemas.name schema_name
  FROM md_connections,
    md_catalogs ,
    md_schemas ,
    md_projects
  WHERE md_schemas.catalog_id_fk   = md_catalogs.id
  AND md_catalogs.connection_id_fk = md_connections.id
  AND md_connections.project_id_fk = md_projects.id
WITH READ ONLY;
--------------------------------------------------------
--  DDL for View MGV_ALL_SCHEMA_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_SCHEMA_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME") AS 
  SELECT 'MD_SCHEMAS' objtype, s.name objname, s.id objid,  'MD_SCHEMAS' MainObjType,s.name MAINOBJNAME, s.id MAINOBJID, s.name SchemaName, s.id schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid,proj.project_name projectname,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN cat.catalog_name||'.' ELSE '' END || s.name QualifiedName
FROM MD_SCHEMAS s, MD_CATALOGS cat,MD_CONNECTIONS conn, MD_PROJECTS proj
WHERE s.catalog_id_fk = cat.id
AND cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_STORED_PROGRAMS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_STORED_PROGRAMS" ("PROJECT_ID", "PROJECT_NAME", "CONNECTION_ID", "HOST", "PORT", "USERNAME", "CATALOG_ID", "CATALOG_NAME", "SCHEMA_ID", "SCHEMA_NAME", "STORED_PROGRAM_ID", "PROGRAMTYPE", "STORED_PROGRAM_NAME", "PACKAGE_ID_FK") AS 
  SELECT md_projects.id project_id ,
    md_projects.project_name project_name ,
    md_connections.id connection_id ,
    md_connections.host host ,
    md_connections.port port ,
    md_connections.username username ,
    md_catalogs.id catalog_id ,
    md_catalogs.catalog_name catalog_name ,
    md_schemas.id schema_id ,
    md_schemas.name schema_name ,
    md_stored_programs.id stored_program_id ,
    md_stored_programs.programtype programtype ,
    md_stored_programs.name stored_program_name,
    md_stored_programs.package_id_fk package_id_fk
  FROM md_projects ,
    md_connections,
    md_catalogs ,
    md_schemas ,
    md_stored_programs
  WHERE md_stored_programs.schema_id_fk = md_schemas.id
  AND md_schemas.catalog_id_fk          = md_catalogs.id
  AND md_catalogs.connection_id_fk      = md_connections.id
  AND md_connections.project_id_fk      = md_projects.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_TABLES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_TABLES" ("PROJECT_ID", "PROJECT_NAME", "CONNECTION_ID", "HOST", "PORT", "USERNAME", "DBURL", "CATALOG_ID", "CATALOG_NAME", "SCHEMA_ID", "SCHEMA_NAME", "TABLE_ID", "TABLE_NAME") AS 
  SELECT md_projects.id project_id ,
    md_projects.project_name project_name,
    md_connections.id connection_id ,
    md_connections.host host ,
    md_connections.port port ,
    md_connections.username username ,
    md_connections.dburl dburl ,
    md_catalogs.id catalog_id ,
    md_catalogs.catalog_name catalog_name,
    md_schemas.id schema_id ,
    md_schemas.name schema_name ,
    md_tables.id table_id ,
    md_tables.TABLE_NAME TABLE_NAME
  FROM md_connections,
    md_catalogs ,
    md_schemas ,
    md_tables ,
    md_projects
  WHERE md_tables.schema_id_fk     = md_schemas.id
  AND md_schemas.catalog_id_fk     = md_catalogs.id
  AND md_catalogs.connection_id_fk = md_connections.id
  AND md_connections.project_id_fk = md_projects.id
WITH READ ONLY;
--------------------------------------------------------
--  DDL for View MGV_ALL_TABLES_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_TABLES_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME") AS 
  SELECT 'MD_TABLES' objtype, t.table_name objname, t.id objid,  'MD_TABLES' MainObjType,t.table_name MAINOBJNAME, t.id MAINOBJID, s.name SchemaName, s.id schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid,proj.project_name projectname,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN  
      CASE WHEN ident.iscatalogrequired = 1 THEN ident.ldelimiter||cat.catalog_name||ident.rdelimiter||'.' ELSE '' END|| 
      CASE WHEN ident.isschemarequired = 1   THEN ident.ldelimiter || s.name||ident.rdelimiter||'.' ELSE '' END ||ident.ldelimiter|| t.table_name||ident.rdelimiter  ELSE s.name||'.'||t.table_name END QualifiedName
FROM MD_TABLES t,MD_SCHEMAS s, MD_CATALOGS cat,MD_CONNECTIONS conn, MD_PROJECTS proj,mgv_identifier_delimiter ident
WHERE t.schema_id_fk = s.id
AND s.catalog_id_fk = cat.id
AND cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id
AND ident.connection_id_fk = conn.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_TABLE_TRIGGERS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_TABLE_TRIGGERS" ("PROJECT_ID", "PROJECT_NAME", "CONNECTION_ID", "HOST", "PORT", "USERNAME", "CATALOG_ID", "CATALOG_NAME", "DUMMY_FLAG", "SCHEMA_ID", "SCHEMA_NAME", "TABLE_ID", "TABLE_NAME", "TRIGGER_ID", "TRIGGER_NAME") AS 
  SELECT md_projects.id project_id ,
    md_projects.project_name project_name,
    md_connections.id connection_id ,
    md_connections.host host ,
    md_connections.port port ,
    md_connections.username username ,
    md_catalogs.id catalog_id ,
    md_catalogs.catalog_name catalog_name,
    md_catalogs.dummy_flag dummy_flag ,
    md_schemas.id schema_id ,
    md_schemas.name schema_name ,
    md_tables.id table_id ,
    md_tables.TABLE_NAME TABLE_NAME ,
    md_triggers.id trigger_id ,
    md_triggers.trigger_name trigger_name
  FROM md_projects ,
    md_connections,
    md_catalogs ,
    md_schemas ,
    md_tables ,
    md_triggers
  WHERE md_triggers.table_or_view_id_fk = md_tables.id
  AND md_tables.schema_id_fk            = md_schemas.id
  AND md_schemas.catalog_id_fk          = md_catalogs.id
  AND md_catalogs.connection_id_fk      = md_connections.id
  AND md_connections.project_id_fk      = md_projects.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_TRIGGER_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_TRIGGER_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME") AS 
  SELECT 'MD_TRIGGERS' objtype,trig.trigger_name objname, trig.Id objid,  'MD_TABLES' MainObjType,t.table_name MAINOBJNAME,t.id MAINOBJID, s.name SchemaName, s.id schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid,proj.project_name projectname,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN cat.catalog_name||'.' ELSE '' END || s.name||'.'||trig.trigger_name  QualifiedName
FROM MD_TRIGGERS trig, MD_TABLES t,MD_SCHEMAS s, MD_CATALOGS cat,MD_CONNECTIONS conn, MD_PROJECTS proj
WHERE trig.table_or_view_id_fk = t.id
AND t.schema_id_fk = s.id
AND s.catalog_id_fk = cat.id
AND cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id 
UNION
SELECT 'MD_TRIGGERS' objtype,trig.trigger_name objname, trig.Id objid,  'MD_VIEWS' MainObjType,v.view_name MAINOBJNAME,v.id MAINOBJID, s.name SchemaName, s.id schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid,proj.project_name projectname,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN cat.catalog_name||'.' ELSE '' END || s.name||'.'||trig.trigger_name  QualifiedName
FROM MD_TRIGGERS trig, MD_VIEWS v,MD_SCHEMAS s, MD_CATALOGS cat,MD_CONNECTIONS conn, MD_PROJECTS proj
WHERE trig.table_or_view_id_fk = v.id
AND v.schema_id_fk = s.id
AND s.catalog_id_fk = cat.id
AND cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id 
ORDER BY objid;
--------------------------------------------------------
--  DDL for View MGV_ALL_VIEW_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_VIEW_DETAILS" ("OBJTYPE", "OBJNAME", "OBJID", "MAINOBJTYPE", "MAINOBJNAME", "MAINOBJID", "SCHEMANAME", "SCHEMAID", "CATALOGNAME", "CATALOGID", "CONNNAME", "CONNID", "PROJECTNAME", "PROJECTID", "CAPTUREDORCONVERTED", "QUALIFIEDNAME") AS 
  SELECT 'MD_VIEWS' objtype, v.view_name objname, v.Id objid,  'MD_VIEWS' MainObjType,v.view_name MAINOBJNAME,v.id MAINOBJID, s.name SchemaName, s.id schemaid, cat.catalog_name catalogname,cat.id catalogid, conn.name connname,conn.id  connid,proj.project_name projectname,proj.id projectid,
NVL(conn.type,'CAPTURED') CapturedOrConverted, 
CASE WHEN conn.type IS NULL THEN cat.catalog_name||'.' ELSE '' END || s.name||'.'||v.view_name  QualifiedName
FROM MD_VIEWS v,MD_SCHEMAS s, MD_CATALOGS cat,MD_CONNECTIONS conn, MD_PROJECTS proj
WHERE v.schema_id_fk = s.id
AND s.catalog_id_fk = cat.id
AND cat.connection_id_fk = conn.id
AND conn.PROJECT_ID_FK = proj.id;
--------------------------------------------------------
--  DDL for View MGV_ALL_VIEWS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_VIEWS" ("PROJECT_ID", "PROJECT_NAME", "CONNECTION_ID", "HOST", "PORT", "USERNAME", "CATALOG_ID", "CATALOG_NAME", "DUMMY_FLAG", "SCHEMA_ID", "SCHEMA_NAME", "VIEW_ID", "VIEW_NAME") AS 
  SELECT md_projects.id project_id ,
    md_projects.project_name project_name,
    md_connections.id connection_id ,
    md_connections.host host ,
    md_connections.port port ,
    username username ,
    md_catalogs.id catalog_id ,
    md_catalogs.catalog_name catalog_name,
    md_catalogs.dummy_flag dummy_flag ,
    md_schemas.id schema_id ,
    md_schemas.name schema_name ,
    md_views.id view_id ,
    md_views.view_name view_name
  FROM md_projects ,
    md_connections,
    md_catalogs ,
    md_schemas ,
    md_views
  WHERE md_views.schema_id_fk      = md_schemas.id
  AND md_schemas.catalog_id_fk     = md_catalogs.id
  AND md_catalogs.connection_id_fk = md_connections.id
  AND md_connections.project_id_fk = md_projects.id
WITH READ ONLY;

   COMMENT ON TABLE "ACMMH"."MGV_ALL_VIEWS"  IS 'View to iterate over all views in the system';
--------------------------------------------------------
--  DDL for View MGV_ALL_VIEW_TRIGGERS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_ALL_VIEW_TRIGGERS" ("PROJECT_ID", "PROJECT_NAME", "CONNECTION_ID", "HOST", "PORT", "USERNAME", "CATALOG_ID", "CATALOG_NAME", "DUMMY_FLAG", "SCHEMA_ID", "SCHEMA_NAME", "VIEW_ID", "VIEW_NAME", "TRIGGER_ID", "TRIGGER_NAME") AS 
  SELECT md_projects.id project_id ,
    md_projects.project_name project_name,
    md_connections.id connection_id ,
    md_connections.host host ,
    md_connections.port port ,
    md_connections.username username ,
    md_catalogs.id catalog_id ,
    md_catalogs.catalog_name catalog_name,
    md_catalogs.dummy_flag dummy_flag ,
    md_schemas.id schema_id ,
    md_schemas.name schema_name ,
    md_views.id view_id ,
    md_views.view_name view_name ,
    md_triggers.id trigger_id ,
    md_triggers.trigger_name trigger_name
  FROM md_projects ,
    md_connections,
    md_catalogs ,
    md_schemas ,
    md_views ,
    md_triggers
  WHERE md_triggers.table_or_view_id_fk = md_views.id
  AND md_views.schema_id_fk             = md_schemas.id
  AND md_schemas.catalog_id_fk          = md_catalogs.id
  AND md_catalogs.connection_id_fk      = md_connections.id
  AND md_connections.project_id_fk      = md_projects.id;
--------------------------------------------------------
--  DDL for View MGV_DERIVATIVES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_DERIVATIVES" ("ID", "SRC_ID", "SRC_TYPE", "DERIVED_ID", "DERIVED_TYPE", "DERIVED_CONNECTION_ID_FK", "TRANSFORMED", "ORIGINAL_IDENTIFIER", "NEW_IDENTIFIER", "DERIVED_OBJECT_NAMESPACE", "DERIVATIVE_REASON", "SECURITY_GROUP_ID", "CREATED_ON", "CREATED_BY", "LAST_UPDATED_ON", "LAST_UPDATED_BY") AS 
  SELECT "ID","SRC_ID","SRC_TYPE","DERIVED_ID","DERIVED_TYPE","DERIVED_CONNECTION_ID_FK","TRANSFORMED","ORIGINAL_IDENTIFIER","NEW_IDENTIFIER","DERIVED_OBJECT_NAMESPACE","DERIVATIVE_REASON","SECURITY_GROUP_ID","CREATED_ON","CREATED_BY","LAST_UPDATED_ON","LAST_UPDATED_BY" FROM MD_DERIVATIVES WHERE (Derivative_Reason <> 'SCRATCH' OR DERIVative_Reason IS NULL);
--------------------------------------------------------
--  DDL for View MGV_DERIVED_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_DERIVED_DETAILS" ("CAPCATALOGID", "CAPCATALOGNAME", "CAPCONNID", "CAPCONNNAME", "CAPMAINOBJID", "CAPMAINOBJNAME", "CAPMAINOBJTYPE", "CAPOBJID", "CAPOBJNAME", "CAPOBJTYPE", "CAPPROJECTID", "CAPPROJECTNAME", "CAPQUALIFIEDNAME", "CAPSCHEMAID", "CAPSCHEMANAME", "CONCATALOGID", "CONCATALOGNAME", "CONCONNID", "CONCONNNAME", "CONMAINOBJID", "CONMAINOBJNAME", "CONMAINOBJTYPE", "CONOBJID", "CONOBJNAME", "CONOBJTYPE", "CONPROJECTID", "CONPROJECTNAME", "CONQUALIFIEDNAME", "CONSCHEMAID", "CONSCHEMANAME", "DERIVATIVE_REASON") AS 
  SELECT d1.catalogid capcatalogid,
    d1.catalogname capcatalogname,
    d1.connid capconnid,
    d1.connname capconnname,
    d1.mainobjid capmainobjid,
    d1.mainobjname capmainobjname,
    d1.mainobjtype capmainobjtype ,
    d1.objid capobjid,
    d1.objname capobjname,
    d1.objtype capobjtype,
    d1.projectid capprojectid,
    d1.projectname capprojectname,
    d1.qualifiedname capqualifiedname,
    d1.schemaid capschemaid,
    d1.schemaname capschemaname,
    d2.catalogid concatalogid,
    d2.catalogname concatalogname,
    d2.connid conconnid,
    d2.connname conconnname,
    d2.mainobjid conmainobjid,
    d2.mainobjname conmainobjname,
    d2.mainobjtype conmainobjtype ,
    d2.objid conobjid,
    d2.objname conobjname,
    d2.objtype conobjtype,
    d2.projectid conprojectid,
    d2.projectname conprojectname,
    d2.qualifiedname conqualifiedname,
    d2.schemaid conschemaid,
    d2.schemaname conschemaname,
    der.derivative_reason
  FROM mgv_all_details d1
  LEFT OUTER JOIN md_derivatives der
  ON der.src_id              = d1.objid
  AND der.derivative_reason IS NULL
  LEFT OUTER JOIN mgv_all_details d2
  ON der.derived_id            = d2.objid
  WHERE d1.capturedorconverted = 'CAPTURED'
  AND der.derivative_reason   IS NULL;
--------------------------------------------------------
--  DDL for View MGV_IDENTIFIER_DELIMITER
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_IDENTIFIER_DELIMITER" ("CONNECTION_ID_FK", "VALUE", "LDELIMITER", "RDELIMITER", "ISCATALOGREQUIRED", "ISSCHEMAREQUIRED") AS 
  SELECT CONNECTION_ID_FK,
    VALUE,
    CASE
      WHEN VALUE LIKE '%Sybase%'
      THEN '['
      WHEN VALUE LIKE '%SQLServer%'
      THEN '['
      WHEN VALUE LIKE '%MSAccess%'
      THEN '['
      WHEN VALUE LIKE '%MySQL%'
      THEN'`'
      WHEN VALUE LIKE '%DB2%'
      THEN '"'
      WHEN VALUE LIKE '%Teradata%'
      THEN '"'
      ELSE NULL
    END LDELIMITER,
    CASE
      WHEN VALUE LIKE '%Sybase%'
      THEN ']'
      WHEN VALUE LIKE '%SQLServer%'
      THEN ']'
      WHEN VALUE LIKE '%MSAccess%'
      THEN ']'
      WHEN VALUE LIKE '%MySQL%'
      THEN'`'
      WHEN VALUE LIKE '%DB2%'
      THEN '"'
      WHEN VALUE LIKE '%Teradata%'
      THEN '"'
      ELSE NULL
    END RDELIMITER,
    CASE
      WHEN VALUE LIKE '%Sybase%'
      THEN 1
      WHEN VALUE LIKE '%SQLServer%'
      THEN 1
      WHEN VALUE LIKE '%MSAccess%'
      THEN 0
      WHEN VALUE LIKE '%MySQL%'
      THEN 0
      WHEN VALUE LIKE '%DB2%'
      THEN 0
      WHEN VALUE LIKE '%Teradata%'
      THEN 0
      ELSE 1
      END ISCATALOGREQUIRED , 
      CASE
      WHEN VALUE LIKE '%Sybase%'
      THEN 1
      WHEN VALUE LIKE '%SQLServer%'
      THEN 1
      WHEN VALUE LIKE '%MSAccess%'
      THEN 0
      WHEN VALUE LIKE '%MySQL%'
      THEN 1
      WHEN VALUE LIKE '%DB2%'
      THEN 1
      WHEN VALUE LIKE '%Teradata%'
      THEN 1
      ELSE 1
      END ISSCHEMAREQUIRED 
  FROM MD_ADDITIONAL_PROPERTIES
  WHERE LOWER(PROP_KEY) = 'plugin_id';
--------------------------------------------------------
--  DDL for View MGV_SCRATCH_DERIVATIVES
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."MGV_SCRATCH_DERIVATIVES" ("ID", "SRC_ID", "SRC_TYPE", "DERIVED_ID", "DERIVED_TYPE", "DERIVED_CONNECTION_ID_FK", "TRANSFORMED", "ORIGINAL_IDENTIFIER", "NEW_IDENTIFIER", "DERIVED_OBJECT_NAMESPACE", "DERIVATIVE_REASON", "SECURITY_GROUP_ID", "CREATED_ON", "CREATED_BY", "LAST_UPDATED_ON", "LAST_UPDATED_BY") AS 
  SELECT "ID","SRC_ID","SRC_TYPE","DERIVED_ID","DERIVED_TYPE","DERIVED_CONNECTION_ID_FK","TRANSFORMED","ORIGINAL_IDENTIFIER","NEW_IDENTIFIER","DERIVED_OBJECT_NAMESPACE","DERIVATIVE_REASON","SECURITY_GROUP_ID","CREATED_ON","CREATED_BY","LAST_UPDATED_ON","LAST_UPDATED_BY" FROM MD_DERIVATIVES WHERE Derivative_Reason = 'SCRATCH';
--------------------------------------------------------
--  DDL for View VIEW_BUCAR_SOCIO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."VIEW_BUCAR_SOCIO" ("TRAN_IDE", "TRAN_CODIGO", "TRAN_PUESTO", "TRAN_RAZON_SOCIAL", "DNI") AS 
  SELECT tran_ide, tran_codigo, tran_puesto, tran_razon_social, pm.dni as dni
FROM sisgap_socio ss 
      INNER JOIN padron_mmh pm ON TO_NUMBER(TRIM(pm.padron)) = TO_NUMBER(SUBSTR(TRIM(ss.tran_codigo),3))
WHERE tran_estado NOT LIKE 'Inactivo' 
ORDER BY tran_razon_social;
--------------------------------------------------------
--  DDL for View VIEW_BUSCAR_ITEM
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."VIEW_BUSCAR_ITEM" ("COD_ITEMCOBRANZA", "NUM_COSTO", "STR_MONEDA", "STR_TIPOCOBRANZA", "NUM_ESTADO", "STR_DESCRIPCION", "COD_RECIBOLUZ", "STR_TIPO", "DAT_FECHAFIN", "STR_FLGVARIABLE", "NUM_COBROADICIONAL", "STR_FLGCOBROSOCIO") AS 
  SELECT COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ, STR_TIPO, DAT_FECHAFIN, STR_FLGVARIABLE, NUM_COBROADICIONAL, STR_FLGCOBROSOCIO
FROM SISGAP_ITEMCOBRANZA;
--------------------------------------------------------
--  DDL for View VIEW_BUSCAR_RECIBO_SOCIO
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."VIEW_BUSCAR_RECIBO_SOCIO" ("CODIGOSOCIO", "TRAN_CODIGO", "CODIGORECIBO", "LECTURAINI", "LECTURAFIN", "TOTAL", "ESTADO", "DEUDAANT", "FECHACARGA") AS 
  SELECT 
    SRL.CODIGOSOCIO,
    SS.TRAN_CODIGO,
    SRL.CODIGORECIBO,
    SRL.LECTURAINI,
    SRL.LECTURAFIN,
    SRL.TOTAL,
    SRL.ESTADO,
    SRL.DEUDAANT,
    SRL.FECHACARGA
FROM
    SISGAP_RECIBOLUZ_SOCIO SRL 
    INNER JOIN SISGAP_SOCIO SS ON SRL.CODIGOSOCIO = SS.TRAN_IDE;
--------------------------------------------------------
--  DDL for View VIEW1
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "ACMMH"."VIEW1" ("COD_ITEMCOBRANZA", "NUM_COSTO", "STR_MONEDA", "STR_TIPOCOBRANZA", "NUM_ESTADO", "STR_DESCRIPCION") AS 
  SELECT COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION FROM SISGAP_ITEMCOBRANZA
WHERE STR_DESCRIPCION like '%?%';
REM INSERTING into ACMMH.SIS_CONCEPTO
SET DEFINE OFF;
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('1','VIGILANCIA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('2','CONSUMO DE LUZ','1','L');
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('3','CONSUMO DE AGUA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('4','CUOTA ORDINARIA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('5','CUOTA AUTOVALUO','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('6','CUOTA EXTRAORDINARIA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('7','ALQUILER ESPACIOS','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('8','OTROS','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('9','FORMATO DE SOLICITUD','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('10','CUOTAS ADMINISTRATIVAS','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('11','CONVENIO DE LUZ','1','L');
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('12','RECONECCION DE LUZ','1','L');
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('13','DERECHO DE CARTA PODER','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('14','EJECUCION DE ELECTRIFICACION','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('15','INSCRIPCION DE ELECTRIFICACION','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('16','INSTALACION DE CABLEADO','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('17','ALQUILER DE PUESTO LIBRE','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('18','RENOVACION DE CARTA PODER','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('19','SOLDADURA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('20','DERECHO DE CONSTRUCCION','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('21','ESTADO DE CUENTA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('22','CERTIFICADO DE SOCIO','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('23','RENUNCIA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('24','PERMISO','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('25','ACABADO SERVICIOS HIGIENICOS','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('26','DEUDA DE CONSTRUCCION','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('27','INASISTENCIAS DE SAMBLEA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('28','TANQUE ELEVADO','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('29','ALCANTARILLADO','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('30','INSTALACION INTERNA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('31','ACABADO DE SERVICIOS HIGIENICOS','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('32','CUOTA DE ANIVERSARIO','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('33','MODELO COMPRA VENTA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('34','CARNET','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('35','ACTIVIDADES 2007','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('36','AFIRMADO CERCO PERIMETRO','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('37','ASESORIA AUDITORIA PERITAJE 2007','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('38','CUOTA COMITE ELECTORAL 2007','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('39','CUOTA DE ANIVERSARIO 2007','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('40','CUOTA DE ANIVERSARIO 2008','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('41','CUOTA PROCESO JUDICIAL 2008','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('42','ELECTRIFICACION PROVINCIAL 2007','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('43','FUMIGACION Y DESRRATIZACION 2007','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('44','INSCRIPCION DE ESTATUTO 2007','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('45','MULTA DE ASISTENCIA 2007','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('46','PROYECTO DE LUZ','1','L');
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('47','REGISTRO PUBLICO PROG. RADIAL','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('48','ELECCIONES 2015','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('49','MULTAS ASAMBLEAS 2015','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('50','DEUDA ANTERIOR','1','L');
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('51','CERCO PERIMETRICO','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('52','FUMIGACION Y DESARRATIZACION 2008','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('53','PROYECTO DE LUZ 2007','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('54','CONTRATO COMPRA - VENTA','1',null);
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('55','CARGO POR ENERGIA','1','L');
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('56','ALUMBRADO PUBLICO','1','L');
Insert into ACMMH.SIS_CONCEPTO (CODIGO_CONCEPTO,NOMBRE_CONCEPTO,ESTADO,RUBRO) values ('57','MANTENIMIENTO','1','L');
REM INSERTING into ACMMH.SIS_FACTURACION_CAB
SET DEFINE OFF;
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('1','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('2','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('3','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('4','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('5','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('6','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('7','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('8','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('9','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('10','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('12','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('13','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('11','1','0001','00002','1','1',to_date('02/11/15','DD/MM/RR'),null,null);
Insert into ACMMH.SIS_FACTURACION_CAB (CODIGO_FACTURACION_CAB,CODIGO_USUARIO,SERIE,SECUENCIA,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION) values ('21','0','0001','00002','1','2',to_date('08/11/15','DD/MM/RR'),null,null);
REM INSERTING into ACMMH.SIS_FACTURACION_DET
SET DEFINE OFF;
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('5','7','3','10','3');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('6','7','2','50','3');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('7','10','3','10','4');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('8','10','2','100','4');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('9','10','3','12','5');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('10','10','2','45','5');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('11','10','3','10','6');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('12','10','2','50','6');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('13','10','3','15','7');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('14','10','2','60','7');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('15','10','3','15','8');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('16','10','2','60','8');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('17','10','3','15','9');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('18','10','2','60','9');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('19','10','3','18','10');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('20','10','2','50','10');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('23','2','3','10','12');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('24','2','2','50','12');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('25','10','3','10','13');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('26','10','2','50','13');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('21','10','3','15','11');
Insert into ACMMH.SIS_FACTURACION_DET (CODIGO_FACTURACION_DET,CODIGO_PUESTO,CODIGO_CONCEPTO,MONTO,CODIGO_FACTURACION_CAB) values ('22','10','2','78','11');
REM INSERTING into ACMMH.SIS_GIRO_COMERCIAL
SET DEFINE OFF;
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('3','BAZAR-COSMETOLOGIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('4','BAZAR-JOYERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('5','BAZAR-JUGUETERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('6','BAZAR-LENCERÍA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('7','BAZAR-LIBRERÍA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('8','BAZAR-LOCERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('9','BAZAR-PASAMANERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('10','BAZAR-RELOJERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('1','BAZAR','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('2','BAZAR-ARTESANÍA-SOMBRERO','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('11','BAZAR-ZAPATERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('12','JUGUETERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('13','LICORERIA-CONFITERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('14','LOCERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('15','LOCERIA-PLASTICOS','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('16','LOCERIA-PLASTICOS-JUGUET.','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('17','PLASTICOS','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('18','RELOJERÍA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('19','RELOJERÍA-JOYERÍA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('20','ZAPATERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('21','ZAPATERIA-PASAMANERIA','01','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('22','GOLOSINAS','02','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('23','GOLOSINAS-PERIODICO-REVIST.','02','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('24','GOLOSINAS-PIÑATERIA','02','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('25','IMPRENTA','02','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('26','IMPRENTA-LIBRERÍA','02','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('27','LIBRERÍA','02','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('28','LIBRERÍA-REVISTAS','02','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('29','PERIODICO-REVISTAS','02','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('30','PIÑATERIA','02','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('31','PIÑATERIA-DESCARTABLES','02','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('32','CONFECCION DE ROPA','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('33','CONFECCION Y VENTA- ROPA','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('34','FRAZADAS-CUBRECAMAS','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('35','MERCERIA','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('36','MERCERIA-DESCARTABLES','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('37','MERCERIA-SOMBRERO','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('38','ROPA','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('39','ROPA DE NIÑOS','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('40','ROPA-FRAZADAS','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('41','ROPA-LENCERÍA','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('42','ROPA-MERCERIA','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('43','ROPA-SOMBREROS','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('44','ROPA-TELA','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('45','SOMBREROS','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('46','TELA','03','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('47','ABARROTES','04','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('48','ABARROTES-ALIM. BALANCEAD.','04','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('49','ABARROTES-GRANOS SECOS','04','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('50','ALIMENTOS BALANCEADOS','04','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('51','ARTICULOS DE LIMPIEZA','04','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('52','BODEGA','04','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('53','GRANOS SECOS','04','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('54','GRANOS Y FRUTAS SECAS','04','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('55','NATURISTA','04','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('56','NATURISTA','04','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('57','CEVICHERIA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('58','COMIDA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('59','COMIDA-CEVICHERIA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('60','COMIDA-CEVICHERIA-CAFETERIA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('61','DULCERIA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('62','EMBUTIDOS','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('63','EMBUTIDOS Y LACTEOS','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('64','EMOLIENTES','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('65','FUENTE DE SODA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('66','JUGUERIA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('67','JUGUERIA-COMIDA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('68','JUGUERIA-DULCERIA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('69','JUGUERIA-DULCERIA-REFRESCO','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('70','JUGUERIA-EMOLIENTES','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('71','JUGUERIA-REFRESCO','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('72','PANADERIA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('73','PANADERIA-EMBUTIDOS','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('74','PANADERIA-LACTEOS','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('75','PANADERIA-PASTELER.-EMBUTID.','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('76','PANADERIA-PASTELERIA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('77','PASTELERIA','05','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('78','ANTIGÜEDADES-ARTESANIAS','06','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('79','ARTESANIA','06','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('80','CARBÓN','06','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('81','DECORACION','06','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('82','ELECTRODOMESTICOS','06','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('83','ELECTRODOM-FERRETERIA','06','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('84','FERRETERIA      ','06','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('85','FLORERIA','06','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('86','MUEBLERIA','06','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('87','REPUESTOS','06','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('88','ALFALFA','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('89','FRUTAS','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('90','FRUTAS-PLANTAS FRUTALES','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('91','LIMONES','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('92','TUBERCULOS','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('93','VERDURA CHINA','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('94','VERDURAS','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('95','VERDURAS-CHOCLOS','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('96','VERDURAS-GRANOS VERDES','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('97','VERDURAS-LIMONES','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('98','VERDURAS-TUBERCULOS','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('99','VERDURAS-TUBERCULOS-LIMONES','07','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('100','CASSETTES','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('101','CASSETTES-CD','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('102','CASSETTES-CD-VIDEOS','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('103','EQUIPO-SIST.COMP-CASSET','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('104','PELUQUERIA-SALON BELLEZA','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('105','PRODUCTOS VETERINARIOS','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('106','RENOVADORA CALZADO','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('107','SALON DE BELLEZA','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('108','TECNICO ELECTRONICA','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('109','AVES','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('110','AVES-HUEVOS','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('111','AVES-MENUDENCIAS','08','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('112','CARNE','09','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('113','CARNE-AVES-MENUDENCIAS','09','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('114','CARNE-MENUDENCIA','09','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('115','MENUDENCIAS','09','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('116','MARISCOS','10','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('117','PESCADOS Y MARISCOS','10','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('118','ESPECERIA','11','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('119','ESPECERIA-DESCARTABLE','11','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('120','ESPECIES-BOLSAS PLÁSTICAS','11','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('121','ESPECIES-DETERGENTES','11','1');
Insert into ACMMH.SIS_GIRO_COMERCIAL (CODIGO_GIRO,NOMBRE_GIRO,SECTOR,ESTADO) values ('122','ANIMALES VIVOS','12','1');
REM INSERTING into ACMMH.SIS_MENU
SET DEFINE OFF;
Insert into ACMMH.SIS_MENU (CODIGO_MENU,DESCRIPCION,ORDEN,ESTADO) values ('1','Reportes','1','1');
Insert into ACMMH.SIS_MENU (CODIGO_MENU,DESCRIPCION,ORDEN,ESTADO) values ('2','Mantenimiento','2','1');
Insert into ACMMH.SIS_MENU (CODIGO_MENU,DESCRIPCION,ORDEN,ESTADO) values ('3','Seguridad','3','1');
Insert into ACMMH.SIS_MENU (CODIGO_MENU,DESCRIPCION,ORDEN,ESTADO) values ('4','Facturacion','4','1');
Insert into ACMMH.SIS_MENU (CODIGO_MENU,DESCRIPCION,ORDEN,ESTADO) values ('5','Servicios','5','1');
REM INSERTING into ACMMH.SIS_MENU_NIVELES
SET DEFINE OFF;
Insert into ACMMH.SIS_MENU_NIVELES (CODIGO_NIVELES,DESCRIPCION,LINK,ORDEN,NIVEL,ESTADO,CODIGO_MENU) values ('1','Usuario','usuarios','1','1','1','2');
Insert into ACMMH.SIS_MENU_NIVELES (CODIGO_NIVELES,DESCRIPCION,LINK,ORDEN,NIVEL,ESTADO,CODIGO_MENU) values ('2','Puesto','puesto','2','1','1','2');
Insert into ACMMH.SIS_MENU_NIVELES (CODIGO_NIVELES,DESCRIPCION,LINK,ORDEN,NIVEL,ESTADO,CODIGO_MENU) values ('3','Cobros','cobro','1','1','1','4');
Insert into ACMMH.SIS_MENU_NIVELES (CODIGO_NIVELES,DESCRIPCION,LINK,ORDEN,NIVEL,ESTADO,CODIGO_MENU) values ('4','Recibo Luz','recibo_luz','1','1','1','5');
REM INSERTING into ACMMH.SIS_MENU_USUARIO
SET DEFINE OFF;
Insert into ACMMH.SIS_MENU_USUARIO (CODIGO_MENU_USUARIO,CODIGO_NIVELES,CODIGO_USUARIO) values ('1','1','1');
Insert into ACMMH.SIS_MENU_USUARIO (CODIGO_MENU_USUARIO,CODIGO_NIVELES,CODIGO_USUARIO) values ('2','2','1');
Insert into ACMMH.SIS_MENU_USUARIO (CODIGO_MENU_USUARIO,CODIGO_NIVELES,CODIGO_USUARIO) values ('3','3','1');
Insert into ACMMH.SIS_MENU_USUARIO (CODIGO_MENU_USUARIO,CODIGO_NIVELES,CODIGO_USUARIO) values ('4','1','2');
Insert into ACMMH.SIS_MENU_USUARIO (CODIGO_MENU_USUARIO,CODIGO_NIVELES,CODIGO_USUARIO) values ('5','2','2');
Insert into ACMMH.SIS_MENU_USUARIO (CODIGO_MENU_USUARIO,CODIGO_NIVELES,CODIGO_USUARIO) values ('6','3','2');
Insert into ACMMH.SIS_MENU_USUARIO (CODIGO_MENU_USUARIO,CODIGO_NIVELES,CODIGO_USUARIO) values ('7','4','2');
REM INSERTING into ACMMH.SIS_PUESTO
SET DEFINE OFF;
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('2','1','0145','47','1',to_date('22/10/15','DD/MM/RR'),'1',to_date('22/10/15','DD/MM/RR'),'0',null);
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('3','1','1855','67','1',to_date('22/10/15','DD/MM/RR'),null,null,'1','1');
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('4','1','1874','109','1',to_date('22/10/15','DD/MM/RR'),null,null,'1','1');
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('5','1','4787','13','1',to_date('22/10/15','DD/MM/RR'),null,null,'1',null);
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('6','1','4787','13','1',to_date('22/10/15','DD/MM/RR'),null,null,'1',null);
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('7','1','4787','13','1',to_date('22/10/15','DD/MM/RR'),null,null,'1',null);
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('8','1','1234','122','1',to_date('22/10/15','DD/MM/RR'),null,null,'1','1');
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('10','1','2010','47','1',to_date('22/10/15','DD/MM/RR'),null,null,'1',null);
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('21','2','7888','92','1',to_date('27/10/15','DD/MM/RR'),null,null,'1',null);
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('9','1','2015','47','1',to_date('22/10/15','DD/MM/RR'),'1',to_date('22/10/15','DD/MM/RR'),'1',null);
Insert into ACMMH.SIS_PUESTO (CODIGO_PUESTO,CODIGO_USUARIO,NRO_PUESTO,CODIGO_GIRO,USUARIO_REGISTRO,FECHA_REGISTRO,USUARIO_MODIFICACION,FECHA_MODIFICACION,ESTADO,RECIBO_LUZ) values ('11','2','2020','47','1',to_date('22/10/15','DD/MM/RR'),'1',to_date('27/10/15','DD/MM/RR'),'1',null);
REM INSERTING into ACMMH.SIS_RECIBOLUZ_ORG
SET DEFINE OFF;
Insert into ACMMH.SIS_RECIBOLUZ_ORG (COD_ORGRECIBO_LUZ,NUM_LECTURA_INICIAL,NUM_LECTURA_FINAL,NUM_MONTO,NUM_COSTO_WATS,FEC_PERIODO,NUM_PENDIENTE_FAC,NUM_ESTADO,REPOMANCNX,CARGOFIJO,ALUMPUBLIC,SUBTOTALMES,IGV,TOTALMESACT,APORTELEY,CUOTACONV,REDONMESACT,REDONMESANT,INTERESCONVENIO,ENERGACTFRAPTAACTUAL,ENERGACTFRAPTAANTERI,ENERGACTFRAPTADIFER,ENERGACTFRAPTAFACTOR,ENERGACTFRAPTACONSU,ENERGACTFRAPTACONFA,ENERGACTFRAPTAPREUNI,ENERGACTFRAPTATOTAL,ENERGACTHORPTAACTU,ENERGACTHORPTAANT,ENERGACTHORPTADIF,ENERGACTHORPTAFAC,ENERGACTHORPTACONS,ENERGACTHORPTACONFAC,ENERGACTHORPTAPREUNI,ENERGACTHORPTATOTAL,ENERGREACINICIAL,ENERGREACANTERI,ENERGREACDIFERE,ENERGREACFACTOR,ENERGREACCONSU,ENERGREACFACCONS,ENERGREACPREUNI,ENERGREACTOTAL,POTENCIAFPINI,POTENCIAFPANTE,POTENCIAFPDIF,POTENCIAFPFAC,POTENCIAFPCONS,POTENCIAHPACT,POTENCIAHPANT,POTENCIAHPDIF,POTENCIAHPFAC,POTENCIAHPCONS,POTUSOREDDISTCONFAC,POTUSOREDDISTPREUNI,POTGENFPCONFAC,POTGENFPPREUNI,POTUSOREDDISTTOTAL,POTGENFPTOTAL,FECVENCIMIENTO,FECEMISION) values ('3',null,null,null,'1,5','201510',null,'0','0','0','705','0','0','0','231,15','11104,85','-0,2','0,36','83,63','1050,19','1024,65','25,54','1000','25540','25540','0,1767','4512,92','193,74','189,26','4,48','1000','4480','4480','0,209','936,32','1045,06','1023,96','21,1','1000','21100','12094','0,0416','503,11','3,518','3,439','0,079','1000','79','3,348','3,278','0,07','1000','70','84','10,86','79','0','912,24','2020,03','11/11/2015','10/27/2015');
REM INSERTING into ACMMH.SIS_RECIBOLUZ_SOCIO
SET DEFINE OFF;
REM INSERTING into ACMMH.SIS_ROL
SET DEFINE OFF;
Insert into ACMMH.SIS_ROL (CODIGO_ROL,NOMBRE_ROL,ESTADO) values ('1','CAJERO','1');
REM INSERTING into ACMMH.SIS_ROL_X_UNIDAD
SET DEFINE OFF;
Insert into ACMMH.SIS_ROL_X_UNIDAD (CODIGO_ROL_X_UNIDAD,CODIGO_UNIDAD,CODIGO_ROL) values ('1','1','1');
REM INSERTING into ACMMH.SIS_UNIDAD
SET DEFINE OFF;
Insert into ACMMH.SIS_UNIDAD (CODIGO_UNIDAD,NOMBRE_UNIDAD,ESTADO) values ('1','TESORERIA','1');
REM INSERTING into ACMMH.SIS_USUARIO
SET DEFINE OFF;
Insert into ACMMH.SIS_USUARIO (CODIGO_USUARIO,USUARIO,CLAVE,DNI,APELLIDO_PATERNO,APELLIDO_MATERNO,NOMBRES,FECHA_NACIMIENTO,CORREO,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION,TELEFONO,CODIGO_ROL_X_UNIDAD) values ('1','JAMBROCIO','xwfdLpX9xWGyYWnHQK2CRQ==','42596272','AMBROCIO','SERNAQUE','JORGE CHRISTIAN',to_date('30/08/84','DD/MM/RR'),'JAMBROCIO@PENSION65.GOB.PE','1','JAMBROCIO',to_date('20/10/15','DD/MM/RR'),'JAMBROCIO',null,'951294596','1');
Insert into ACMMH.SIS_USUARIO (CODIGO_USUARIO,USUARIO,CLAVE,DNI,APELLIDO_PATERNO,APELLIDO_MATERNO,NOMBRES,FECHA_NACIMIENTO,CORREO,ESTADO,USUARIO_CREACION,FECHA_CREACION,USUARIO_MODIFICACION,FECHA_MODIFICACION,TELEFONO,CODIGO_ROL_X_UNIDAD) values ('2','JMUNOZ','1sNqrIyO5b0=','42596277','MUNOZ','CAVERO','JOHAN ARTEMIO',to_date('20/10/15','DD/MM/RR'),'JMUNOZC@PENSION65.GOB.PE','1','JAMBROCIO',to_date('20/10/15','DD/MM/RR'),'JAMBROCIO',null,'324345345','1');
REM INSERTING into ACMMH.MGV_ALL_CAPTURED_SQL
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_CATALOG_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_CATALOGS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_COLUMN_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_COLUMNDT_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_CONNECTIONS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_CONSTRAINTS_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_INDEX_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_PROGRAMS_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_SCHEMA
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_SCHEMA_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_STORED_PROGRAMS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_TABLES
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_TABLES_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_TABLE_TRIGGERS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_TRIGGER_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_VIEW_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_VIEWS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_ALL_VIEW_TRIGGERS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_DERIVATIVES
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_DERIVED_DETAILS
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_IDENTIFIER_DELIMITER
SET DEFINE OFF;
REM INSERTING into ACMMH.MGV_SCRATCH_DERIVATIVES
SET DEFINE OFF;
REM INSERTING into ACMMH.VIEW_BUCAR_SOCIO
SET DEFINE OFF;
REM INSERTING into ACMMH.VIEW_BUSCAR_ITEM
SET DEFINE OFF;
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1','140','S','N ','1','AUTOVALUO 2006 - 2011',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('173','1','S','N ','1','CONSUMO DE LUZ DEL MES DE DICIEMBRE DEL 2011','0','I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1311','1','S','C ','1','SERVICIOS HIGIENICOS 1',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1312','1','S','C ','1','SERVICIOS HIGIENICOS 2',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1313','1','S','C ','1','SERVICIOS HIGIENICOS 3',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1314','1','S','C ','1','SERVICIOS HIGIENICOS 4',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1315','1','S','C ','1','SERVICIOS HIGIENICOS 5',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1316','1','S','C ','1','SERVICIOS HIGIENICOS 6',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1330','1','S','N ','1','MULTA POR AUTOVALUO 2006 - 2011',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1331','1','S','N ','1','VIGILANCIA',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1332','20','S','C ','1','DEVOLUCION DE PRESTAMO',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1333','10','S','N ','1','REGISTROS PUBLICOS JUNIO 2011',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1334','1,5','S','N ','1','CUOTA ADMINISTRATIVO (MENSUAL)',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1335','5','S','N ','1','CUOTA ANIVERSARIO 2011',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1336','8','S','N ','1','CUOTA POR SOFWARE 2011',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1337','8','S','N ','1','CUOTA EXTEMPORANEA DE SOFWARE 2011',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1338','1','S','C ','1','SISA Y PARQUEO - TICKET AMARILLO',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1339','0,5','S','C ','1','SISA Y PARQUEO - TICKET ANARANJADO',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1340','3','S','C ','1','SISA Y PARQUEO - TICKET VERDE',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1341','5','S','C ','1','SISA Y PARQUEO  - TICKET CELESTE',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1342','20','S','N ','1','MULTAS POR INASISTENCIA A SAMBLEA',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1343','15','S','N ','1','CONSTANCIA DE ASOCICIADO',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1344','1','S','N ','1','SOLICITUDES VARIAS',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1345','1','S','C ','1','PERMISOS VARIOS PARA TRABAJOS EN AREAS DEL MERCADO',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1346','60','S','N ','1','INSCRIPCION PARA EL SERVICIO DE LUZ',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1347','20','S','N ','1','INSTALACION INTERNA SERVICIO ELECTRICO',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1348','1','S','N ','1','CUENTAS DE DEUDAS ANTERIORES A JUNIO 2011',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1349','1','S','N ','1','CARTA PODER ',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('1350','1','S','N ','1','PERMISO ESPECIAL',null,'I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('2391','1','S','N ','1','CONSUMO DE LUZ MES DE ENERO DEL 2012','341','I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('2634','1','S','N ','1','CONSUMO DE LUZ DE MAYO DEL 2012','2791','I',null,'S',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('2393','1','S','N ','1','CONSUMO DE LUZ DEL MES DE MARZO 2012','1423','I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('2394','1','S','N ','1','CONSUMO DE LUZ DEL MES DE FEBRERO 2012','822','I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('2395','1','S','N ','1','CONSUMO DE LUZ DEL MES DE ABRIL 2012','2304','I',null,null,null,null);
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('3934','1','S','N ','1','CONSUMO DE LUZ DEL MES DE JUNIO 2012','3401','I',null,'S',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('3957','25','S','N ','1','MULTA DE JORNADA Y LIMPIEZA','0','I',null,'N',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('4241','1','S','N ','1','SERVICIOS VARIOS','0','I',null,'S',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('4414','1','S','N ','1','LUZ DE MAYO 2011','0','I',null,'S',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('5093','5','S','N ','1','CUOTA GASTOS NOTARIAS - ELLECIONES 2012','0','I',null,'N',null,'G');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('5113','1','S','N ','1','CONSUMO DE LUZ DEL MES DE JULIO DEL 2012','4661','I',null,'S',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('5380','1','S','N ','1','DEPOSITO','0','I',null,'S',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('6024','1','S','N ','1','TANQUE ELEVADO','0','I',to_date('29/08/12','DD/MM/RR'),'S',null,'G');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('6640','1','S','N ','1','CONSUMO DE LUZ DEL MES DE AGOSTO 2012','6049','I',null,'S',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('6089','1','S','N ','1','ALQUILER PTO LIBRE','0','I',null,'S',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('7560','1','S','N ','1','CONSUMO LUZ SETIEMBRE 2012','7609','I',null,'S',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('8193','100','S','N ','1','MULTA MARCHA 19/06/12','0','I',null,'N',null,'I');
Insert into ACMMH.VIEW_BUSCAR_ITEM (COD_ITEMCOBRANZA,NUM_COSTO,STR_MONEDA,STR_TIPOCOBRANZA,NUM_ESTADO,STR_DESCRIPCION,COD_RECIBOLUZ,STR_TIPO,DAT_FECHAFIN,STR_FLGVARIABLE,NUM_COBROADICIONAL,STR_FLGCOBROSOCIO) values ('2396','10','S','N ','1','CUOTA MEMORIAL 2012',null,'I',null,null,null,'G');
REM INSERTING into ACMMH.VIEW_BUSCAR_RECIBO_SOCIO
SET DEFINE OFF;
REM INSERTING into ACMMH.VIEW1
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index SIS_CONCEPTOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_CONCEPTOS_PK" ON "ACMMH"."SIS_CONCEPTO" ("CODIGO_CONCEPTO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_FACTURACION_CAB_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_FACTURACION_CAB_PK" ON "ACMMH"."SIS_FACTURACION_CAB" ("CODIGO_FACTURACION_CAB") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_FACTURACION_DET_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_FACTURACION_DET_PK" ON "ACMMH"."SIS_FACTURACION_DET" ("CODIGO_FACTURACION_DET") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_GIRO_COMERCIAL_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_GIRO_COMERCIAL_PK" ON "ACMMH"."SIS_GIRO_COMERCIAL" ("CODIGO_GIRO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_MENU_NIVELES_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_MENU_NIVELES_PK" ON "ACMMH"."SIS_MENU_NIVELES" ("CODIGO_NIVELES") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_MENU_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_MENU_PK" ON "ACMMH"."SIS_MENU" ("CODIGO_MENU") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_MENU_USUARIO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_MENU_USUARIO_PK" ON "ACMMH"."SIS_MENU_USUARIO" ("CODIGO_MENU_USUARIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_PUESTO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_PUESTO_PK" ON "ACMMH"."SIS_PUESTO" ("CODIGO_PUESTO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_RECIBO_LUZ_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_RECIBO_LUZ_PK" ON "ACMMH"."SIS_RECIBOLUZ_ORG" ("COD_ORGRECIBO_LUZ") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index SIS_RECIBOLUZ_SOCIO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_RECIBOLUZ_SOCIO_PK" ON "ACMMH"."SIS_RECIBOLUZ_SOCIO" ("CORRELATIVO", "CODIGOSOCIO", "CODIGORECIBO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_ROL_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_ROL_PK" ON "ACMMH"."SIS_ROL" ("CODIGO_ROL") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_ROL_X_UNIDAD_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_ROL_X_UNIDAD_PK" ON "ACMMH"."SIS_ROL_X_UNIDAD" ("CODIGO_ROL_X_UNIDAD") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_UNIDAD_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_UNIDAD_PK" ON "ACMMH"."SIS_UNIDAD" ("CODIGO_UNIDAD") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index SIS_USUARIO_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."SIS_USUARIO_PK" ON "ACMMH"."SIS_USUARIO" ("CODIGO_USUARIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index XPKACTIVIDAD_SOCIO
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."XPKACTIVIDAD_SOCIO" ON "ACMMH"."SISGAP_ACTIVIDAD_SOCIO" ("ACTI_TRAN_IDE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index XPKFACTURA
--------------------------------------------------------

  CREATE UNIQUE INDEX "ACMMH"."XPKFACTURA" ON "ACMMH"."SISGAP_FACTURA" ("COD_FACTURA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  Constraints for Table SIS_CONCEPTO
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_CONCEPTO" MODIFY ("CODIGO_CONCEPTO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_CONCEPTO" MODIFY ("NOMBRE_CONCEPTO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_CONCEPTO" ADD CONSTRAINT "SIS_CONCEPTOS_PK" PRIMARY KEY ("CODIGO_CONCEPTO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table SIS_FACTURACION_CAB
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_FACTURACION_CAB" MODIFY ("CODIGO_FACTURACION_CAB" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_FACTURACION_CAB" MODIFY ("CODIGO_USUARIO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_FACTURACION_CAB" MODIFY ("SERIE" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_FACTURACION_CAB" MODIFY ("SECUENCIA" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_FACTURACION_CAB" MODIFY ("ESTADO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_FACTURACION_CAB" ADD CONSTRAINT "SIS_FACTURACION_CAB_PK" PRIMARY KEY ("CODIGO_FACTURACION_CAB")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "ACMMH"."SIS_FACTURACION_CAB" MODIFY ("USUARIO_CREACION" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_FACTURACION_CAB" MODIFY ("FECHA_CREACION" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SIS_FACTURACION_DET
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_FACTURACION_DET" MODIFY ("CODIGO_FACTURACION_DET" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_FACTURACION_DET" ADD CONSTRAINT "SIS_FACTURACION_DET_PK" PRIMARY KEY ("CODIGO_FACTURACION_DET")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "ACMMH"."SIS_FACTURACION_DET" MODIFY ("CODIGO_PUESTO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_FACTURACION_DET" MODIFY ("CODIGO_CONCEPTO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_FACTURACION_DET" MODIFY ("MONTO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_FACTURACION_DET" MODIFY ("CODIGO_FACTURACION_CAB" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SIS_GIRO_COMERCIAL
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_GIRO_COMERCIAL" MODIFY ("CODIGO_GIRO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_GIRO_COMERCIAL" MODIFY ("NOMBRE_GIRO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_GIRO_COMERCIAL" MODIFY ("SECTOR" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_GIRO_COMERCIAL" MODIFY ("ESTADO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_GIRO_COMERCIAL" ADD CONSTRAINT "SIS_GIRO_COMERCIAL_PK" PRIMARY KEY ("CODIGO_GIRO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table SIS_MENU
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_MENU" MODIFY ("CODIGO_MENU" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU" MODIFY ("DESCRIPCION" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU" MODIFY ("ORDEN" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU" MODIFY ("ESTADO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU" ADD CONSTRAINT "SIS_MENU_PK" PRIMARY KEY ("CODIGO_MENU")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table SIS_MENU_NIVELES
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_MENU_NIVELES" MODIFY ("CODIGO_NIVELES" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU_NIVELES" MODIFY ("DESCRIPCION" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU_NIVELES" MODIFY ("LINK" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU_NIVELES" MODIFY ("ORDEN" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU_NIVELES" MODIFY ("NIVEL" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU_NIVELES" MODIFY ("ESTADO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU_NIVELES" ADD CONSTRAINT "SIS_MENU_NIVELES_PK" PRIMARY KEY ("CODIGO_NIVELES")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table SIS_MENU_USUARIO
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_MENU_USUARIO" MODIFY ("CODIGO_MENU_USUARIO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU_USUARIO" ADD CONSTRAINT "SIS_MENU_USUARIO_PK" PRIMARY KEY ("CODIGO_MENU_USUARIO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "ACMMH"."SIS_MENU_USUARIO" MODIFY ("CODIGO_NIVELES" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_MENU_USUARIO" MODIFY ("CODIGO_USUARIO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SIS_PUESTO
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_PUESTO" MODIFY ("CODIGO_PUESTO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_PUESTO" MODIFY ("CODIGO_USUARIO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_PUESTO" MODIFY ("NRO_PUESTO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_PUESTO" ADD CONSTRAINT "SIS_PUESTO_PK" PRIMARY KEY ("CODIGO_PUESTO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "ACMMH"."SIS_PUESTO" MODIFY ("CODIGO_GIRO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_PUESTO" MODIFY ("USUARIO_REGISTRO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_PUESTO" MODIFY ("FECHA_REGISTRO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SIS_RECIBOLUZ_ORG
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_RECIBOLUZ_ORG" ADD CONSTRAINT "SIS_RECIBO_LUZ_PK" PRIMARY KEY ("COD_ORGRECIBO_LUZ")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "ACMMH"."SIS_RECIBOLUZ_ORG" MODIFY ("COD_ORGRECIBO_LUZ" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SIS_RECIBOLUZ_SOCIO
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_RECIBOLUZ_SOCIO" ADD CONSTRAINT "SIS_RECIBOLUZ_SOCIO_PK" PRIMARY KEY ("CORRELATIVO", "CODIGOSOCIO", "CODIGORECIBO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "ACMMH"."SIS_RECIBOLUZ_SOCIO" MODIFY ("CORRELATIVO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_RECIBOLUZ_SOCIO" MODIFY ("CODIGORECIBO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_RECIBOLUZ_SOCIO" MODIFY ("CODIGOSOCIO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SIS_ROL
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_ROL" MODIFY ("CODIGO_ROL" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_ROL" MODIFY ("NOMBRE_ROL" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_ROL" MODIFY ("ESTADO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_ROL" ADD CONSTRAINT "SIS_ROL_PK" PRIMARY KEY ("CODIGO_ROL")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table SIS_ROL_X_UNIDAD
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_ROL_X_UNIDAD" MODIFY ("CODIGO_ROL_X_UNIDAD" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_ROL_X_UNIDAD" MODIFY ("CODIGO_UNIDAD" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_ROL_X_UNIDAD" MODIFY ("CODIGO_ROL" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_ROL_X_UNIDAD" ADD CONSTRAINT "SIS_ROL_X_UNIDAD_PK" PRIMARY KEY ("CODIGO_ROL_X_UNIDAD")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table SIS_UNIDAD
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_UNIDAD" MODIFY ("CODIGO_UNIDAD" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_UNIDAD" ADD CONSTRAINT "SIS_UNIDAD_PK" PRIMARY KEY ("CODIGO_UNIDAD")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table SIS_USUARIO
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("CODIGO_USUARIO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("USUARIO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("CLAVE" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("DNI" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("APELLIDO_PATERNO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("NOMBRES" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("FECHA_NACIMIENTO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("ESTADO" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("USUARIO_CREACION" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("FECHA_CREACION" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" MODIFY ("CODIGO_ROL_X_UNIDAD" NOT NULL ENABLE);
  ALTER TABLE "ACMMH"."SIS_USUARIO" ADD CONSTRAINT "SIS_USUARIO_PK" PRIMARY KEY ("CODIGO_USUARIO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SIS_FACTURACION_DET
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_FACTURACION_DET" ADD CONSTRAINT "SIS_FACTURACION_DET_FK1" FOREIGN KEY ("CODIGO_PUESTO")
	  REFERENCES "ACMMH"."SIS_PUESTO" ("CODIGO_PUESTO") ENABLE;
  ALTER TABLE "ACMMH"."SIS_FACTURACION_DET" ADD CONSTRAINT "SIS_FACTURACION_DET_FK2" FOREIGN KEY ("CODIGO_CONCEPTO")
	  REFERENCES "ACMMH"."SIS_CONCEPTO" ("CODIGO_CONCEPTO") ENABLE;
  ALTER TABLE "ACMMH"."SIS_FACTURACION_DET" ADD CONSTRAINT "SIS_FACTURACION_DET_FK3" FOREIGN KEY ("CODIGO_FACTURACION_CAB")
	  REFERENCES "ACMMH"."SIS_FACTURACION_CAB" ("CODIGO_FACTURACION_CAB") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SIS_MENU_NIVELES
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_MENU_NIVELES" ADD CONSTRAINT "SIS_MENU_NIVELES_FK1" FOREIGN KEY ("CODIGO_MENU")
	  REFERENCES "ACMMH"."SIS_MENU" ("CODIGO_MENU") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SIS_MENU_USUARIO
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_MENU_USUARIO" ADD CONSTRAINT "SIS_MENU_USUARIO_FK1" FOREIGN KEY ("CODIGO_MENU_USUARIO")
	  REFERENCES "ACMMH"."SIS_MENU_USUARIO" ("CODIGO_MENU_USUARIO") ENABLE;
  ALTER TABLE "ACMMH"."SIS_MENU_USUARIO" ADD CONSTRAINT "SIS_MENU_USUARIO_FK2" FOREIGN KEY ("CODIGO_NIVELES")
	  REFERENCES "ACMMH"."SIS_MENU_NIVELES" ("CODIGO_NIVELES") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SIS_PUESTO
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_PUESTO" ADD CONSTRAINT "SIS_PUESTO_FK1" FOREIGN KEY ("CODIGO_USUARIO")
	  REFERENCES "ACMMH"."SIS_USUARIO" ("CODIGO_USUARIO") ENABLE;
  ALTER TABLE "ACMMH"."SIS_PUESTO" ADD CONSTRAINT "SIS_PUESTO_FK2" FOREIGN KEY ("CODIGO_GIRO")
	  REFERENCES "ACMMH"."SIS_GIRO_COMERCIAL" ("CODIGO_GIRO") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SIS_ROL_X_UNIDAD
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_ROL_X_UNIDAD" ADD CONSTRAINT "SIS_ROL_X_UNIDAD_FK1" FOREIGN KEY ("CODIGO_UNIDAD")
	  REFERENCES "ACMMH"."SIS_UNIDAD" ("CODIGO_UNIDAD") ENABLE;
  ALTER TABLE "ACMMH"."SIS_ROL_X_UNIDAD" ADD CONSTRAINT "SIS_ROL_X_UNIDAD_FK2" FOREIGN KEY ("CODIGO_ROL")
	  REFERENCES "ACMMH"."SIS_ROL" ("CODIGO_ROL") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SIS_USUARIO
--------------------------------------------------------

  ALTER TABLE "ACMMH"."SIS_USUARIO" ADD CONSTRAINT "SIS_USUARIO_FK1" FOREIGN KEY ("CODIGO_ROL_X_UNIDAD")
	  REFERENCES "ACMMH"."SIS_ROL_X_UNIDAD" ("CODIGO_ROL_X_UNIDAD") ENABLE;
--------------------------------------------------------
--  DDL for Package PKG_AUTENTICACION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "ACMMH"."PKG_AUTENTICACION" AS 

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_AUTENTICACION_USUARIO(vi_usuario     IN  VARCHAR2,
                             vi_clave               IN  VARCHAR2,
                             vi_ip_address          IN  VARCHAR2,
                             vo_codigo_usuario      OUT  NUMBER,
                             vo_codigo_rol          OUT  NUMBER,
                             vo_codigo_institucion  OUT  NUMBER,
                             vo_descripcion_rol     OUT  VARCHAR2,
                             vo_nombres_full        OUT  VARCHAR2,
                             vo_nombre_institucion  OUT  VARCHAR2,
                             vo_codigo_ut           OUT  NUMBER,
                             vo_nombre_ut           OUT  VARCHAR2,
                             vo_codigo              OUT  VARCHAR2,
                             vo_mensaje             OUT  VARCHAR2);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_LISTA_OPCIONES_MENU(vi_codigo_usuario  IN  NUMBER,
                                   vo_result          OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --                                 
  
END PKG_AUTENTICACION;

/
--------------------------------------------------------
--  DDL for Package PKG_FACTURACION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "ACMMH"."PKG_FACTURACION" AS 
  
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
                                          vi_codigo_puesto            IN NUMBER,
                                          vi_codigo_concepto          IN NUMBER,
                                          vi_monto                    IN NUMBER,
                                          vo_facturacion_detalle      OUT NUMBER,
                                          vo_indicador                OUT VARCHAR,
                                          vo_mensaje                  OUT VARCHAR);                             
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  
END PKG_FACTURACION;

/
--------------------------------------------------------
--  DDL for Package PKG_PUESTO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "ACMMH"."PKG_PUESTO" AS 
  
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_LISTAR_GIRO_COMERCIAL(vo_result     OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_GRABAR_PUESTO(vi_codigo_puesto            IN NUMBER,
                             vi_codigo_usuario           IN NUMBER,
                             vi_codigo_giro              IN NUMBER,
                             vi_nro_puesto               IN VARCHAR,
                             vi_codigo_usuario_registro  IN NUMBER,
                             vo_codigo_puesto            OUT NUMBER,
                             vo_indicador                OUT VARCHAR,
                             vo_mensaje                  OUT VARCHAR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_PUESTO(vi_pagina                 IN  NUMBER,
                              vi_registros              IN  NUMBER,
                              vi_dni                    IN  VARCHAR,
                              vo_total_registros        OUT NUMBER,
                              vo_result                 OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_PUESTO_X_PTO(vi_pagina           IN  NUMBER,
                              vi_registros              IN  NUMBER,
                              vi_codigo_puesto          IN  VARCHAR2,
                              vo_total_registros        OUT NUMBER,
                              vo_result                 OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_ELIMINAR_PUESTO(vi_codigo_puesto             IN NUMBER,
                               vi_codigo_usuario            IN NUMBER,
                               vo_indicador                 OUT VARCHAR,
                               vo_mensaje                   OUT VARCHAR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_LISTAR_CONCEPTO(vo_result     OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  
END PKG_PUESTO;

/
--------------------------------------------------------
--  DDL for Package PKG_RECIBO_LUZ_ORIG
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "ACMMH"."PKG_RECIBO_LUZ_ORIG" AS
TYPE CUR_LIST IS REF CURSOR;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
PROCEDURE SP_INS_RECIBOORILUZ(  
    p_FEC_PERIODO          IN SIS_RECIBOLUZ_ORG.FEC_PERIODO%type DEFAULT NULL ,
    p_FECVENCIMIENTO       IN SIS_RECIBOLUZ_ORG.FECVENCIMIENTO%type DEFAULT NULL,
    p_FECEMISION           IN SIS_RECIBOLUZ_ORG.FECEMISION%type DEFAULT NULL,
    p_NUM_COSTO_WATS       IN SIS_RECIBOLUZ_ORG.NUM_COSTO_WATS%type DEFAULT NULL ,
    p_NUM_ESTADO           IN SIS_RECIBOLUZ_ORG.NUM_ESTADO%type DEFAULT NULL ,
    p_REPOMANCNX           IN SIS_RECIBOLUZ_ORG.REPOMANCNX%type DEFAULT NULL ,
    p_CARGOFIJO            IN SIS_RECIBOLUZ_ORG.CARGOFIJO%type DEFAULT NULL ,
    p_ENERGACTFRAPTAACTUAL IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTAACTUAL%type DEFAULT NULL ,
    p_ENERGACTFRAPTAANTERI IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTAANTERI%type DEFAULT NULL ,
    p_ENERGACTFRAPTADIFER  IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTADIFER%type DEFAULT NULL ,
    p_ENERGACTFRAPTAFACTOR IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTAFACTOR%type DEFAULT NULL ,	
    p_ENERGACTFRAPTACONSU  IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTACONSU%type DEFAULT NULL ,
    p_ENERGACTFRAPTACONFA  IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTACONFA%type DEFAULT NULL ,
    p_ENERGACTFRAPTAPREUNI IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTAPREUNI%type DEFAULT NULL ,
    p_ENERGACTFRAPTATOTAL  IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTATOTAL%type DEFAULT NULL ,
    p_ENERGACTHORPTAACTU   IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTAACTU%type DEFAULT NULL ,
    p_ENERGACTHORPTAANT    IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTAANT%type DEFAULT NULL ,	
    p_ENERGACTHORPTADIF    IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTADIF%type DEFAULT NULL ,
    p_ENERGACTHORPTAFAC    IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTAFAC%type DEFAULT NULL ,	
    p_ENERGACTHORPTACONS   IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTACONS%type DEFAULT NULL ,
    p_ENERGACTHORPTACONFAC IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTACONFAC%type DEFAULT NULL ,
    p_ENERGACTHORPTAPREUNI IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTAPREUNI%type DEFAULT NULL ,
    p_ENERGACTHORPTATOTAL  IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTATOTAL%type DEFAULT NULL ,
    p_ENERGREACINICIAL     IN SIS_RECIBOLUZ_ORG.ENERGREACINICIAL%type DEFAULT NULL ,
    p_ENERGREACANTERI      IN SIS_RECIBOLUZ_ORG.ENERGREACANTERI%type DEFAULT NULL ,
    p_ENERGREACDIFERE      IN SIS_RECIBOLUZ_ORG.ENERGREACDIFERE%type DEFAULT NULL ,
    p_ENERGREACFACTOR      IN SIS_RECIBOLUZ_ORG.ENERGREACFACTOR%type DEFAULT NULL ,	
    p_ENERGREACCONSU       IN SIS_RECIBOLUZ_ORG.ENERGREACCONSU%type DEFAULT NULL ,
    p_ENERGREACFACCONS     IN SIS_RECIBOLUZ_ORG.ENERGREACFACCONS%type DEFAULT NULL ,
    p_ENERGREACPREUNI      IN SIS_RECIBOLUZ_ORG.ENERGREACPREUNI%type DEFAULT NULL ,
    p_ENERGREACTOTAL       IN SIS_RECIBOLUZ_ORG.ENERGREACTOTAL%type DEFAULT NULL ,    
    p_INTERESCONVENIO      IN SIS_RECIBOLUZ_ORG.INTERESCONVENIO%type DEFAULT NULL ,
    p_POTENCIAFPINI        IN SIS_RECIBOLUZ_ORG.POTENCIAFPINI%type DEFAULT NULL ,
    p_POTENCIAFPANTE       IN SIS_RECIBOLUZ_ORG.POTENCIAFPANTE%type DEFAULT NULL ,
    p_POTENCIAFPDIF        IN SIS_RECIBOLUZ_ORG.POTENCIAFPDIF%type DEFAULT NULL ,
    p_POTENCIAFPFAC        IN SIS_RECIBOLUZ_ORG.POTENCIAFPFAC%type DEFAULT NULL ,
    p_POTENCIAFPCONS       IN SIS_RECIBOLUZ_ORG.POTENCIAFPCONS%type DEFAULT NULL ,
    p_POTENCIAHPACT        IN SIS_RECIBOLUZ_ORG.POTENCIAHPACT%type DEFAULT NULL ,
    p_POTENCIAHPANT        IN SIS_RECIBOLUZ_ORG.POTENCIAHPANT%type DEFAULT NULL ,
    p_POTENCIAHPDIF        IN SIS_RECIBOLUZ_ORG.POTENCIAHPDIF%type DEFAULT NULL ,
    p_POTENCIAHPFAC        IN SIS_RECIBOLUZ_ORG.POTENCIAHPFAC%type DEFAULT NULL ,
    p_POTENCIAHPCONS       IN SIS_RECIBOLUZ_ORG.POTENCIAHPCONS%type DEFAULT NULL ,
    p_POTUSOREDDISTCONFAC  IN SIS_RECIBOLUZ_ORG.POTUSOREDDISTCONFAC%type DEFAULT NULL,
    p_POTUSOREDDISTPREUNI  IN SIS_RECIBOLUZ_ORG.POTUSOREDDISTPREUNI%type DEFAULT NULL ,
    p_POTUSOREDDISTTOTAL   IN SIS_RECIBOLUZ_ORG.POTUSOREDDISTTOTAL%type DEFAULT NULL,
    p_POTGENFPCONFAC       IN SIS_RECIBOLUZ_ORG.POTGENFPCONFAC%type DEFAULT NULL ,
    p_POTGENFPPREUNI       IN SIS_RECIBOLUZ_ORG.POTGENFPPREUNI%type DEFAULT NULL ,
    p_POTGENFPTOTAL        IN SIS_RECIBOLUZ_ORG.POTGENFPTOTAL%type DEFAULT NULL,
    p_ALUMPUBLIC           IN SIS_RECIBOLUZ_ORG.ALUMPUBLIC%type DEFAULT NULL ,
    p_SUBTOTALMES          IN SIS_RECIBOLUZ_ORG.SUBTOTALMES%type DEFAULT NULL ,    
    p_IGV                  IN SIS_RECIBOLUZ_ORG.IGV%type DEFAULT NULL ,
    p_TOTALMESACT          IN SIS_RECIBOLUZ_ORG.TOTALMESACT%type DEFAULT NULL ,
    p_APORTELEY            IN SIS_RECIBOLUZ_ORG.APORTELEY%type DEFAULT NULL ,
    p_CUOTACONV            IN SIS_RECIBOLUZ_ORG.CUOTACONV%type DEFAULT NULL ,
    p_REDONMESANT          IN SIS_RECIBOLUZ_ORG.REDONMESANT%type DEFAULT NULL ,
    p_REDONMESACT          IN SIS_RECIBOLUZ_ORG.REDONMESACT%type DEFAULT NULL ,
    /*p_NUM_MONTO            IN SIS_RECIBOLUZ_ORG.NUM_MONTO%type DEFAULT NULL ,
    p_NUM_LECTURA_INICIAL  IN SIS_RECIBOLUZ_ORG.NUM_LECTURA_INICIAL%type DEFAULT NULL ,    
    p_NUM_LECTURA_FINAL    IN SIS_RECIBOLUZ_ORG.NUM_LECTURA_FINAL%type ,
    p_NUM_PENDIENTE_FAC    IN SIS_RECIBOLUZ_ORG.NUM_PENDIENTE_FAC%type DEFAULT NULL,*/
    vo_codigo_recibo       OUT NUMBER,
    vo_indicador           OUT VARCHAR,
    vo_mensaje             OUT VARCHAR);
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_LUZ_ORIG(vi_pagina                 IN  NUMBER,
                              vi_registros              IN  NUMBER,
                              vi_codigo_recibo_luz_orig IN  VARCHAR,
                              vo_total_registros        OUT NUMBER,
                              vo_result                 OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
END PKG_RECIBO_LUZ_ORIG;

/
--------------------------------------------------------
--  DDL for Package PKG_RECIBO_LUZ_SOCIO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "ACMMH"."PKG_RECIBO_LUZ_SOCIO" AS
TYPE CUR_LIST IS REF CURSOR;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
 PROCEDURE SP_GRABAR_LUZ_X_SOCIO(vi_codigo_socio         IN NUMBER,
                             vi_codigo_recibo            IN NUMBER,
                             vi_correlativo              IN NUMBER,
                             vi_lectura_inicial          IN NUMBER,
                             vi_lectura_final            IN VARCHAR,
                             vi_consumo_mes              IN NUMBER,
                             vi_cargo_fijo               IN NUMBER,
                             vi_cargo_energia            IN NUMBER,
                             vi_alumbrado_publico        IN NUMBER,
                             vi_servicio_mantenimiento   IN NUMBER,
                             vi_deuda_anterior           IN NUMBER,
                             vi_reconexion               IN NUMBER,
                             vi_subtotal_mes             IN NUMBER,
                             vi_igv                      IN NUMBER,
                             vi_total_mes                IN NUMBER,
                             vi_redondeo                 IN NUMBER,
                             vi_total                    IN NUMBER,
                             vi_estado                   IN NUMBER,
                             vi_fecha_carga              IN DATE,
                             vi_usuario_crea             IN VARCHAR2,
                             vi_usuario_modifica         IN VARCHAR2,
                             vo_codigo_socio            OUT NUMBER,
                             vo_indicador                OUT VARCHAR,
                             vo_mensaje                  OUT VARCHAR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_PUESTO_LUZ_SOCIO(vi_pagina       IN  NUMBER,
                              vi_registros              IN  NUMBER,
                              vi_codigo_puesto          IN  NUMBER,
                              vo_total_registros        OUT NUMBER,
                              vo_result                 OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
END PKG_RECIBO_LUZ_SOCIO;

/
--------------------------------------------------------
--  DDL for Package PKG_USUARIOS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "ACMMH"."PKG_USUARIOS" AS 

  PROCEDURE SP_LISTA_ROL(vi_codigo_institucion            IN NUMBER,
                         vi_codigo_unidad                 IN NUMBER,
                         vo_result                        OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_LISTA_UNIDAD(vi_codigo_institucion             IN NUMBER,
                            vo_result                         OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_GRABAR_USUARIO(vi_codigo_usuario         IN NUMBER,
                              vi_userid                 IN VARCHAR,
                              vi_ape_paterno            IN VARCHAR,
                              vi_ape_materno            IN VARCHAR,
                              vi_nombres                IN VARCHAR,
                              vi_fecha_nacimiento       IN VARCHAR,
                              vi_correo                 IN VARCHAR,
                              vi_telefono               IN VARCHAR,
                              vi_codigo_rol             IN NUMBER,
                              vi_codigo_unidad          IN NUMBER,
                              vi_codigo_institucion     IN NUMBER,
                              vi_estado                 IN VARCHAR,
                              vi_usuario_registro       IN VARCHAR,
                              vi_clave                  IN VARCHAR,
                              vi_dni                    IN VARCHAR,
                              vo_codigo_usuario         OUT NUMBER,
                              vo_indicador              OUT VARCHAR,
                              vo_mensaje                OUT VARCHAR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_CANTIDAD_USUARIOS(vi_codigo_institucion      IN  NUMBER,
                                 vo_cantidad                OUT  NUMBER);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_USUARIOS(vi_codigo_institucion     IN  NUMBER,
                                vi_pagina                 IN  NUMBER,
                                vi_registros              IN  NUMBER,
                                vi_codigo_unidad          IN  NUMBER,
                                vo_result                 OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --                                
  PROCEDURE SP_BUSCAR_USUARIO(vi_dni        IN  NUMBER,
                              vo_result     OUT SYS_REFCURSOR);
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --                                
  
END PKG_USUARIOS;

/
--------------------------------------------------------
--  DDL for Package Body PKG_AUTENTICACION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "ACMMH"."PKG_AUTENTICACION" AS

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_AUTENTICACION_USUARIO(vi_usuario     IN  VARCHAR2,
                             vi_clave               IN  VARCHAR2,
                             vi_ip_address          IN  VARCHAR2,
                             vo_codigo_usuario      OUT  NUMBER,
                             vo_codigo_rol          OUT  NUMBER,
                             vo_codigo_institucion  OUT  NUMBER,
                             vo_descripcion_rol     OUT  VARCHAR2,
                             vo_nombres_full        OUT  VARCHAR2,
                             vo_nombre_institucion  OUT  VARCHAR2,
                             vo_codigo_ut           OUT  NUMBER,
                             vo_nombre_ut           OUT  VARCHAR2,
                             vo_codigo              OUT  VARCHAR2,
                             vo_mensaje             OUT  VARCHAR2) AS
  BEGIN
    
    SELECT u.codigo_usuario, ru.codigo_rol, r.nombre_rol, u.apellido_paterno || ' ' || u.apellido_materno || ', ' || u.nombres AS nombres_full, ru.codigo_unidad, ut.nombre_unidad, 1, 'ACMMH'
    INTO vo_codigo_usuario, vo_codigo_rol, vo_descripcion_rol, vo_nombres_full, vo_codigo_ut, vo_nombre_ut, vo_codigo_institucion, vo_nombre_institucion
    FROM sis_usuario u
    LEFT JOIN sis_rol_x_unidad ru ON u.codigo_rol_x_unidad = ru.codigo_rol_x_unidad
    LEFT JOIN sis_rol r ON ru.codigo_rol=r.codigo_rol
    LEFT JOIN sis_unidad ut ON ru.codigo_unidad=ut.codigo_unidad
    WHERE u.estado=1
    AND ut.estado=1
    AND u.usuario=vi_usuario
    AND u.clave=vi_clave;

    vo_codigo := '00';
    vo_mensaje := 'OK';
    
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
      
        vo_codigo := '01';
        vo_mensaje := 'USUARIO O CLAVE INCORRECTA';
        vo_codigo_rol := 0;
        vo_codigo_usuario := 0;
        vo_codigo_institucion := 0;
        vo_descripcion_rol := ' ';
        vo_nombres_full := ' ';
        vo_nombre_institucion := ' ';
        vo_codigo_ut := 0;
        vo_nombre_ut := ' ';
        
  END SP_AUTENTICACION_USUARIO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_LISTA_OPCIONES_MENU(vi_codigo_usuario  IN  NUMBER,
                                   vo_result          OUT SYS_REFCURSOR) AS
  BEGIN
      
      OPEN vo_result FOR
          SELECT m.codigo_menu, mn.codigo_niveles, m.descripcion AS desc_menu, m.orden AS orden_menu, mn.descripcion AS desc_sub_menu, mn.link, mn.orden AS orden_sub_menu, mn.nivel
          FROM sis_usuario u
          LEFT JOIN sis_menu_usuario mu ON u.codigo_usuario=mu.codigo_usuario
          LEFT JOIN sis_menu_niveles mn ON mu.codigo_niveles=mn.codigo_niveles
          LEFT JOIN sis_menu m ON mn.codigo_menu=m.codigo_menu
          WHERE u.estado = 1
          AND m.estado = 1
          AND mn.estado = 1
          AND u.codigo_usuario = vi_codigo_usuario
          ORDER BY m.orden, mn.orden;
          
  END SP_LISTA_OPCIONES_MENU;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  
END PKG_AUTENTICACION;

/
--------------------------------------------------------
--  DDL for Package Body PKG_FACTURACION
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "ACMMH"."PKG_FACTURACION" AS

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

  PROCEDURE SP_GRABAR_FACTURACION_DETALLE(vi_facturacion_cabecera     IN NUMBER,
                                          vi_codigo_puesto            IN NUMBER,
                                          vi_codigo_concepto          IN NUMBER,
                                          vi_monto                    IN NUMBER,
                                          vo_facturacion_detalle      OUT NUMBER,
                                          vo_indicador                OUT VARCHAR,
                                          vo_mensaje                  OUT VARCHAR) AS
  vl_codigo                 NUMBER;                                          
  BEGIN
      
      SELECT SEQ_SIS_FACTURACION_DET.NEXTVAL INTO vl_codigo FROM DUAL;
      INSERT INTO sis_facturacion_det (codigo_facturacion_det, codigo_puesto, codigo_concepto, monto, codigo_facturacion_cab)
      VALUES (vl_codigo, vi_codigo_puesto, vi_codigo_concepto, vi_monto, vi_facturacion_cabecera);
      
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

END PKG_FACTURACION;

/
--------------------------------------------------------
--  DDL for Package Body PKG_PUESTO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "ACMMH"."PKG_PUESTO" AS
  
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_LISTAR_GIRO_COMERCIAL(vo_result     OUT SYS_REFCURSOR) AS
  BEGIN
      
      OPEN vo_result FOR
          SELECT codigo_giro, nombre_giro FROM sis_giro_comercial
          WHERE estado = 1
          ORDER BY nombre_giro;
          
  END SP_LISTAR_GIRO_COMERCIAL;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_GRABAR_PUESTO(vi_codigo_puesto            IN NUMBER,
                             vi_codigo_usuario           IN NUMBER,
                             vi_codigo_giro              IN NUMBER,
                             vi_nro_puesto               IN VARCHAR,
                             vi_codigo_usuario_registro  IN NUMBER,
                             vo_codigo_puesto            OUT NUMBER,
                             vo_indicador                OUT VARCHAR,
                             vo_mensaje                  OUT VARCHAR) AS
  
  vl_codigo                 NUMBER;                              
  BEGIN
    
    IF vi_codigo_puesto = 0 THEN
        
        SELECT SEQ_SIS_CODIGO_PUESTO.NEXTVAL INTO vl_codigo FROM DUAL;
        INSERT INTO sis_puesto (codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, usuario_registro, fecha_registro, estado)
        VALUES (vl_codigo, vi_codigo_usuario, vi_nro_puesto, vi_codigo_giro, vi_codigo_usuario_registro, SYSDATE, 1);
        
        vo_codigo_puesto := vl_codigo;
        vo_indicador := '00';
        vo_mensaje := 'Se registro satisfactoriamente el puesto.';
    ELSE
    
        UPDATE sis_puesto
        SET
        nro_puesto = vi_nro_puesto, 
        codigo_giro = vi_codigo_giro,
        usuario_modificacion = vi_codigo_usuario_registro, 
        fecha_modificacion = SYSDATE
        WHERE codigo_usuario = vi_codigo_usuario
        AND codigo_puesto = vi_codigo_puesto;
        
        vo_codigo_puesto := vi_codigo_puesto;
        vo_indicador := '00';
        vo_mensaje := 'Se modifico satisfactoriamente el puesto.';
        
    END IF;
  
  EXCEPTION 
    WHEN OTHERS THEN
      vo_codigo_puesto := 0;
      vo_indicador := '01';
      vo_mensaje := SQLCODE || ' - ' || SQLERRM;
      ROLLBACK;  
    
  END SP_GRABAR_PUESTO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_PUESTO(vi_pagina                 IN  NUMBER,
                              vi_registros              IN  NUMBER,
                              vi_dni                    IN  VARCHAR,
                              vo_total_registros        OUT NUMBER,
                              vo_result                 OUT SYS_REFCURSOR) AS
  vl_inicio NUMBER;
  vl_fin    NUMBER;                              
  BEGIN
    
    vl_fin := vi_pagina * vi_registros;
    vl_inicio := vl_fin - (vi_registros - 1);
    
    dbms_output.put_line ('INICIO : ' || vl_inicio); 
    dbms_output.put_line ('FIN : ' || vl_fin); 
    
    IF vi_dni = '0' THEN
    
        SELECT COUNT(*) INTO vo_total_registros
        FROM sis_puesto p
        LEFT JOIN sis_usuario u ON p.codigo_usuario = u.codigo_usuario
        LEFT JOIN sis_giro_comercial g ON p.codigo_giro = g.codigo_giro;
        
        OPEN vo_result FOR
            SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, dni, nombre_full, nombre_giro
            FROM (
                SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, dni, nombre_full, nombre_giro, ROWNUM numfila
                FROM (
                
                      SELECT p.codigo_puesto, p.codigo_usuario, p.nro_puesto, p.codigo_giro, u.dni, u.apellido_paterno || ' ' || u.apellido_materno || ', ' || u.nombres AS nombre_full, g.nombre_giro
                      FROM sis_puesto p
                      LEFT JOIN sis_usuario u ON p.codigo_usuario = u.codigo_usuario
                      LEFT JOIN sis_giro_comercial g ON p.codigo_giro = g.codigo_giro
    
                ) A
            ) B
            WHERE numfila BETWEEN vl_inicio AND vl_fin;
            
    ELSE
    
        SELECT COUNT(*) INTO vo_total_registros
        FROM sis_puesto p
        LEFT JOIN sis_usuario u ON p.codigo_usuario = u.codigo_usuario
        LEFT JOIN sis_giro_comercial g ON p.codigo_giro = g.codigo_giro
        WHERE u.dni = vi_dni;
        
        OPEN vo_result FOR
            SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, dni, nombre_full, nombre_giro
            FROM (
                SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, dni, nombre_full, nombre_giro, ROWNUM numfila
                FROM (
                
                      SELECT p.codigo_puesto, p.codigo_usuario, p.nro_puesto, p.codigo_giro, u.dni, u.apellido_paterno || ' ' || u.apellido_materno || ', ' || u.nombres AS nombre_full, g.nombre_giro
                      FROM sis_puesto p
                      LEFT JOIN sis_usuario u ON p.codigo_usuario = u.codigo_usuario
                      LEFT JOIN sis_giro_comercial g ON p.codigo_giro = g.codigo_giro
                      WHERE u.dni = vi_dni
                      
                ) A
            ) B
            WHERE numfila BETWEEN vl_inicio AND vl_fin;
        
    END IF;
  END SP_REPORTE_PUESTO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_PUESTO_X_PTO(vi_pagina         IN  NUMBER,
                              vi_registros              IN  NUMBER,
                              vi_codigo_puesto          IN  VARCHAR2,
                              vo_total_registros        OUT NUMBER,
                              vo_result                 OUT SYS_REFCURSOR) AS
  vl_inicio NUMBER;
  vl_fin    NUMBER;                              
  BEGIN
    
    vl_fin := vi_pagina * vi_registros;
    vl_inicio := vl_fin - (vi_registros - 1);
    
    dbms_output.put_line ('INICIO : ' || vl_inicio); 
    dbms_output.put_line ('FIN : ' || vl_fin); 
    
    IF vi_codigo_puesto = '0' THEN
    
        SELECT COUNT(*) INTO vo_total_registros
        FROM sis_puesto p
        LEFT JOIN sis_usuario u ON p.codigo_usuario = u.codigo_usuario
        LEFT JOIN sis_giro_comercial g ON p.codigo_giro = g.codigo_giro;
        
        OPEN vo_result FOR
            SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, dni, nombre_full, nombre_giro
            FROM (
                SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, dni, nombre_full, nombre_giro, ROWNUM numfila
                FROM (
                
                      SELECT p.codigo_puesto, p.codigo_usuario, p.nro_puesto, p.codigo_giro, u.dni, u.apellido_paterno || ' ' || u.apellido_materno || ', ' || u.nombres AS nombre_full, g.nombre_giro
                      FROM sis_puesto p
                      LEFT JOIN sis_usuario u ON p.codigo_usuario = u.codigo_usuario
                      LEFT JOIN sis_giro_comercial g ON p.codigo_giro = g.codigo_giro                      
    
                ) A
            ) B
            WHERE numfila BETWEEN vl_inicio AND vl_fin;
            
    ELSE
    
        SELECT COUNT(*) INTO vo_total_registros
        FROM sis_puesto p
        LEFT JOIN sis_usuario u ON p.codigo_usuario = u.codigo_usuario
        LEFT JOIN sis_giro_comercial g ON p.codigo_giro = g.codigo_giro
        WHERE trim(p.codigo_puesto) = trim(vi_codigo_puesto);
        
        OPEN vo_result FOR
            SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, dni, nombre_full, nombre_giro
            FROM (
                SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, dni, nombre_full, nombre_giro, ROWNUM numfila
                FROM (
                
                      SELECT p.codigo_puesto, p.codigo_usuario, p.nro_puesto, p.codigo_giro, u.dni, u.apellido_paterno || ' ' || u.apellido_materno || ', ' || u.nombres AS nombre_full, g.nombre_giro
                      FROM sis_puesto p
                      LEFT JOIN sis_usuario u ON p.codigo_usuario = u.codigo_usuario
                      LEFT JOIN sis_giro_comercial g ON p.codigo_giro = g.codigo_giro
                      WHERE trim(p.codigo_puesto) = trim(vi_codigo_puesto)
                      
                ) A
            ) B
            WHERE numfila BETWEEN vl_inicio AND vl_fin;
        
    END IF;
  END SP_REPORTE_PUESTO_X_PTO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_ELIMINAR_PUESTO(vi_codigo_puesto            IN NUMBER,
                               vi_codigo_usuario           IN NUMBER,
                               vo_indicador                OUT VARCHAR,
                               vo_mensaje                  OUT VARCHAR) AS
  BEGIN
    
    UPDATE sis_puesto
    SET
    estado = 0, 
    usuario_modificacion = vi_codigo_usuario, 
    fecha_modificacion = SYSDATE
    WHERE codigo_puesto = vi_codigo_puesto;
        
    vo_indicador := '00';
    vo_mensaje := 'Se elimino el puesto.';
  
  EXCEPTION 
    WHEN OTHERS THEN
      vo_indicador := '01';
      vo_mensaje := SQLCODE || ' - ' || SQLERRM;
      ROLLBACK;  
      
  END SP_ELIMINAR_PUESTO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_LISTAR_CONCEPTO(vo_result     OUT SYS_REFCURSOR) AS
  BEGIN
      
      OPEN vo_result FOR
          SELECT codigo_concepto, nombre_concepto FROM sis_concepto
          WHERE estado = 1
          ORDER BY nombre_concepto;
          
  END SP_LISTAR_CONCEPTO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
END PKG_PUESTO;

/
--------------------------------------------------------
--  DDL for Package Body PKG_RECIBO_LUZ_ORIG
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "ACMMH"."PKG_RECIBO_LUZ_ORIG" 
AS

PROCEDURE SP_INS_RECIBOORILUZ(  
    p_FEC_PERIODO          IN SIS_RECIBOLUZ_ORG.FEC_PERIODO%type DEFAULT NULL ,
    p_FECVENCIMIENTO       IN SIS_RECIBOLUZ_ORG.FECVENCIMIENTO%type DEFAULT NULL,
    p_FECEMISION           IN SIS_RECIBOLUZ_ORG.FECEMISION%type DEFAULT NULL,
    p_NUM_COSTO_WATS       IN SIS_RECIBOLUZ_ORG.NUM_COSTO_WATS%type DEFAULT NULL ,
    p_NUM_ESTADO           IN SIS_RECIBOLUZ_ORG.NUM_ESTADO%type DEFAULT NULL ,
    p_REPOMANCNX           IN SIS_RECIBOLUZ_ORG.REPOMANCNX%type DEFAULT NULL ,
    p_CARGOFIJO            IN SIS_RECIBOLUZ_ORG.CARGOFIJO%type DEFAULT NULL ,
    p_ENERGACTFRAPTAACTUAL IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTAACTUAL%type DEFAULT NULL ,
    p_ENERGACTFRAPTAANTERI IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTAANTERI%type DEFAULT NULL ,
    p_ENERGACTFRAPTADIFER  IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTADIFER%type DEFAULT NULL ,
    p_ENERGACTFRAPTAFACTOR IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTAFACTOR%type DEFAULT NULL ,	
    p_ENERGACTFRAPTACONSU  IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTACONSU%type DEFAULT NULL ,
    p_ENERGACTFRAPTACONFA  IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTACONFA%type DEFAULT NULL ,
    p_ENERGACTFRAPTAPREUNI IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTAPREUNI%type DEFAULT NULL ,
    p_ENERGACTFRAPTATOTAL  IN SIS_RECIBOLUZ_ORG.ENERGACTFRAPTATOTAL%type DEFAULT NULL ,
    p_ENERGACTHORPTAACTU   IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTAACTU%type DEFAULT NULL ,
    p_ENERGACTHORPTAANT    IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTAANT%type DEFAULT NULL ,	
    p_ENERGACTHORPTADIF    IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTADIF%type DEFAULT NULL ,
    p_ENERGACTHORPTAFAC    IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTAFAC%type DEFAULT NULL ,	
    p_ENERGACTHORPTACONS   IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTACONS%type DEFAULT NULL ,
    p_ENERGACTHORPTACONFAC IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTACONFAC%type DEFAULT NULL ,
    p_ENERGACTHORPTAPREUNI IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTAPREUNI%type DEFAULT NULL ,
    p_ENERGACTHORPTATOTAL  IN SIS_RECIBOLUZ_ORG.ENERGACTHORPTATOTAL%type DEFAULT NULL ,
    p_ENERGREACINICIAL     IN SIS_RECIBOLUZ_ORG.ENERGREACINICIAL%type DEFAULT NULL ,
    p_ENERGREACANTERI      IN SIS_RECIBOLUZ_ORG.ENERGREACANTERI%type DEFAULT NULL ,
    p_ENERGREACDIFERE      IN SIS_RECIBOLUZ_ORG.ENERGREACDIFERE%type DEFAULT NULL ,
    p_ENERGREACFACTOR      IN SIS_RECIBOLUZ_ORG.ENERGREACFACTOR%type DEFAULT NULL ,	
    p_ENERGREACCONSU       IN SIS_RECIBOLUZ_ORG.ENERGREACCONSU%type DEFAULT NULL ,
    p_ENERGREACFACCONS     IN SIS_RECIBOLUZ_ORG.ENERGREACFACCONS%type DEFAULT NULL ,
    p_ENERGREACPREUNI      IN SIS_RECIBOLUZ_ORG.ENERGREACPREUNI%type DEFAULT NULL ,
    p_ENERGREACTOTAL       IN SIS_RECIBOLUZ_ORG.ENERGREACTOTAL%type DEFAULT NULL ,    
    p_INTERESCONVENIO      IN SIS_RECIBOLUZ_ORG.INTERESCONVENIO%type DEFAULT NULL ,
    p_POTENCIAFPINI        IN SIS_RECIBOLUZ_ORG.POTENCIAFPINI%type DEFAULT NULL ,
    p_POTENCIAFPANTE       IN SIS_RECIBOLUZ_ORG.POTENCIAFPANTE%type DEFAULT NULL ,
    p_POTENCIAFPDIF        IN SIS_RECIBOLUZ_ORG.POTENCIAFPDIF%type DEFAULT NULL ,
    p_POTENCIAFPFAC        IN SIS_RECIBOLUZ_ORG.POTENCIAFPFAC%type DEFAULT NULL ,
    p_POTENCIAFPCONS       IN SIS_RECIBOLUZ_ORG.POTENCIAFPCONS%type DEFAULT NULL ,
    p_POTENCIAHPACT        IN SIS_RECIBOLUZ_ORG.POTENCIAHPACT%type DEFAULT NULL ,
    p_POTENCIAHPANT        IN SIS_RECIBOLUZ_ORG.POTENCIAHPANT%type DEFAULT NULL ,
    p_POTENCIAHPDIF        IN SIS_RECIBOLUZ_ORG.POTENCIAHPDIF%type DEFAULT NULL ,
    p_POTENCIAHPFAC        IN SIS_RECIBOLUZ_ORG.POTENCIAHPFAC%type DEFAULT NULL ,
    p_POTENCIAHPCONS       IN SIS_RECIBOLUZ_ORG.POTENCIAHPCONS%type DEFAULT NULL ,
    p_POTUSOREDDISTCONFAC  IN SIS_RECIBOLUZ_ORG.POTUSOREDDISTCONFAC%type DEFAULT NULL,
    p_POTUSOREDDISTPREUNI  IN SIS_RECIBOLUZ_ORG.POTUSOREDDISTPREUNI%type DEFAULT NULL ,
    p_POTUSOREDDISTTOTAL   IN SIS_RECIBOLUZ_ORG.POTUSOREDDISTTOTAL%type DEFAULT NULL,
    p_POTGENFPCONFAC       IN SIS_RECIBOLUZ_ORG.POTGENFPCONFAC%type DEFAULT NULL ,
    p_POTGENFPPREUNI       IN SIS_RECIBOLUZ_ORG.POTGENFPPREUNI%type DEFAULT NULL ,
    p_POTGENFPTOTAL        IN SIS_RECIBOLUZ_ORG.POTGENFPTOTAL%type DEFAULT NULL,
    p_ALUMPUBLIC           IN SIS_RECIBOLUZ_ORG.ALUMPUBLIC%type DEFAULT NULL ,
    p_SUBTOTALMES          IN SIS_RECIBOLUZ_ORG.SUBTOTALMES%type DEFAULT NULL ,    
    p_IGV                  IN SIS_RECIBOLUZ_ORG.IGV%type DEFAULT NULL ,
    p_TOTALMESACT          IN SIS_RECIBOLUZ_ORG.TOTALMESACT%type DEFAULT NULL ,
    p_APORTELEY            IN SIS_RECIBOLUZ_ORG.APORTELEY%type DEFAULT NULL ,
    p_CUOTACONV            IN SIS_RECIBOLUZ_ORG.CUOTACONV%type DEFAULT NULL ,
    p_REDONMESANT          IN SIS_RECIBOLUZ_ORG.REDONMESANT%type DEFAULT NULL ,
    p_REDONMESACT          IN SIS_RECIBOLUZ_ORG.REDONMESACT%type DEFAULT NULL ,
    /*p_NUM_MONTO            IN SIS_RECIBOLUZ_ORG.NUM_MONTO%type DEFAULT NULL ,
    p_NUM_LECTURA_INICIAL  IN SIS_RECIBOLUZ_ORG.NUM_LECTURA_INICIAL%type DEFAULT NULL ,    
    p_NUM_LECTURA_FINAL    IN SIS_RECIBOLUZ_ORG.NUM_LECTURA_FINAL%type ,
    p_NUM_PENDIENTE_FAC    IN SIS_RECIBOLUZ_ORG.NUM_PENDIENTE_FAC%type DEFAULT NULL,*/
    vo_codigo_recibo       OUT NUMBER,
    vo_indicador           OUT VARCHAR,
    vo_mensaje             OUT VARCHAR)
IS
vl_codigo                 NUMBER;
vl_periodo                VARCHAR2(10);
BEGIN

select CONCAT( SUBSTR(p_FEC_PERIODO,instr(p_FEC_PERIODO,' ')+1,4) , CASE WHEN UPPER(substr(p_FEC_PERIODO,1,instr(p_FEC_PERIODO,' ')-1))='OCTOBER' THEN 10 END ) PERIODO INTO vl_periodo from dual;
--select CONCAT( SUBSTR(p_FEC_PERIODO,instr(p_FEC_PERIODO,' ')+1,4) , CASE WHEN substr(p_FEC_PERIODO,1,instr(p_FEC_PERIODO,' ')-1)='OCTUBRE' THEN 10 END ) PERIODO INTO vl_periodo from dual;


  SELECT SQ_RECIBO_LUZ_ORIGINAL.NEXTVAL INTO vl_codigo FROM DUAL;
  INSERT
  INTO SIS_RECIBOLUZ_ORG
    (
      ENERGREACFACCONS ,
      ENERGACTHORPTAFAC ,
      POTENCIAFPDIF ,
      ENERGACTFRAPTAFACTOR ,
      TOTALMESACT ,
      REPOMANCNX ,
      ENERGREACANTERI ,
      ENERGREACTOTAL ,
      SUBTOTALMES ,
      COD_ORGRECIBO_LUZ ,
      ENERGACTFRAPTAACTUAL ,
      ENERGREACPREUNI ,
      POTENCIAHPACT ,
      POTENCIAFPCONS ,
      ENERGACTFRAPTADIFER ,
      ENERGACTHORPTAACTU ,
      FEC_PERIODO ,
      --NUM_LECTURA_INICIAL ,
      POTENCIAFPFAC ,
      POTENCIAFPINI ,
      ENERGACTHORPTADIF ,
      --NUM_MONTO ,
      NUM_ESTADO ,
      CUOTACONV ,
      ENERGACTHORPTAPREUNI ,
      ENERGACTHORPTACONFAC ,
      POTENCIAHPDIF ,
      CARGOFIJO ,
      POTENCIAFPANTE ,
      POTGENFPPREUNI ,
      APORTELEY ,
      ENERGACTFRAPTATOTAL ,
      NUM_COSTO_WATS ,
      POTENCIAHPCONS ,
      POTGENFPCONFAC ,
      ENERGREACFACTOR ,
      ENERGACTHORPTATOTAL ,
      ENERGACTHORPTAANT ,
      ENERGACTFRAPTAANTERI ,
      INTERESCONVENIO ,
      REDONMESACT ,
      POTENCIAHPFAC ,
      ENERGACTFRAPTACONFA ,
      ENERGREACCONSU ,
      --NUM_LECTURA_FINAL ,
      POTENCIAHPANT ,
      ENERGREACINICIAL ,
      ALUMPUBLIC ,
      IGV ,
      ENERGACTFRAPTAPREUNI ,
      ENERGACTFRAPTACONSU ,
      REDONMESANT ,
      ENERGACTHORPTACONS ,
      POTUSOREDDISTPREUNI ,
      ENERGREACDIFERE ,
      --NUM_PENDIENTE_FAC ,
      POTUSOREDDISTCONFAC,
      POTUSOREDDISTTOTAL,
      POTGENFPTOTAL,
      FECVENCIMIENTO,
      FECEMISION
    )
    VALUES
    (
      p_ENERGREACFACCONS ,
      p_ENERGACTHORPTAFAC ,
      p_POTENCIAFPDIF ,
      p_ENERGACTFRAPTAFACTOR ,
      p_TOTALMESACT ,
      p_REPOMANCNX ,
      p_ENERGREACANTERI ,
      p_ENERGREACTOTAL ,
      p_SUBTOTALMES ,
      vl_codigo,
      p_ENERGACTFRAPTAACTUAL ,
      p_ENERGREACPREUNI ,
      p_POTENCIAHPACT ,
      p_POTENCIAFPCONS ,
      p_ENERGACTFRAPTADIFER ,
      p_ENERGACTHORPTAACTU ,
      vl_periodo,
      --p_FEC_PERIODO ,
      --p_NUM_LECTURA_INICIAL ,
      p_POTENCIAFPFAC ,
      p_POTENCIAFPINI ,
      p_ENERGACTHORPTADIF ,
      --p_NUM_MONTO ,
      p_NUM_ESTADO ,
      p_CUOTACONV ,
      p_ENERGACTHORPTAPREUNI ,
      p_ENERGACTHORPTACONFAC ,
      p_POTENCIAHPDIF ,
      p_CARGOFIJO ,
      p_POTENCIAFPANTE ,
      p_POTGENFPPREUNI ,
      p_APORTELEY ,
      p_ENERGACTFRAPTATOTAL ,
      p_NUM_COSTO_WATS ,
      p_POTENCIAHPCONS ,
      p_POTGENFPCONFAC ,
      p_ENERGREACFACTOR ,
      p_ENERGACTHORPTATOTAL ,
      p_ENERGACTHORPTAANT ,
      p_ENERGACTFRAPTAANTERI ,
      p_INTERESCONVENIO ,
      p_REDONMESACT ,
      p_POTENCIAHPFAC ,
      p_ENERGACTFRAPTACONFA ,
      p_ENERGREACCONSU ,
      --p_NUM_LECTURA_FINAL ,
      p_POTENCIAHPANT ,
      p_ENERGREACINICIAL ,
      p_ALUMPUBLIC ,
      p_IGV ,
      p_ENERGACTFRAPTAPREUNI ,
      p_ENERGACTFRAPTACONSU ,
      p_REDONMESANT ,
      p_ENERGACTHORPTACONS ,
      p_POTUSOREDDISTPREUNI ,
      p_ENERGREACDIFERE ,
      --p_NUM_PENDIENTE_FAC ,
      p_POTUSOREDDISTCONFAC,
      p_POTUSOREDDISTTOTAL,
      p_POTGENFPTOTAL,
      p_FECVENCIMIENTO,
      p_FECEMISION
    );
COMMIT;

      vo_codigo_recibo := vl_codigo;
      vo_indicador := '00';
      vo_mensaje := 'Se registro satisfactoriamente el Recibo de Luz Original.';

EXCEPTION 
  WHEN OTHERS THEN
    vo_codigo_recibo := 0;
    vo_indicador := '01';
    vo_mensaje := SQLCODE || ' - ' || SQLERRM;
    ROLLBACK;

END;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_LUZ_ORIG(vi_pagina               IN  NUMBER,
                              vi_registros              IN  NUMBER,
                              vi_codigo_recibo_luz_orig IN  VARCHAR,
                              vo_total_registros        OUT NUMBER,
                              vo_result                 OUT SYS_REFCURSOR) AS
  vl_inicio NUMBER;
  vl_fin    NUMBER;                              
  BEGIN
    
    vl_fin := vi_pagina * vi_registros;
    vl_inicio := vl_fin - (vi_registros - 1);
    
    dbms_output.put_line ('INICIO : ' || vl_inicio); 
    dbms_output.put_line ('FIN : ' || vl_fin); 
    
    IF vi_codigo_recibo_luz_orig = '0' THEN
    
        SELECT COUNT(*) INTO vo_total_registros
        FROM sis_reciboluz_org p;
        
        OPEN vo_result FOR
            SELECT cod_orgrecibo_luz codigoReciboLuzOriginal, fec_periodo periodo, fecemision fecEmision, fecvencimiento fecVencimiento, totalmesact totalMesAct
            FROM (
                SELECT cod_orgrecibo_luz, fec_periodo, fecemision, fecvencimiento, totalmesact, ROWNUM numfila
                FROM (
                      SELECT cod_orgrecibo_luz, fec_periodo, fecemision, fecvencimiento, totalmesact
                      FROM sis_reciboluz_org p
                ) A
            ) B
            WHERE numfila BETWEEN vl_inicio AND vl_fin;
            
    ELSE
    
        SELECT COUNT(*) INTO vo_total_registros
        FROM sis_reciboluz_org p
        WHERE p.cod_orgrecibo_luz = vi_codigo_recibo_luz_orig;
        
        OPEN vo_result FOR
            SELECT cod_orgrecibo_luz codigoReciboLuzOriginal, fec_periodo periodo, fecemision fecEmision, fecvencimiento fecVencimiento, totalmesact totalMesAct
            FROM (
                SELECT cod_orgrecibo_luz, fec_periodo, fecemision, fecvencimiento, totalmesact, ROWNUM numfila
                FROM (
                      SELECT cod_orgrecibo_luz, fec_periodo, fecemision, fecvencimiento, totalmesact
                      FROM sis_reciboluz_org p
                      WHERE p.cod_orgrecibo_luz = vi_codigo_recibo_luz_orig
                ) A
            ) B
            WHERE numfila BETWEEN vl_inicio AND vl_fin;
        
    END IF;
  END SP_REPORTE_LUZ_ORIG;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

END PKG_RECIBO_LUZ_ORIG;

/
--------------------------------------------------------
--  DDL for Package Body PKG_RECIBO_LUZ_SOCIO
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "ACMMH"."PKG_RECIBO_LUZ_SOCIO" 
AS

  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_GRABAR_LUZ_X_SOCIO(vi_codigo_socio         IN NUMBER,
                             vi_codigo_recibo            IN NUMBER,
                             vi_correlativo              IN NUMBER,
                             vi_lectura_inicial          IN NUMBER,
                             vi_lectura_final            IN VARCHAR,
                             vi_consumo_mes              IN NUMBER,
                             vi_cargo_fijo               IN NUMBER,
                             vi_cargo_energia            IN NUMBER,
                             vi_alumbrado_publico        IN NUMBER,
                             vi_servicio_mantenimiento   IN NUMBER,
                             vi_deuda_anterior           IN NUMBER,
                             vi_reconexion               IN NUMBER,
                             vi_subtotal_mes             IN NUMBER,
                             vi_igv                      IN NUMBER,
                             vi_total_mes                IN NUMBER,
                             vi_redondeo                 IN NUMBER,
                             vi_total                    IN NUMBER,
                             vi_estado                   IN NUMBER,
                             vi_fecha_carga              IN DATE,
                             vi_usuario_crea             IN VARCHAR2,
                             vi_usuario_modifica         IN VARCHAR2,
                             vo_codigo_socio             OUT NUMBER,
                             vo_indicador                OUT VARCHAR,
                             vo_mensaje                  OUT VARCHAR) AS
  
  vl_codigo                 NUMBER;                              
  BEGIN
    
    IF vi_correlativo = 0 THEN
        
        SELECT SQ_RECIBO_LUZ_SOCIO.NEXTVAL INTO vl_codigo FROM DUAL;
        INSERT INTO sis_reciboluz_socio (codigosocio, codigorecibo, correlativo, lecturainicial, lecturafinal, consumomes, cargofijo, cargoenergia, alumbradopublico, serviciomantenimiento, deudaanterior, reconexion, subtotalmes, igv, totalmes, redondeo, total, estado, fechacarga, impreso, usuario)
        VALUES (vi_codigo_socio, vi_codigo_recibo, vl_codigo, vi_lectura_inicial, vi_lectura_final, vi_consumo_mes, vi_cargo_fijo, vi_cargo_energia, vi_alumbrado_publico, vi_servicio_mantenimiento, vi_deuda_anterior, vi_reconexion, vi_subtotal_mes, vi_igv, vi_total_mes, vi_redondeo, vi_total, 1, SYSDATE, 0, vi_usuario_crea);
        
        vo_codigo_socio := vl_codigo;
        vo_indicador := '00';
        vo_mensaje := 'Se registro satisfactoriamente el recibo de luz x socio.';
   
    ELSE
    
        UPDATE sis_reciboluz_socio
        SET
        lecturainicial = vi_lectura_inicial,
        usuariomodificacion = vi_usuario_modifica, 
        fechamodificacion = SYSDATE
        WHERE correlativo = vi_correlativo;
        
        vo_codigo_socio := vi_codigo_socio;
        vo_indicador := '00';
        vo_mensaje := 'Se modifico satisfactoriamente el recibo de luz x socio.';
        
    END IF;
  
  EXCEPTION 
    WHEN OTHERS THEN
      vo_codigo_socio := 0;
      vo_indicador := '01';
      vo_mensaje := SQLCODE || ' - ' || SQLERRM;
      ROLLBACK;  
    
  END SP_GRABAR_LUZ_X_SOCIO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_PUESTO_LUZ_SOCIO(vi_pagina       IN  NUMBER,
                              vi_registros              IN  NUMBER,
                              vi_codigo_puesto          IN  NUMBER,
                              vo_total_registros        OUT NUMBER,
                              vo_result                 OUT SYS_REFCURSOR) AS
  vl_inicio NUMBER;
  vl_fin    NUMBER;                              
  BEGIN
    
    vl_fin := vi_pagina * vi_registros;
    vl_inicio := vl_fin - (vi_registros - 1);
    
    dbms_output.put_line ('INICIO : ' || vl_inicio); 
    dbms_output.put_line ('FIN : ' || vl_fin); 
    
    IF vi_codigo_puesto = '0' THEN
    
        SELECT COUNT(*) INTO vo_total_registros
        FROM sis_puesto p;
        
        OPEN vo_result FOR
            SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, estado, recibo_luz, total, recibo_luz_creado
            FROM (
                SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, estado, recibo_luz, total, recibo_luz_creado, ROWNUM numfila
                FROM (
                      SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, estado, recibo_luz,
                            nvl((SELECT total FROM sis_reciboluz_socio 
                                WHERE codigosocio = nro_puesto and codigorecibo in (SELECT cod_orgrecibo_luz FROM sis_reciboluz_org) ),0) total,
                            nvl((SELECT 1 FROM sis_reciboluz_socio 
                                WHERE codigosocio = nro_puesto and codigorecibo in (SELECT cod_orgrecibo_luz FROM sis_reciboluz_org) ),0) recibo_luz_creado
                      FROM sis_puesto p
                      WHERE recibo_luz = 1
                ) A
            ) B
            WHERE numfila BETWEEN vl_inicio AND vl_fin;
            
    ELSE
    
        SELECT COUNT(*) INTO vo_total_registros
        FROM sis_puesto p
        WHERE p.codigo_puesto = vi_codigo_puesto;
        
        OPEN vo_result FOR
            SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, estado, recibo_luz, total, recibo_luz_creado
            FROM (
                SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, estado, recibo_luz, total, recibo_luz_creado, ROWNUM numfila
                FROM (
                      SELECT codigo_puesto, codigo_usuario, nro_puesto, codigo_giro, estado, recibo_luz,
                            nvl((SELECT total FROM sis_reciboluz_socio 
                                WHERE codigosocio = nro_puesto and codigorecibo in (SELECT cod_orgrecibo_luz FROM sis_reciboluz_org) ),0) total,
                            nvl((SELECT 1 FROM sis_reciboluz_socio 
                                WHERE codigosocio = nro_puesto and codigorecibo in (SELECT cod_orgrecibo_luz FROM sis_reciboluz_org) ),0) recibo_luz_creado
                      FROM sis_puesto p
                      WHERE p.codigo_puesto = vi_codigo_puesto and recibo_luz = 1
                ) A
            ) B
            WHERE numfila BETWEEN vl_inicio AND vl_fin;
        
    END IF;
  END SP_REPORTE_PUESTO_LUZ_SOCIO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

END PKG_RECIBO_LUZ_SOCIO;

/
--------------------------------------------------------
--  DDL for Package Body PKG_USUARIOS
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "ACMMH"."PKG_USUARIOS" AS

  PROCEDURE SP_LISTA_ROL(vi_codigo_institucion            IN NUMBER,
                         vi_codigo_unidad                 IN NUMBER,
                         vo_result                        OUT SYS_REFCURSOR) AS
  BEGIN
    
    OPEN vo_result FOR
        SELECT r.codigo_rol, r.nombre_rol from sis_rol_x_unidad ru
        LEFT JOIN sis_unidad ut ON ru.codigo_unidad=ut.codigo_unidad
        LEFT JOIN sis_rol r ON ru.codigo_rol=r.codigo_rol
        WHERE ut.estado=1
        AND r.estado=1
        AND ru.codigo_unidad=vi_codigo_unidad
        ORDER BY r.codigo_rol;

  END SP_LISTA_ROL;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_LISTA_UNIDAD(vi_codigo_institucion             IN NUMBER,
                            vo_result                         OUT SYS_REFCURSOR) AS
  BEGIN
    
    OPEN vo_result FOR
        SELECT codigo_unidad, nombre_unidad FROM sis_unidad
        WHERE estado = 1
        ORDER BY nombre_unidad;
        
  END SP_LISTA_UNIDAD;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_GRABAR_USUARIO(vi_codigo_usuario         IN NUMBER,
                              vi_userid                 IN VARCHAR,
                              vi_ape_paterno            IN VARCHAR,
                              vi_ape_materno            IN VARCHAR,
                              vi_nombres                IN VARCHAR,
                              vi_fecha_nacimiento       IN VARCHAR,
                              vi_correo                 IN VARCHAR,
                              vi_telefono               IN VARCHAR,
                              vi_codigo_rol             IN NUMBER,
                              vi_codigo_unidad          IN NUMBER,
                              vi_codigo_institucion     IN NUMBER,
                              vi_estado                 IN VARCHAR,
                              vi_usuario_registro       IN VARCHAR,
                              vi_clave                  IN VARCHAR,
                              vi_dni                    IN VARCHAR,
                              vo_codigo_usuario         OUT NUMBER,
                              vo_indicador              OUT VARCHAR,
                              vo_mensaje                OUT VARCHAR) AS
  vl_codigo                 NUMBER;
  vl_estado                 NUMBER;
  vl_codigo_menu_usuario    NUMBER;
  vl_codigo_rol_x_unidad    NUMBER;
  BEGIN
    
    IF vi_estado = 'ACTIVO' THEN
      vl_estado := 1;
    ELSE
      vl_estado := 0;
    END IF;
    
    SELECT ru.codigo_rol_x_unidad INTO vl_codigo_rol_x_unidad
    FROM sis_rol_x_unidad ru
    LEFT JOIN sis_unidad ut ON ru.codigo_unidad=ut.codigo_unidad
    WHERE ut.estado=1
    AND ru.codigo_unidad=vi_codigo_unidad
    AND ru.codigo_rol=vi_codigo_rol;
    
    IF vi_codigo_usuario = 0 THEN
        
        SELECT SEQ_SIS_CODIGO_USUARIO.NEXTVAL INTO vl_codigo FROM DUAL;
        INSERT INTO sis_usuario (codigo_usuario, usuario, clave, apellido_paterno, apellido_materno, nombres, fecha_nacimiento, correo, estado, usuario_creacion, fecha_creacion, codigo_rol_x_unidad, telefono, dni)
        VALUES (vl_codigo, vi_userid, vi_clave, vi_ape_paterno, vi_ape_materno, vi_nombres, vi_fecha_nacimiento, vi_correo, vl_estado, vi_usuario_registro, SYSDATE, vl_codigo_rol_x_unidad, vi_telefono, vi_dni);
        /*
        SELECT SEQ_SIS_MENU_USUARIO.NEXTVAL INTO vl_codigo_menu_usuario FROM DUAL;
        INSERT INTO sis_menu_usuario (codigo_menu_usuario, codigo_niveles, codigo_usuario)
        VALUES(vl_codigo_menu_usuario, 1, vl_codigo);
        */
        /* 
        UPDATE AY_VERSION
        SET versionoperadores = vl_operador + 1;
        */
        vo_codigo_usuario := vl_codigo;
        vo_indicador := '00';
        vo_mensaje := 'OK';
    ELSE
    
        UPDATE sis_usuario
        SET
        apellido_paterno = vi_ape_paterno, 
        apellido_materno = vi_ape_materno, 
        nombres = vi_nombres, 
        fecha_nacimiento = vi_fecha_nacimiento, 
        correo = vi_correo, 
        telefono = vi_telefono, 
        dni = vi_dni,
        estado = vl_estado, 
        usuario_modificacion = vi_usuario_registro, 
        fecha_creacion = SYSDATE,
        codigo_rol_x_unidad=vl_codigo_rol_x_unidad
        WHERE 
        codigo_usuario = vi_codigo_usuario;
        
        /*
        UPDATE AY_VERSION
        SET versionoperadores = vl_operador + 1;
        */
        vo_codigo_usuario := vi_codigo_usuario;
        vo_indicador := '00';
        vo_mensaje := 'OK';
    END IF;
  
  EXCEPTION 
    WHEN OTHERS THEN
      vo_codigo_usuario := 0;
      vo_indicador := '01';
      vo_mensaje := SQLCODE || ' - ' || SQLERRM;
      ROLLBACK;  
      
  END SP_GRABAR_USUARIO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_CANTIDAD_USUARIOS(vi_codigo_institucion      IN  NUMBER,
                                 vo_cantidad                OUT  NUMBER) AS
  BEGIN
    
    SELECT COUNT(*) INTO vo_cantidad
        FROM sis_usuario u
        LEFT JOIN sis_rol_x_unidad ru ON u.codigo_rol_x_unidad = ru.codigo_rol_x_unidad
        LEFT JOIN sis_unidad ut ON ru.codigo_unidad=ut.codigo_unidad;
        
  END SP_CANTIDAD_USUARIOS;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_REPORTE_USUARIOS(vi_codigo_institucion     IN  NUMBER,
                                vi_pagina                 IN  NUMBER,
                                vi_registros              IN  NUMBER,
                                vi_codigo_unidad          IN  NUMBER,
                                vo_result                 OUT SYS_REFCURSOR) AS
  vl_inicio NUMBER;
  vl_fin    NUMBER;                              
  BEGIN
    
    vl_fin := vi_pagina * vi_registros;
    vl_inicio := vl_fin - (vi_registros - 1);
    
    dbms_output.put_line ('INICIO : ' || vl_inicio); 
    dbms_output.put_line ('FIN : ' || vl_fin); 
    
    OPEN vo_result FOR
        SELECT codigo_usuario, usuario as userid, NVL(apellido_paterno, ' ') AS apellido_paterno, NVL(apellido_materno, ' ') AS apellido_materno, NVL(nombres, ' ') AS nombres, TO_CHAR(fecha_nacimiento, 'DD/MM/YYYY') AS fecha_nacimiento, 
        correo, codigo_rol, nombre_rol, codigo_unidad, nombre_unidad, 
        codigo_institucion, CASE WHEN estado = 1 THEN 'ACTIVO' ELSE 'INACTIVO' END AS estado, dni, telefono
        FROM (
            SELECT codigo_usuario, usuario, apellido_paterno, apellido_materno, nombres, fecha_nacimiento, correo, codigo_rol, nombre_rol, codigo_unidad, nombre_unidad,
            codigo_institucion, estado, dni, telefono, ROWNUM numfila
            FROM (
                  SELECT u.codigo_usuario, u.usuario, u.apellido_paterno, u.apellido_materno, u.nombres, u.fecha_nacimiento, u.correo, ru.codigo_rol, r.nombre_rol, ru.codigo_unidad, ut.nombre_unidad, 
                  1 AS codigo_institucion, u.estado, u.dni, u.telefono
                  FROM sis_usuario u
                  LEFT JOIN sis_rol_x_unidad ru ON u.codigo_rol_x_unidad=ru.codigo_rol_x_unidad
                  LEFT JOIN sis_rol r ON ru.codigo_rol=r.codigo_rol
                  LEFT JOIN sis_unidad ut ON ru.codigo_unidad=ut.codigo_unidad
                  WHERE ut.codigo_unidad = vi_codigo_unidad
                  ORDER BY u.usuario
            ) A
        ) B
        WHERE numfila BETWEEN vl_inicio AND vl_fin;

  END SP_REPORTE_USUARIOS;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  PROCEDURE SP_BUSCAR_USUARIO(vi_dni        IN  NUMBER,
                              vo_result     OUT SYS_REFCURSOR) AS
  BEGIN
      
      OPEN vo_result FOR
          SELECT u.codigo_usuario, u.usuario as userid, u.apellido_paterno, u.apellido_materno, u.nombres, u.fecha_nacimiento, u.correo, ru.codigo_rol, r.nombre_rol, ru.codigo_unidad, ut.nombre_unidad, 
          1 AS codigo_institucion, u.estado, u.dni, u.telefono
          FROM sis_usuario u
          LEFT JOIN sis_rol_x_unidad ru ON u.codigo_rol_x_unidad=ru.codigo_rol_x_unidad
          LEFT JOIN sis_rol r ON ru.codigo_rol=r.codigo_rol
          LEFT JOIN sis_unidad ut ON ru.codigo_unidad=ut.codigo_unidad
          WHERE u.dni = vi_dni
          ORDER BY u.usuario;
      
  END SP_BUSCAR_USUARIO;
  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  
END PKG_USUARIOS;

/
