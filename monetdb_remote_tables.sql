-- Master schema

CREATE SCHEMA "threatmonitor";
SET SCHEMA "threatmonitor";

DROP TABLE wifi_ippacket;
CREATE REMOTE TABLE wifi_ippacket (
	"guid"      CHAR(36)      NOT NULL,
	"recv_date" CHARACTER LARGE OBJECT,
	"ip_df"     VARCHAR(5),
	"ip_dst"    VARCHAR(15),
	"ip_hlen"   INTEGER       NOT NULL,
	"ip_id"     INTEGER       NOT NULL,
	"ip_len"    INTEGER       NOT NULL,
	"ip_mf"     VARCHAR(5),
	"ip_off"    INTEGER       NOT NULL,
	"ip_proto"  INTEGER       NOT NULL,
	"ip_src"    VARCHAR(15),
	"ip_sum"    CHAR(10),
	"ip_tos"    INTEGER       NOT NULL,
	"ip_ttl"    INTEGER       NOT NULL,
	"ip_ver"    INTEGER       NOT NULL
--	CONSTRAINT "ippacket_1_guid_pkey" PRIMARY KEY ("guid")
) ON 'mapi:monetdb://172.17.0.3:50000/threatmonitor';

DROP TABLE wifi_ippacket2;
CREATE REMOTE TABLE wifi_ippacket2 (
	"guid"      CHAR(36)      NOT NULL,
	"recv_date" CHARACTER LARGE OBJECT,
	"ip_df"     VARCHAR(5),
	"ip_dst"    VARCHAR(15),
	"ip_hlen"   INTEGER       NOT NULL,
	"ip_id"     INTEGER       NOT NULL,
	"ip_len"    INTEGER       NOT NULL,
	"ip_mf"     VARCHAR(5),
	"ip_off"    INTEGER       NOT NULL,
	"ip_proto"  INTEGER       NOT NULL,
	"ip_src"    VARCHAR(15),
	"ip_sum"    CHAR(10),
	"ip_tos"    INTEGER       NOT NULL,
	"ip_ttl"    INTEGER       NOT NULL,
	"ip_ver"    INTEGER       NOT NULL
--	CONSTRAINT "ippacket_2_guid_pkey" PRIMARY KEY ("guid")
) ON 'mapi:monetdb://172.17.0.4:50000/threatmonitor';

DROP TABLE wifi_ippacket3;
CREATE REMOTE TABLE wifi_ippacket3 (
	"guid"      CHAR(36)      NOT NULL,
	"recv_date" CHARACTER LARGE OBJECT,
	"ip_df"     VARCHAR(5),
	"ip_dst"    VARCHAR(15),
	"ip_hlen"   INTEGER       NOT NULL,
	"ip_id"     INTEGER       NOT NULL,
	"ip_len"    INTEGER       NOT NULL,
	"ip_mf"     VARCHAR(5),
	"ip_off"    INTEGER       NOT NULL,
	"ip_proto"  INTEGER       NOT NULL,
	"ip_src"    VARCHAR(15),
	"ip_sum"    CHAR(10),
	"ip_tos"    INTEGER       NOT NULL,
	"ip_ttl"    INTEGER       NOT NULL,
	"ip_ver"    INTEGER       NOT NULL
--	CONSTRAINT "ippacket_3_guid_pkey" PRIMARY KEY ("guid")
) ON 'mapi:monetdb://172.17.0.5:50000/threatmonitor';

