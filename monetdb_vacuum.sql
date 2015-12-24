sql>\d wifi_ippacket
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
	CONSTRAINT "wifi_ippacket_guid_pkey" PRIMARY KEY ("guid")
);
CREATE INDEX "index_guid_wifiip" ON "threatmonitor"."wifi_ippacket" ("guid");
CREATE INDEX "index_ip_dst_wifiip" ON "threatmonitor"."wifi_ippacket" ("ip_dst");
CREATE INDEX "index_ip_src_wifiip" ON "threatmonitor"."wifi_ippacket" ("ip_src");

---

DROP INDEX "index_guid_wifiip";
DROP INDEX "index_ip_dst_wifiip";
DROP INDEX "index_ip_src_wifiip";
ALTER TABLE wifi_ippacket DROP CONSTRAINT wifi_ippacket_guid_pkey;


CALL sys.vacuum('threatmonitor', 'wifi_ippacket');

ALTER TABLE wifi_ippacket ADD CONSTRAINT wifi_ippacket_guid_pkey PRIMARY KEY (guid);
CREATE INDEX "index_guid_wifiip" ON "threatmonitor"."wifi_ippacket" ("guid");
CREATE INDEX "index_ip_dst_wifiip" ON "threatmonitor"."wifi_ippacket" ("ip_dst");
CREATE INDEX "index_ip_src_wifiip" ON "threatmonitor"."wifi_ippacket" ("ip_src");

sql>\d wifi_ippacket
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
	CONSTRAINT "wifi_ippacket_guid_pkey" PRIMARY KEY ("guid")
);
CREATE INDEX "index_guid_wifiip" ON "threatmonitor"."wifi_ippacket" ("guid");
CREATE INDEX "index_ip_dst_wifiip" ON "threatmonitor"."wifi_ippacket" ("ip_dst");
CREATE INDEX "index_ip_src_wifiip" ON "threatmonitor"."wifi_ippacket" ("ip_src");

