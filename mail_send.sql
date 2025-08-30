
create database Mail;
select * from mailSend;


CREATE TABLE `mailSend` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cod_proceso` varchar(10) NOT NULL DEFAULT '' COMMENT 'Nombre del proceso en cuestion, ejemplo COBRO, CANCELACION',
  `email` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `asunto` varchar(200) NOT NULL DEFAULT '',
  `cuerpo` text DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '' COMMENT 'N=No eenviado/E=Enviado',
  `fecha_ing` date DEFAULT NULL,
  `hora_ing` time DEFAULT NULL,
  `fecha_envio` date DEFAULT NULL,
  `hora_envio` time DEFAULT NULL,
  `origen` varchar(20) NOT NULL DEFAULT '' COMMENT 'Ej: CALL / ATC / ADMINISTRACION ',
  `revisado` int(1) unsigned NOT NULL DEFAULT 0 COMMENT '[ 0 / 1 ] 0=NO Revisado / 1=SI Revisado',
  PRIMARY KEY (`id`),

);