DROP TABLE wifi_ippacket4;
CREATE REMOTE TABLE wifi_ippacket4 (
	"guid"      CHAR(36)      NOT NULL,
	"recv_date" CHARACTER LARGE OBJECT,
	"ip_df"     VARCHAR(5),
	"ip_dst"    VARCHAR(15),
	"ip_hlen"   INTEGER       NOT NULL,
	"ip_id"     INTEGER       NOT NULL,
	"ip_len"    INTEGER       NOT NULL,
	"ip_mf"     VARCHAR(5),
	"ip_off"    INTEGER       NOT NULL,
	"ip_proto"  INTEGER       NOT NULL,
	"ip_src"    VARCHAR(15),
	"ip_sum"    CHAR(10),
	"ip_tos"    INTEGER       NOT NULL,
	"ip_ttl"    INTEGER       NOT NULL,
	"ip_ver"    INTEGER       NOT NULL
--	CONSTRAINT "ippacket_4_guid_pkey" PRIMARY KEY ("guid")
) ON 'mapi:monetdb://172.17.0.6:50000/threatmonitor';


CREATE MERGE TABLE ippacket (
	"guid"      CHAR(36)      NOT NULL,
	"recv_date" CHARACTER LARGE OBJECT,
	"ip_df"     VARCHAR(5),
	"ip_dst"    VARCHAR(15),
	"ip_hlen"   INTEGER       NOT NULL,
	"ip_id"     INTEGER       NOT NULL,
	"ip_len"    INTEGER       NOT NULL,
	"ip_mf"     VARCHAR(5),
	"ip_off"    INTEGER       NOT NULL,
	"ip_proto"  INTEGER       NOT NULL,
	"ip_src"    VARCHAR(15),
	"ip_sum"    CHAR(10),
	"ip_tos"    INTEGER       NOT NULL,
	"ip_ttl"    INTEGER       NOT NULL,
	"ip_ver"    INTEGER       NOT NULL
--	CONSTRAINT "ippacket_merge_guid_pkey" PRIMARY KEY ("guid")
);

ALTER TABLE ippacket ADD TABLE wifi_ippacket;
ALTER TABLE ippacket ADD TABLE wifi_ippacket2;
ALTER TABLE ippacket ADD TABLE wifi_ippacket3;
ALTER TABLE ippacket ADD TABLE wifi_ippacket4;

DROP TABLE wifi_tcppacket;
CREATE REMOTE TABLE "threatmonitor"."wifi_tcppacket" (
	"guid"         CHAR(36)      NOT NULL,
	"recv_date"    CHARACTER LARGE OBJECT,
	"tcp_data_len" INTEGER,
	"tcp_dport"    INTEGER,
	"tcp_ack"      CHAR(1),
	"tcp_fin"      CHAR(1),
	"tcp_syn"      CHAR(1),
	"tcp_rst"      CHAR(1),
	"tcp_psh"      CHAR(1),
	"tcp_urg"      CHAR(1),
	"tcp_off"      INTEGER,
	"tcp_hlen"     INTEGER,
	"tcp_seq"      BIGINT,
	"tcp_sum"      CHAR(10),
	"tcp_sport"    INTEGER,
	"tcp_urp"      CHAR(10),
	"tcp_win"      INTEGER
--	CONSTRAINT "tcppacket_1_guid_pkey" PRIMARY KEY ("guid")
) ON 'mapi:monetdb://172.17.0.3:50000/threatmonitor';

DROP TABLE wifi_tcppacket2;
CREATE REMOTE TABLE "threatmonitor"."wifi_tcppacket2" (
	"guid"         CHAR(36)      NOT NULL,
	"recv_date"    CHARACTER LARGE OBJECT,
	"tcp_data_len" INTEGER,
	"tcp_dport"    INTEGER,
	"tcp_ack"      CHAR(1),
	"tcp_fin"      CHAR(1),
	"tcp_syn"      CHAR(1),
	"tcp_rst"      CHAR(1),
	"tcp_psh"      CHAR(1),
	"tcp_urg"      CHAR(1),
	"tcp_off"      INTEGER,
	"tcp_hlen"     INTEGER,
	"tcp_seq"      BIGINT,
	"tcp_sum"      CHAR(10),
	"tcp_sport"    INTEGER,
	"tcp_urp"      CHAR(10),
	"tcp_win"      INTEGER
--	CONSTRAINT "tcppacket_2_guid_pkey" PRIMARY KEY ("guid")
) ON 'mapi:monetdb://172.17.0.4:50000/threatmonitor';

DROP TABLE wifi_tcppacket3;
CREATE REMOTE TABLE "threatmonitor"."wifi_tcppacket3" (
	"guid"         CHAR(36)      NOT NULL,
	"recv_date"    CHARACTER LARGE OBJECT,
	"tcp_data_len" INTEGER,
	"tcp_dport"    INTEGER,
	"tcp_ack"      CHAR(1),
	"tcp_fin"      CHAR(1),
	"tcp_syn"      CHAR(1),
	"tcp_rst"      CHAR(1),
	"tcp_psh"      CHAR(1),
	"tcp_urg"      CHAR(1),
	"tcp_off"      INTEGER,
	"tcp_hlen"     INTEGER,
	"tcp_seq"      BIGINT,
	"tcp_sum"      CHAR(10),
	"tcp_sport"    INTEGER,
	"tcp_urp"      CHAR(10),
	"tcp_win"      INTEGER
--	CONSTRAINT "tcppacket_3_guid_pkey" PRIMARY KEY ("guid")
) ON 'mapi:monetdb://172.17.0.5:50000/threatmonitor';

DROP TABLE wifi_tcppacket4;
CREATE REMOTE TABLE "threatmonitor"."wifi_tcppacket4" (
	"guid"         CHAR(36)      NOT NULL,
	"recv_date"    CHARACTER LARGE OBJECT,
	"tcp_data_len" INTEGER,
	"tcp_dport"    INTEGER,
	"tcp_ack"      CHAR(1),
	"tcp_fin"      CHAR(1),
	"tcp_syn"      CHAR(1),
	"tcp_rst"      CHAR(1),
	"tcp_psh"      CHAR(1),
	"tcp_urg"      CHAR(1),
	"tcp_off"      INTEGER,
	"tcp_hlen"     INTEGER,
	"tcp_seq"      BIGINT,
	"tcp_sum"      CHAR(10),
	"tcp_sport"    INTEGER,
	"tcp_urp"      CHAR(10),
	"tcp_win"      INTEGER
--	CONSTRAINT "tcppacket_4_guid_pkey" PRIMARY KEY ("guid")
) ON 'mapi:monetdb://172.17.0.6:50000/threatmonitor';

CREATE MERGE TABLE "threatmonitor"."tcppacket" (
	"guid"         CHAR(36)      NOT NULL,
	"recv_date"    CHARACTER LARGE OBJECT,
	"tcp_data_len" INTEGER,
	"tcp_dport"    INTEGER,
	"tcp_ack"      CHAR(1),
	"tcp_fin"      CHAR(1),
	"tcp_syn"      CHAR(1),
	"tcp_rst"      CHAR(1),
	"tcp_psh"      CHAR(1),
	"tcp_urg"      CHAR(1),
	"tcp_off"      INTEGER,
	"tcp_hlen"     INTEGER,
	"tcp_seq"      BIGINT,
	"tcp_sum"      CHAR(10),
	"tcp_sport"    INTEGER,
	"tcp_urp"      CHAR(10),
	"tcp_win"      INTEGER
--	CONSTRAINT "tcppacket_merge_guid_pkey" PRIMARY KEY ("guid")
);

ALTER TABLE tcppacket ADD TABLE wifi_tcppacket;
ALTER TABLE tcppacket ADD TABLE wifi_tcppacket2;
ALTER TABLE tcppacket ADD TABLE wifi_tcppacket3;
ALTER TABLE tcppacket ADD TABLE wifi_tcppacket4;

-- Remote schema host mdb-repl-01

CREATE SCHEMA "threatmonitor";
SET SCHEMA "threatmonitor";
CREATE TABLE "threatmonitor"."wifi_ippacket" (
	"guid"      CHAR(36)      NOT NULL,
	"recv_date" CHARACTER LARGE OBJECT,
	"ip_df"     VARCHAR(5),
	"ip_dst"    VARCHAR(15),
	"ip_hlen"   INTEGER       NOT NULL,
	"ip_id"     INTEGER       NOT NULL,
	"ip_len"    INTEGER       NOT NULL,
	"ip_mf"     VARCHAR(5),
	"ip_off"    INTEGER       NOT NULL,
	"ip_proto"  INTEGER       NOT NULL,
	"ip_src"    VARCHAR(15),
	"ip_sum"    CHAR(10),
	"ip_tos"    INTEGER       NOT NULL,
	"ip_ttl"    INTEGER       NOT NULL,
	"ip_ver"    INTEGER       NOT NULL,
	CONSTRAINT "ippacket_1_guid_pkey" PRIMARY KEY ("guid")
);

CREATE TABLE "threatmonitor"."wifi_tcppacket" (
	"guid"         CHAR(36)      NOT NULL,
	"recv_date"    CHARACTER LARGE OBJECT,
	"tcp_data_len" INTEGER       DEFAULT NULL,
	"tcp_dport"    INTEGER       DEFAULT NULL,
	"tcp_ack"      CHAR(1)       DEFAULT NULL,
	"tcp_fin"      CHAR(1)       DEFAULT NULL,
	"tcp_syn"      CHAR(1)       DEFAULT NULL,
	"tcp_rst"      CHAR(1)       DEFAULT NULL,
	"tcp_psh"      CHAR(1)       DEFAULT NULL,
	"tcp_urg"      CHAR(1)       DEFAULT NULL,
	"tcp_off"      INTEGER       DEFAULT NULL,
	"tcp_hlen"     INTEGER       DEFAULT NULL,
	"tcp_seq"      BIGINT        DEFAULT NULL,
	"tcp_sum"      CHAR(10)      DEFAULT NULL,
	"tcp_sport"    INTEGER       DEFAULT NULL,
	"tcp_urp"      CHAR(10)      DEFAULT NULL,
	"tcp_win"      INTEGER       DEFAULT NULL,
	CONSTRAINT "tcppacket_1_guid_pkey" PRIMARY KEY ("guid")
);

-- Remote schema host mdb-repl-02

CREATE SCHEMA "threatmonitor";
SET SCHEMA "threatmonitor";
CREATE TABLE "threatmonitor"."wifi_ippacket2" (
	"guid"      CHAR(36)      NOT NULL,
	"recv_date" CHARACTER LARGE OBJECT,
	"ip_df"     VARCHAR(5),
	"ip_dst"    VARCHAR(15),
	"ip_hlen"   INTEGER,
	"ip_id"     INTEGER,
	"ip_len"    INTEGER,
	"ip_mf"     VARCHAR(5),
	"ip_off"    INTEGER,
	"ip_proto"  INTEGER,
	"ip_src"    VARCHAR(15),
	"ip_sum"    CHAR(10),
	"ip_tos"    INTEGER,
	"ip_ttl"    INTEGER,
	"ip_ver"    INTEGER,
	CONSTRAINT "ippacket_2_guid_pkey" PRIMARY KEY ("guid")
);

CREATE TABLE "threatmonitor"."wifi_tcppacket2" (
	"guid"         CHAR(36)      NOT NULL,
	"recv_date"    CHARACTER LARGE OBJECT,
	"tcp_data_len" INTEGER       DEFAULT NULL,
	"tcp_dport"    INTEGER       DEFAULT NULL,
	"tcp_ack"      CHAR(1)       DEFAULT NULL,
	"tcp_fin"      CHAR(1)       DEFAULT NULL,
	"tcp_syn"      CHAR(1)       DEFAULT NULL,
	"tcp_rst"      CHAR(1)       DEFAULT NULL,
	"tcp_psh"      CHAR(1)       DEFAULT NULL,
	"tcp_urg"      CHAR(1)       DEFAULT NULL,
	"tcp_off"      INTEGER       DEFAULT NULL,
	"tcp_hlen"     INTEGER       DEFAULT NULL,
	"tcp_seq"      BIGINT        DEFAULT NULL,
	"tcp_sum"      CHAR(10)      DEFAULT NULL,
	"tcp_sport"    INTEGER       DEFAULT NULL,
	"tcp_urp"      CHAR(10)      DEFAULT NULL,
	"tcp_win"      INTEGER       DEFAULT NULL,
	CONSTRAINT "tcppacket_2_guid_pkey" PRIMARY KEY ("guid")
);

-- Remote schema host mdb-repl-03

CREATE SCHEMA "threatmonitor";
SET SCHEMA "threatmonitor";
CREATE TABLE "threatmonitor"."wifi_ippacket3" (
	"guid"      CHAR(36)      NOT NULL,
	"recv_date" CHARACTER LARGE OBJECT,
	"ip_df"     VARCHAR(5),
	"ip_dst"    VARCHAR(15),
	"ip_hlen"   INTEGER,
	"ip_id"     INTEGER,
	"ip_len"    INTEGER,
	"ip_mf"     VARCHAR(5),
	"ip_off"    INTEGER,
	"ip_proto"  INTEGER,
	"ip_src"    VARCHAR(15),
	"ip_sum"    CHAR(10),
	"ip_tos"    INTEGER,
	"ip_ttl"    INTEGER,
	"ip_ver"    INTEGER,
	CONSTRAINT "ippacket_3_guid_pkey" PRIMARY KEY ("guid")
);

CREATE TABLE "threatmonitor"."wifi_tcppacket3" (
	"guid"         CHAR(36)      NOT NULL,
	"recv_date"    CHARACTER LARGE OBJECT,
	"tcp_data_len" INTEGER       DEFAULT NULL,
	"tcp_dport"    INTEGER       DEFAULT NULL,
	"tcp_ack"      CHAR(1)       DEFAULT NULL,
	"tcp_fin"      CHAR(1)       DEFAULT NULL,
	"tcp_syn"      CHAR(1)       DEFAULT NULL,
	"tcp_rst"      CHAR(1)       DEFAULT NULL,
	"tcp_psh"      CHAR(1)       DEFAULT NULL,
	"tcp_urg"      CHAR(1)       DEFAULT NULL,
	"tcp_off"      INTEGER       DEFAULT NULL,
	"tcp_hlen"     INTEGER       DEFAULT NULL,
	"tcp_seq"      BIGINT        DEFAULT NULL,
	"tcp_sum"      CHAR(10)      DEFAULT NULL,
	"tcp_sport"    INTEGER       DEFAULT NULL,
	"tcp_urp"      CHAR(10)      DEFAULT NULL,
	"tcp_win"      INTEGER       DEFAULT NULL,
	CONSTRAINT "tcppacket_3_guid_pkey" PRIMARY KEY ("guid")
);

-- Remote schema host mdb-repl-04

CREATE SCHEMA "threatmonitor";
SET SCHEMA "threatmonitor";
CREATE TABLE "threatmonitor"."wifi_ippacket4" (
	"guid"      CHAR(36)      NOT NULL,
	"recv_date" CHARACTER LARGE OBJECT,
	"ip_df"     VARCHAR(5),
	"ip_dst"    VARCHAR(15),
	"ip_hlen"   INTEGER,
	"ip_id"     INTEGER,
	"ip_len"    INTEGER,
	"ip_mf"     VARCHAR(5),
	"ip_off"    INTEGER,
	"ip_proto"  INTEGER,
	"ip_src"    VARCHAR(15),
	"ip_sum"    CHAR(10),
	"ip_tos"    INTEGER,
	"ip_ttl"    INTEGER,
	"ip_ver"    INTEGER,
	CONSTRAINT "ippacket_4_guid_pkey" PRIMARY KEY ("guid")
);

CREATE TABLE "threatmonitor"."wifi_tcppacket4" (
	"guid"         CHAR(36)      NOT NULL,
	"recv_date"    CHARACTER LARGE OBJECT,
	"tcp_data_len" INTEGER       DEFAULT NULL,
	"tcp_dport"    INTEGER       DEFAULT NULL,
	"tcp_ack"      CHAR(1)       DEFAULT NULL,
	"tcp_fin"      CHAR(1)       DEFAULT NULL,
	"tcp_syn"      CHAR(1)       DEFAULT NULL,
	"tcp_rst"      CHAR(1)       DEFAULT NULL,
	"tcp_psh"      CHAR(1)       DEFAULT NULL,
	"tcp_urg"      CHAR(1)       DEFAULT NULL,
	"tcp_off"      INTEGER       DEFAULT NULL,
	"tcp_hlen"     INTEGER       DEFAULT NULL,
	"tcp_seq"      BIGINT        DEFAULT NULL,
	"tcp_sum"      CHAR(10)      DEFAULT NULL,
	"tcp_sport"    INTEGER       DEFAULT NULL,
	"tcp_urp"      CHAR(10)      DEFAULT NULL,
	"tcp_win"      INTEGER       DEFAULT NULL,
	CONSTRAINT "tcppacket_4_guid_pkey" PRIMARY KEY ("guid")
);

-- Threatmonmitor Suite machine

CREATE REMOTE TABLE "threatmonitor".geoipdata_ipv4blocks_city (
  network varchar(18) NOT NULL,
  geoname_id char(10) NOT NULL,
  registered_country_geoname_id char(30) NOT NULL,
  represented_country_geoname_id char(30) NOT NULL,
  is_anonymous_proxy char(30) NOT NULL,
  is_satellite_provider char(30) NOT NULL,
  postal_code char(30) NOT NULL,
  latitude char(10) NOT NULL,
  longitude char(10) NOT NULL
) ON 'mapi:monetdb://172.17.0.7:50000/threatmonitor';

CREATE REMOTE TABLE "threatmonitor".geoipdata_locations_city (
  geoname_id char(10) NOT NULL,
  locale_code char(2) NOT NULL,
  continent_code char(2) NOT NULL,
  continent_name char(15) NOT NULL,
  country_iso_code char(2) NOT NULL,
  country_name char(50) NOT NULL,
  subdivision_1_iso_code char(70) NOT NULL,
  subdivision_1_name char(50) NOT NULL,
  subdivision_2_iso_code char(70) NOT NULL,
  subdivision_2_name char(50) NOT NULL,
  city_name char(70) NOT NULL,
  metro_code char(30) NOT NULL,
  time_zone char(30) NOT NULL
) ON 'mapi:monetdb://172.17.0.7:50000/threatmonitor';

CREATE REMOTE TABLE "threatmonitor".geoipdata_ipv4blocks_country (
  network varchar(18) NOT NULL,
  geoname_id char(10) NOT NULL,
  registered_country_geoname_id char(30) NOT NULL,
  represented_country_geoname_id char(30) NOT NULL,
  is_anonymous_proxy char(30) NOT NULL,
  is_satellite_provider char(30) NOT NULL
) ON 'mapi:monetdb://172.17.0.7:50000/threatmonitor';

CREATE REMOTE TABLE "threatmonitor".geoipdata_locations_country (
  geoname_id char(10) NOT NULL,
  locale_code char(2) NOT NULL,
  continent_code char(2) NOT NULL,
  continent_name char(15) NOT NULL,
  country_iso_code char(2) NOT NULL,
  country_name char(50) NOT NULL
) ON 'mapi:monetdb://172.17.0.7:50000/threatmonitor';

