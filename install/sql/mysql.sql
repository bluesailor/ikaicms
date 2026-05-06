-- ikaiCMS Install SQL
-- Generated via mysqldump
-- Tables with data: channels, contents, products, settings, banners, etc.
-- Tables structure only: admin_logs, ai_logs, users, forms, media

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `yikai_admin_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_admin_logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0',
  `admin_name` varchar(50) NOT NULL DEFAULT '',
  `module` varchar(50) NOT NULL DEFAULT '' COMMENT '模块',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '动作',
  `description` varchar(500) NOT NULL DEFAULT '' COMMENT '描述',
  `url` varchar(255) NOT NULL DEFAULT '',
  `method` varchar(10) NOT NULL DEFAULT '',
  `request_data` text,
  `ip` varchar(45) NOT NULL DEFAULT '',
  `user_agent` varchar(500) NOT NULL DEFAULT '',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_admin` (`admin_id`),
  KEY `idx_module` (`module`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_admin_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_admin_logs` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_ai_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_ai_logs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `model` varchar(50) NOT NULL DEFAULT '',
  `action` varchar(50) NOT NULL DEFAULT '',
  `prompt_tokens` int(11) NOT NULL DEFAULT '0',
  `completion_tokens` int(11) NOT NULL DEFAULT '0',
  `total_tokens` int(11) NOT NULL DEFAULT '0',
  `success` tinyint(1) NOT NULL DEFAULT '1',
  `error_msg` varchar(500) NOT NULL DEFAULT '',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_provider` (`provider`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='AI调用日志';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_ai_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_ai_logs` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_album_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_album_photos` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `album_id` int(11) unsigned NOT NULL COMMENT '所属相册',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '图片标题',
  `image` varchar(500) NOT NULL COMMENT '图片地址',
  `thumb` varchar(500) NOT NULL DEFAULT '' COMMENT '缩略图',
  `description` varchar(500) NOT NULL DEFAULT '' COMMENT '图片描述',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序(越大越靠前)',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1显示 0隐藏',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_album` (`album_id`),
  KEY `idx_sort` (`sort_order` DESC,`id` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='相册图片';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_album_photos` DISABLE KEYS */;
INSERT INTO `yikai_album_photos` VALUES (1,7,'授权证书','/images/cert-1.jpg','/images/cert-1.jpg','企业授权认证证书',1,1,1770899116);
/*!40000 ALTER TABLE `yikai_album_photos` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_albums` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT '0' COMMENT '分类ID',
  `name` varchar(100) NOT NULL COMMENT '相册名称',
  `slug` varchar(100) DEFAULT '' COMMENT 'URL别名',
  `cover` varchar(500) DEFAULT '' COMMENT '封面图',
  `description` text COMMENT '相册描述',
  `photo_count` int(10) unsigned DEFAULT '0' COMMENT '图片数量',
  `sort_order` int(11) DEFAULT '0' COMMENT '排序(越大越靠前)',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1显示 0隐藏',
  `created_at` int(10) unsigned DEFAULT '0',
  `updated_at` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort_order` DESC,`id` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='相册';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_albums` DISABLE KEYS */;
INSERT INTO `yikai_albums` VALUES (7,0,'荣誉资质','honor','/images/cert-1.jpg','企业荣誉证书与资质认证',1,100,1,1770899116,0),(8,0,'团队风采','team','','团队活动与员工风采展示',0,90,1,1770899116,0),(9,0,'企业环境','environment','','公司办公环境与生产车间',0,80,1,1770899116,0);
/*!40000 ALTER TABLE `yikai_albums` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_article_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_article_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父分类ID',
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `slug` varchar(100) NOT NULL DEFAULT '' COMMENT 'URL别名',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '分类图片',
  `description` text COMMENT '分类描述',
  `seo_title` varchar(255) NOT NULL DEFAULT '',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(500) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_parent` (`parent_id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文章分类';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_article_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_article_categories` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_articles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `subtitle` varchar(255) NOT NULL DEFAULT '' COMMENT '副标题',
  `slug` varchar(255) NOT NULL DEFAULT '' COMMENT 'URL别名',
  `cover` varchar(255) NOT NULL DEFAULT '' COMMENT '封面图',
  `summary` text COMMENT '摘要',
  `content` longtext COMMENT '内容',
  `author` varchar(50) NOT NULL DEFAULT '' COMMENT '作者',
  `source` varchar(100) NOT NULL DEFAULT '' COMMENT '来源',
  `tags` varchar(255) NOT NULL DEFAULT '' COMMENT '标签',
  `is_top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '热门',
  `views` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `likes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0草稿 1发布',
  `publish_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_publish` (`publish_time`),
  KEY `idx_top` (`is_top`),
  KEY `idx_recommend` (`is_recommend`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文章表';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_articles` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_articles` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_banner_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_banner_groups` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '分组名称',
  `slug` varchar(50) NOT NULL COMMENT '短码标识',
  `height_pc` smallint(5) unsigned NOT NULL DEFAULT '500' COMMENT 'PC端高度',
  `height_mobile` smallint(5) unsigned NOT NULL DEFAULT '250' COMMENT '移动端高度',
  `autoplay_delay` int(11) unsigned NOT NULL DEFAULT '5000' COMMENT '自动播放间隔ms',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='轮播图分组';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_banner_groups` DISABLE KEYS */;
INSERT INTO `yikai_banner_groups` VALUES (1,'首页','home',650,300,5000,0,1,0),(2,'关于我们','about',500,250,5000,1,1,0),(3,'产品中心','product',500,250,5000,2,1,0),(4,'案例展示','case',500,250,5000,3,1,0);
/*!40000 ALTER TABLE `yikai_banner_groups` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_banners` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `position` varchar(50) NOT NULL DEFAULT 'home' COMMENT '位置',
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '标题',
  `subtitle` varchar(255) NOT NULL DEFAULT '' COMMENT '副标题',
  `btn1_text` varchar(50) NOT NULL DEFAULT '' COMMENT '按钮1文字',
  `btn1_url` varchar(255) NOT NULL DEFAULT '' COMMENT '按钮1链接',
  `btn2_text` varchar(50) NOT NULL DEFAULT '' COMMENT '按钮2文字',
  `btn2_url` varchar(255) NOT NULL DEFAULT '' COMMENT '按钮2链接',
  `image` varchar(255) NOT NULL COMMENT '图片',
  `image_mobile` varchar(255) NOT NULL DEFAULT '' COMMENT '移动端图片',
  `link_url` varchar(255) NOT NULL DEFAULT '' COMMENT '链接',
  `link_target` varchar(20) NOT NULL DEFAULT '_self',
  `start_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_position` (`position`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort_order`),
  KEY `idx_banner_lang` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='轮播图';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_banners` DISABLE KEYS */;
INSERT INTO `yikai_banners` VALUES (1,'home','ja','デジタルトランスフォーメーション','企業のスマート化を支援します','会社概要','/company.html','ダウンロード','/download.html','https://picsum.photos/1920/600?random=1','','/company.html','_self',0,0,1,1,1770899116),(2,'home','ja','プロフェッショナル技術サポート','24時間365日、安心のサポート体制','詳しく見る','/service.html','','','https://picsum.photos/1920/600?random=2','','/service.html','_self',0,0,1,2,1770899116),(3,'home','ja','イノベーションが未来を拓く','継続的な革新で卓越を追求します','','','','','https://picsum.photos/1920/600?random=3','','','_self',0,0,1,3,1770899116);
/*!40000 ALTER TABLE `yikai_banners` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_brands` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '品牌名',
  `slug` varchar(100) NOT NULL DEFAULT '',
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT '品牌Logo',
  `country` varchar(50) NOT NULL DEFAULT '' COMMENT '国家/产地',
  `description` text COMMENT '品牌介绍',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '官网',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='品牌管理';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_brands` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_brands` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_channels` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父栏目ID',
  `name` varchar(100) NOT NULL COMMENT '栏目名称',
  `slug` varchar(100) NOT NULL COMMENT 'URL别名',
  `type` varchar(20) NOT NULL DEFAULT 'list' COMMENT '类型：list/page/link/product/case/download/job/album',
  `album_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '关联相册ID',
  `icon` varchar(100) NOT NULL DEFAULT '' COMMENT '图标',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '栏目图片',
  `description` text COMMENT '栏目描述',
  `content` longtext COMMENT '单页内容',
  `redirect_type` varchar(10) NOT NULL DEFAULT 'auto' COMMENT '跳转方式：auto自动跳转子栏目/none不跳转/url指定地址',
  `redirect_url` varchar(255) NOT NULL DEFAULT '' COMMENT '跳转地址(redirect_type=url时使用)',
  `link_url` varchar(255) NOT NULL DEFAULT '' COMMENT '外链地址',
  `link_target` varchar(20) NOT NULL DEFAULT '_self' COMMENT '打开方式',
  `seo_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'SEO标题',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '' COMMENT 'SEO关键词',
  `seo_description` varchar(500) NOT NULL DEFAULT '' COMMENT 'SEO描述',
  `is_nav` tinyint(1) NOT NULL DEFAULT '1' COMMENT '显示在导航',
  `is_home` tinyint(1) NOT NULL DEFAULT '0' COMMENT '显示在首页',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `is_system` tinyint(1) NOT NULL DEFAULT '0' COMMENT '系统预设：1是 0否',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`),
  KEY `idx_parent` (`parent_id`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort_order`),
  KEY `idx_lang` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='栏目表';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_channels` DISABLE KEYS */;
INSERT INTO `yikai_channels` VALUES (1,'ja',0,0,'会社概要','company','page',0,'','','会社情報','<table style=\"width:100%;border-collapse:collapse\">\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">会社名</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">株式会社○○（かぶしきがいしゃ ○○）</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">設立</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">2020年4月</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">代表者</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">代表取締役　○○ ○○</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">資本金</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">1,000万円</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">従業員数</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">50名（2024年4月現在）</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">事業内容</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">・IoTソリューションの企画・開発・販売<br>・企業向けクラウドサービスの提供<br>・システムインテグレーション<br>・テクニカルサポート・コンサルティング</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">本社所在地</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">〒150-0000<br>東京都渋谷区XX町X丁目X-X XXビル 5F</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">大阪支社</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">〒530-0000<br>大阪府大阪市北区XX町X丁目X-X XXビル 3F</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">電話番号</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">03-0000-0000</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">FAX</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">03-0000-0001</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">メールアドレス</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">info@example.co.jp</td>\n</tr>\n<tr style=\"border-bottom:1px solid #e5e7eb\">\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">取引銀行</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">三菱UFJ銀行 ○○支店<br>みずほ銀行 ○○支店</td>\n</tr>\n<tr>\n<th style=\"padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top\">主要取引先</th>\n<td style=\"padding:16px 20px;font-size:14px;color:#4b5563\">株式会社○○<br>○○株式会社<br>○○グループ（順不同・敬称略）</td>\n</tr>\n</table>','none','','','_self','','','',1,0,1,1,1,1770899116,0),(2,'ja',0,1,'代表挨拶','greeting','page',0,'','','代表取締役からのメッセージ',NULL,'none','','','_self','','','',1,0,1,1,1,1770899116,0),(3,'ja',0,1,'企業理念','philosophy','page',0,'','','ミッション・ビジョン・バリュー',NULL,'none','','','_self','','','',1,0,1,1,2,1770899116,0),(4,'ja',0,1,'沿革','history','page',0,'','','会社の歩み',NULL,'none','','','_self','','','',1,0,1,1,3,1770899116,0),(5,'ja',0,1,'アクセス','access','page',0,'','','所在地・交通案内',NULL,'none','','','_self','','','',1,0,1,1,4,1770899116,0),(6,'ja',0,0,'事業内容','service','page',0,'','','事業内容のご紹介',NULL,'auto','','','_self','','','',1,0,1,1,2,1770899116,0),(7,'ja',0,0,'製品情報','product','product',0,'','','製品・サービス一覧',NULL,'auto','','','_self','','','',1,1,1,1,3,1770899116,0),(9,'ja',0,0,'導入事例','works','case',0,'','','お客様の導入事例',NULL,'auto','','','_self','','','',1,1,1,1,4,1770899116,0),(12,'ja',0,0,'お知らせ','news','list',0,'','','最新のお知らせ',NULL,'auto','','','_self','','','',1,1,1,1,5,1770899116,0),(13,'ja',0,12,'ニュース','company-news','list',0,'','','企業ニュース',NULL,'auto','','','_self','','','',1,0,1,1,1,1770899116,0),(14,'ja',0,12,'プレスリリース','press','list',0,'','','プレスリリース',NULL,'auto','','','_self','','','',1,0,1,1,2,1770899116,0),(17,'ja',0,0,'よくあるご質問','faq','list',0,'','','お客様からよく寄せられるご質問',NULL,'auto','','','_self','','','',1,0,1,1,7,1770899116,0),(19,'ja',0,0,'採用情報','recruit','job',0,'','','一緒に働く仲間を募集しています',NULL,'auto','','','_self','','','',1,0,1,1,6,1770899116,0),(20,'ja',0,0,'お問い合わせ','contact','page',0,'','','お問い合わせフォーム',NULL,'none','','','_self','','','',1,0,1,1,8,1770899116,0),(29,'ja',0,0,'プライバシーポリシー','privacy','page',0,'','','個人情報の取り扱いについて',NULL,'none','','','_self','','','',0,0,1,1,98,1770899116,0),(30,'ja',0,0,'利用規約','terms','page',0,'','','ウェブサイトのご利用条件',NULL,'none','','','_self','','','',0,0,1,1,99,1770899116,0),(31,'ja',0,0,'サイトマップ','sitemap-page','page',0,'','','サイト全体の構成',NULL,'none','','','_self','','','',0,0,1,1,97,1770899116,0);
/*!40000 ALTER TABLE `yikai_channels` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_contents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `channel_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '栏目ID',
  `type` varchar(20) NOT NULL DEFAULT 'article' COMMENT '类型：article/product/case/download/job',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `subtitle` varchar(255) NOT NULL DEFAULT '' COMMENT '副标题',
  `slug` varchar(255) NOT NULL DEFAULT '' COMMENT 'URL别名',
  `cover` varchar(255) NOT NULL DEFAULT '' COMMENT '封面图',
  `images` text COMMENT '图片组JSON',
  `summary` text COMMENT '摘要',
  `content` longtext COMMENT '内容',
  `content_type` varchar(10) NOT NULL DEFAULT 'html',
  `blocks_data` longtext,
  `author` varchar(50) NOT NULL DEFAULT '' COMMENT '作者',
  `source` varchar(100) NOT NULL DEFAULT '' COMMENT '来源',
  `tags` varchar(255) NOT NULL DEFAULT '' COMMENT '标签',
  `attachment` varchar(255) NOT NULL DEFAULT '' COMMENT '附件',
  `download_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `specs` text COMMENT '规格JSON',
  `location` varchar(100) NOT NULL DEFAULT '' COMMENT '工作地点',
  `salary` varchar(50) NOT NULL DEFAULT '' COMMENT '薪资范围',
  `requirements` text COMMENT '任职要求',
  `client_name` varchar(100) NOT NULL DEFAULT '',
  `industry` varchar(100) NOT NULL DEFAULT '',
  `duration` varchar(50) NOT NULL DEFAULT '',
  `result_metric` varchar(255) NOT NULL DEFAULT '',
  `headcount` varchar(20) NOT NULL DEFAULT '' COMMENT '招聘人数',
  `job_type` varchar(20) NOT NULL DEFAULT '' COMMENT '工作性质',
  `education` varchar(50) NOT NULL DEFAULT '' COMMENT '学历要求',
  `experience` varchar(50) NOT NULL DEFAULT '' COMMENT '经验要求',
  `is_top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '热门',
  `views` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `likes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数',
  `seo_title` varchar(255) NOT NULL DEFAULT '',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(500) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0草稿 1发布 2归档',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `publish_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `idx_channel` (`channel_id`),
  KEY `idx_type` (`type`),
  KEY `idx_status` (`status`),
  KEY `idx_publish` (`publish_time`),
  KEY `idx_top` (`is_top`),
  KEY `idx_recommend` (`is_recommend`),
  KEY `idx_hot` (`is_hot`),
  KEY `idx_lang_status` (`lang`,`status`),
  KEY `idx_trans_group` (`translation_group_id`),
  FULLTEXT KEY `ft_search` (`title`,`summary`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='内容表';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_contents` DISABLE KEYS */;
INSERT INTO `yikai_contents` VALUES (1,'ja',0,2,'article','代表挨拶','','greeting','',NULL,'企業のデジタルトランスフォーメーションに特化し、お客様に高品質な製品とサービスを提供しています。','<h2>ご挨拶</h2>\n<p>平素より格別のお引き立てを賜り、誠にありがとうございます。</p>\n\n<p>当社は2010年の設立以来、企業のデジタルトランスフォーメーションを支援するテクノロジー企業として、研究開発・製造・販売・サポートを一貫して行ってまいりました。おかげさまで、業界において確かな実績と信頼を築くことができました。</p>\n\n<h2>私たちの強み</h2>\n<ul>\n<li><strong>技術力</strong>：複数のコア特許技術を保有</li>\n<li><strong>品質保証</strong>：ISO9001品質マネジメントシステム認証取得</li>\n<li><strong>専門サポート</strong>：24時間365日のテクニカルサポート体制</li>\n<li><strong>豊富な実績</strong>：1,000社以上の企業様にサービスを提供</li>\n</ul>\n\n<h2>今後のビジョン</h2>\n<p>技術革新を原動力とし、お客様のニーズを第一に考え、業界をリードするソリューションプロバイダーを目指してまいります。今後とも変わらぬご支援を賜りますよう、よろしくお願い申し上げます。</p>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',1,1,0,100,0,'','','',1,0,1770899116,1770899116,0,1),(2,'ja',0,3,'article','企業理念','','philosophy','',NULL,'ミッション・ビジョン・バリュー','<h2>ミッション（使命）</h2>\n<p>テクノロジーの力で価値を創造し、お客様に卓越した製品とサービスを提供します。</p>\n\n<h2>ビジョン（将来像）</h2>\n<p>業界で最も信頼され、尊敬される企業となり、社会の発展に貢献します。</p>\n\n<h2>バリュー（価値観）</h2>\n<ul>\n<li><strong>革新</strong> — 常に新しい挑戦を続け、卓越を追求します</li>\n<li><strong>誠実</strong> — 誠実さと透明性をすべての行動の基盤とします</li>\n<li><strong>共創</strong> — お客様・パートナー・社員と共に成長します</li>\n<li><strong>品質</strong> — 妥協のない品質で、期待を超える成果を目指します</li>\n</ul>\n\n<h2>行動指針</h2>\n<ul>\n<li>お客様の課題を自分事として捉え、最適なソリューションを提案する</li>\n<li>チームワークを大切にし、多様な視点を活かす</li>\n<li>失敗を恐れず挑戦し、そこから学び成長する</li>\n<li>社会的責任を果たし、持続可能な事業を推進する</li>\n</ul>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',0,0,0,50,0,'','','',1,0,1770899116,1770899116,0,1),(5,'ja',0,9,'case','大手製造企業のDXプロジェクト','','manufacturing-dx','/images/case-demo.jpg',NULL,'お客様の生産効率を30%向上させました','<h3>プロジェクト背景</h3>\n<p>クライアントは国内大手製造企業で、5つの生産拠点と2,000台以上の設備を保有。設備データの分断、生産計画の属人化、品質トレーサビリティの困難さなどの課題を抱え��いました。</p>\n<h3>ソリューション</h3>\n<ul>\n<li><strong>設備連携</strong>：200台以上のIoTゲートウェイを導��し、全生産設備のリアルタイムデータ��集を実現</li>\n<li><strong>データ基盤</strong>：統合データプラットフォームを構築し、ERP・MES・WMSシステムを連携</li>\n<li><strong>AI排程</strong>：AIアルゴリズムによるスマートスケジューリングシステムで生産計画を最適化</li>\n<li><strong>品質追跡</strong>：全工程QRコードトレーサビリティ体制を構築</li>\n</ul>\n<h3>導入成果</h3>\n<ul>\n<li>生産効率 <strong>30%</strong> 向上</li>\n<li>設備停止時間 <strong>45%</strong> 削減</li>\n<li>製品不良率 <strong>60%</strong> 低減</li>\n<li>在庫回転率 <strong>25%</strong> 改善</li>\n</ul>\n<p>導入期間6ヶ月、稼働開始から初年度で投資回収を達成しました。</p>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',1,1,0,201,0,'大手製造企業のDXプロジェクト','DX,製造業,IoT,スマートファクトリー','大手製造企業のデジタルトランスフォーメーションを支援し、生産効率30%向上を実現。',1,0,1770899116,1770899116,0,1),(6,'ja',0,13,'article','「年間最優秀テクノロジー革新賞」を受賞','','tech-award','https://picsum.photos/800/500?random=11',NULL,'先日開催された業界年間表彰式にて、当社が技術革新分野での優れた成果を評価され、受賞いたしました。','<p>先日開催された2024年度業界表彰式において、当社は技術革新分野での顕著な実績が認められ、「年間最優秀テクノロジー革新賞」を受賞いたしました。</p>\n\n<p>今回の受賞は、長年にわたり技術革新に取り組んできた当社の姿勢が評価されたものです。当社は常に技術研究開発をコア競争力として位置付け、毎年多くのリソースを製品開発と技術向上に投入してまいりました。</p>\n\n<p>代表取締役は「この賞は全社員の努力の成果です。今後も革新の精神を持ち続け、お客様により大きな価値を提供してまいります」と述べました。</p>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',1,1,1,818,0,'','','',1,0,1770899116,1770899116,0,1),(7,'ja',0,14,'article','DXトレンドレポート2024を発表','','dx-report','https://picsum.photos/800/500?random=12',NULL,'最新の業界調査レポートにより、企業のDXが不可避のトレンドであることが示されました。','<p>このたび、業界の権威ある調査機関が「2024年企業DXトレンドレポート」を発表しました。主な調査結果は以下の通りです。</p>\n\n<ul>\n<li>80%以上の企業がDXに着手済み</li>\n<li>クラウド、ビッグデータ、AIがDXの3大コア技術</li>\n<li>2025年までにDX関連投資が50%増加する見込み</li>\n</ul>\n\n<p>レポートでは、企業は早期にDX戦略を策定し、適切なテクノロジーパートナーを選定した上で、段階的にDXを推進することを推奨しています。</p>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',0,0,0,307,0,'','','',1,0,1770899116,1770899116,0,1),(8,'ja',0,16,'article','サービスフロー','','process','',NULL,'标准化的服务流程，确保服务质量','<div style=\"max-width:800px;margin:0 auto;\">\n<p style=\"text-align:center;color:#6b7280;margin-bottom:2em;\">標準化されたサービスフローで、すべてのプロジェ���トを高品質にお届けします。</p>\n<div style=\"display:flex;align-items:flex-start;margin-bottom:2em;\"><div style=\"flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#3b82f6,#60a5fa);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;\">1</div><div style=\"margin-left:20px;flex:1;\"><h3 style=\"margin-top:0;margin-bottom:4px;\">ヒアリング</h3><p style=\"color:#6b7280;\">お客様の業務課題やご要望を詳しくお伺いし、要件定義書を作成します。</p></div></div>\n<div style=\"display:flex;align-items:flex-start;margin-bottom:2em;\"><div style=\"flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#10b981,#34d399);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;\">2</div><div style=\"margin-left:20px;flex:1;\"><h3 style=\"margin-top:0;margin-bottom:4px;\">設計・提案</h3><p style=\"color:#6b7280;\">システム設計、ハードウェア選定、ネットワーク設計、プロジェクト計画を策定しご提案します。</p></div></div>\n<div style=\"display:flex;align-items:flex-start;margin-bottom:2em;\"><div style=\"flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#8b5cf6,#a78bfa);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;\">3</div><div style=\"margin-left:20px;flex:1;\"><h3 style=\"margin-top:0;margin-bottom:4px;\">開発・構築</h3><p style=\"color:#6b7280;\">アジャイル開発で定期的に進捗をご報告。重要マイルストーンではお客様にレビューいただきます。</p></div></div>\n<div style=\"display:flex;align-items:flex-start;margin-bottom:2em;\"><div style=\"flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#f59e0b,#fbbf24);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;\">4</div><div style=\"margin-left:20px;flex:1;\"><h3 style=\"margin-top:0;margin-bottom:4px;\">テスト・検収</h3><p style=\"color:#6b7280;\">機能テスト、性能テスト、セキュリティテスト、受入テストを実施し、安定稼働を確認後に本番移行します。</p></div></div>\n<div style=\"display:flex;align-items:flex-start;margin-bottom:2em;\"><div style=\"flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#ef4444,#f87171);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;\">5</div><div style=\"margin-left:20px;flex:1;\"><h3 style=\"margin-top:0;margin-bottom:4px;\">研修・納品</h3><p style=\"color:#6b7280;\">操作研修と技術ドキュメントをご提供し、お客様が独立して運用できるよう支援します。</p></div></div>\n<div style=\"display:flex;align-items:flex-start;margin-bottom:2em;\"><div style=\"flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#06b6d4,#22d3ee);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;\">6</div><div style=\"margin-left:20px;flex:1;\"><h3 style=\"margin-top:0;margin-bottom:4px;\">アフターサポート</h3><p style=\"color:#6b7280;\">24時間365日の技術サポート、定期点検、システム最適化を提供します。</p></div></div>\n</div>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',1,0,0,150,0,'サービスフロー','サービスフロー,導入プ��セス','6ステップの標準サービスフロー。',1,0,1770899116,1770899116,0,1),(9,'ja',0,17,'article','製品の使い方について','','product-guide','',NULL,'新規ユーザー向けクイックスタートガイド','<h2>クイックスタート手順</h2>\n<ol>\n<li><strong>アカウント登録</strong>：公式サイトにアクセスし、登録ボタンからアカウントを作成します</li>\n<li><strong>プラン選択</strong>：ご利用目的に合ったプランをお選びください</li>\n<li><strong>初期設定</strong>：ガイドに沿って基本設定を行います</li>\n<li><strong>ご利用開始</strong>：ログイン後すぐにご利用いただけます</li>\n</ol>\n<p>ご不明な点がございましたら、<a href=\"/contact.html\">お問い合わせページ</a>よりお気軽にご連絡ください。</p>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',0,0,0,204,0,'','','',1,0,1770899116,1770899116,0,1),(13,'ja',0,20,'article','お問い合わせ','','contact','',NULL,NULL,'<p>お気軽にお問い合わせください。</p>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',0,0,0,0,0,'','','',1,0,0,1770899116,1770899116,0),(14,'ja',0,29,'article','プライバシーポリシー','','privacy','',NULL,'個人情報の取り扱いについて','<h2>プライバシーポリシー</h2>\n<p>当社（以下「当社」）は、お客様の個人情報の重要性を認識し、個人情報の保護に関する法律（個人情報保護法）を遵守するとともに、以下のプライバシーポリシーに従い、適切な取り扱い及び保護に努めます。</p>\n\n<h3>1. 個人情報の収集</h3>\n<p>当社は、以下の場合に個人情報を収集することがあります。</p>\n<ul>\n<li><strong>お問い合わせフォーム</strong>：お名前、メールアドレス、電話番号、会社名など</li>\n<li><strong>アクセスログ</strong>：IPアドレス、ブラウザの種類、アクセス日時、閲覧ページなど</li>\n<li><strong>Cookie</strong>：ユーザー体験の向上およびサイト機能の改善のために使用します</li>\n</ul>\n\n<h3>2. 個人情報の利用目的</h3>\n<p>収集した個人情報は、以下の目的で利用いたします。</p>\n<ul>\n<li>サービスの提供、維持、改善</li>\n<li>お問い合わせやご依頼への対応</li>\n<li>サービスに関するご連絡・ご案内</li>\n<li>不正行為の防止</li>\n</ul>\n\n<h3>3. 個人情報の管理</h3>\n<p>当社は、個人情報の正確性を保ち、不正アクセス、漏洩、改ざん、紛失を防止するため、適切な技術的・組織的措置を講じます。</p>\n\n<h3>4. 第三者への提供</h3>\n<p>当社は、以下の場合を除き、お客様の個人情報を第三者に提供することはありません。</p>\n<ul>\n<li>お客様の同意がある場合</li>\n<li>法令に基づく場合</li>\n<li>当社の権利・利益を保護するために必要な場合</li>\n</ul>\n\n<h3>5. Cookieの使用について</h3>\n<p>当サイトでは、ユーザー体験の向上のためCookieを使用しています。ブラウザの設定によりCookieの受け入れを拒否することが可能ですが、一部の機能が正常に動作しなくなる場合があります。</p>\n\n<h3>6. プライバシーポリシーの変更</h3>\n<p>当社は、必要に応じて本ポリシーを変更することがあります。変更後のポリシーは当ページに掲載いたします。定期的にご確認いただくことをお勧めいたします。</p>\n\n<h3>7. お問い合わせ</h3>\n<p>本プライバシーポリシーに関するご質問は、<a href=\"/contact.html\">お問い合わせページ</a>よりご連絡ください。</p>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',0,0,0,0,0,'','','',1,0,1770899116,1770899116,0,1),(15,'ja',0,30,'article','利用規約','','terms','',NULL,'ウェブサイトのご利用条件','<h2>利用規約</h2>\n<p>本ウェブサイト（以下「当サイト」）をご利用いただく前に、以下の利用規約をよくお読みください。当サイトをご利用になることにより、本規約に同意したものとみなされます。</p>\n\n<h3>1. サービスについて</h3>\n<p>当サイトで提供する情報およびサービスは参考目的であり、予告なく変更、中断、終了する場合があります。</p>\n\n<h3>2. 禁止事項</h3>\n<p>当サイトのご利用にあたり、以下の行為を禁止します。</p>\n<ul>\n<li>法令に違反する行為</li>\n<li>ウイルスや悪意のあるコードを含むコンテンツの送信</li>\n<li>他者の知的財産権その他の権利を侵害する行為</li>\n<li>当サイトの正常な運営を妨害する行為</li>\n</ul>\n\n<h3>3. 知的財産権</h3>\n<p>当サイトに掲載されているすべてのコンテンツ（テキスト、画像、動画、ソフトウェア、デザインを含む）は、著作権法およびその他の知的財産権法により保護されています。当社の書面による許可なく、複製、転載、改変、商用利用することはできません。</p>\n\n<h3>4. 免責事項</h3>\n<ul>\n<li>当サイトの情報は一般的な参考情報であり、いかなる助言や保証を構成するものではありません。</li>\n<li>当サイトの情報の正確性、完全性、最新性について保証するものではありません。</li>\n<li>当サイトの利用に起因するいかなる直接的または間接的な損害についても、当社は責任を負いません。</li>\n<li>当サイトには第三者のウェブサイトへのリンクが含まれる場合がありますが、当社はそれらのサイトの内容について一切の責任を負いません。</li>\n</ul>\n\n<h3>5. アカウント管理</h3>\n<p>当サイトでアカウントを登録された場合、アカウント情報およびパスワードの管理はお客様の責任となります。アカウント情報の漏洩による損害について、当社は責任を負いかねます。</p>\n\n<h3>6. プライバシー</h3>\n<p>個人情報の取り扱いについては、<a href=\"/privacy.html\">プライバシーポリシー</a>をご参照ください。</p>\n\n<h3>7. 規約の変更</h3>\n<p>当社は、本利用規約を随時変更する権利を有します。変更後の規約は当ページに掲載され、当サイトを継続してご利用になることにより、変更後の規約に同意したものとみなされます。</p>\n\n<h3>8. 準拠法</h3>\n<p>本利用規約は日本法に準拠するものとし、本規約に関する紛争については、東京地方裁判所を第一審の専属的合意管轄裁判所とします。</p>\n\n<h3>9. お問い合わせ</h3>\n<p>本利用規約に関するご質問は、<a href=\"/contact.html\">お問い合わせページ</a>よりご連絡ください。</p>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',0,0,0,0,0,'','','',1,0,1770899116,1770899116,0,1),(16,'ja',0,4,'article','沿革','','history','',NULL,'会社の歩み','<p>当社の設立から現在までの歩みをご紹介します。</p>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',0,0,0,0,0,'','','',1,0,1775432984,1775432984,1775432984,1),(17,'ja',0,5,'article','アクセス','','access','',NULL,'所在地・交通案内','<h2>本社</h2>\n<p>〒150-0000<br>東京都渋谷区XX町X丁目X-X XXビル 5F</p>\n\n<h3>電車でお越しの方</h3>\n<ul>\n<li>JR山手線「渋谷駅」南口より徒歩5分</li>\n<li>東京メトロ銀座線「渋谷駅」出口3より徒歩3分</li>\n</ul>\n\n<h3>お車でお越しの方</h3>\n<p>首都高速3号渋谷線「渋谷IC」より約5分<br>※ビル地下に有料駐車場がございます</p>\n\n<h2>大阪支社</h2>\n<p>〒530-0000<br>大阪府大阪市北区XX町X丁目X-X XXビル 3F</p>\n\n<h3>電車でお越しの方</h3>\n<ul>\n<li>JR大阪環状線「大阪駅」より徒歩8分</li>\n<li>大阪メトロ御堂筋線「梅田駅」より徒歩5分</li>\n</ul>\n\n<h2>お問い合わせ</h2>\n<table style=\"width:100%;border-collapse:collapse\">\n<tr><td style=\"padding:8px 0;width:120px\"><strong>電話番号</strong></td><td style=\"padding:8px 0\">03-0000-0000</td></tr>\n<tr><td style=\"padding:8px 0\"><strong>FAX</strong></td><td style=\"padding:8px 0\">03-0000-0001</td></tr>\n<tr><td style=\"padding:8px 0\"><strong>メール</strong></td><td style=\"padding:8px 0\">info@example.co.jp</td></tr>\n<tr><td style=\"padding:8px 0\"><strong>営業時間</strong></td><td style=\"padding:8px 0\">平日 9:00〜18:00（土日祝休み）</td></tr>\n</table>','html',NULL,'','','','',0,0.00,NULL,'','',NULL,'','','','','','','','',0,0,0,0,0,'','','',1,0,1775432984,1775432984,1775432984,1);
/*!40000 ALTER TABLE `yikai_contents` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_download_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_download_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '分类描述',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='下载分类';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_download_categories` DISABLE KEYS */;
INSERT INTO `yikai_download_categories` VALUES (1,'产品手册','产品使用手册和说明文档',1,1,1770899116),(2,'软件下载','软件安装包和工具',2,1,1770899116),(3,'技术文档','技术规范和开发文档',3,1,1770899116);
/*!40000 ALTER TABLE `yikai_download_categories` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_downloads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_downloads` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT '0' COMMENT '分类ID',
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL COMMENT '文件名称',
  `description` text COMMENT '文件描述',
  `cover` varchar(500) DEFAULT '' COMMENT '封面图',
  `file_url` varchar(500) DEFAULT '' COMMENT '文件地址(上传或外链)',
  `file_name` varchar(255) DEFAULT '' COMMENT '原始文件名',
  `file_size` bigint(20) unsigned DEFAULT '0' COMMENT '文件大小(字节)',
  `file_ext` varchar(20) DEFAULT '' COMMENT '文件扩展名',
  `download_count` int(10) unsigned DEFAULT '0' COMMENT '下载次数',
  `is_external` tinyint(1) DEFAULT '0' COMMENT '是否外链：0本地 1外链',
  `require_login` tinyint(1) NOT NULL DEFAULT '0' COMMENT '下载条件：0游客 1需登录',
  `sort_order` int(11) DEFAULT '0' COMMENT '排序(越大越靠前)',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1显示 0隐藏',
  `created_at` int(10) unsigned DEFAULT '0',
  `updated_at` int(10) unsigned DEFAULT '0',
  `admin_id` int(10) unsigned DEFAULT '0' COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort_order` DESC,`id` DESC),
  KEY `idx_dl_lang` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='下载管理';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_downloads` DISABLE KEYS */;
INSERT INTO `yikai_downloads` VALUES (1,1,'ja',0,'製品マニュアル V2.0','最新版の製品マニュアルです。設定方法やFAQを含みます。','','','',0,'pdf',128,0,0,100,1,1770899116,0,0),(2,2,'ja',0,'クライアントソフト V3.5.1','Windows用クライアントソフトウェアのインストーラーです。','','','',0,'zip',256,0,0,90,1,1770899116,0,0),(3,3,'ja',0,'API仕様書','開発者向けAPI仕様書の完全版です。','','','',0,'pdf',89,0,0,80,1,1770899116,0,0);
/*!40000 ALTER TABLE `yikai_downloads` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_extfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_extfields` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner_type` varchar(30) NOT NULL,
  `field_key` varchar(64) NOT NULL,
  `field_name` varchar(100) NOT NULL,
  `field_type` varchar(20) NOT NULL DEFAULT 'text',
  `options` text,
  `placeholder` varchar(255) NOT NULL DEFAULT '',
  `help_text` varchar(255) NOT NULL DEFAULT '',
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_owner_key` (`owner_type`,`field_key`),
  KEY `idx_owner` (`owner_type`,`status`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='拡張フィールド定義';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_extfields` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_extfields` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_form_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_form_templates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '表单名称',
  `slug` varchar(50) NOT NULL COMMENT '短码标识',
  `fields` text COMMENT '字段配置JSON',
  `success_message` varchar(255) NOT NULL DEFAULT '提交成功，感谢您的反馈！' COMMENT '成功提示',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='表单模板';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_form_templates` DISABLE KEYS */;
INSERT INTO `yikai_form_templates` VALUES (1,'联系表单','contact','[{\"key\":\"company\",\"label\":\"会社名\",\"type\":\"text\",\"required\":false,\"placeholder\":\"例：株式会社○○\"},{\"key\":\"name\",\"label\":\"お名前\",\"type\":\"text\",\"required\":true,\"placeholder\":\"例：田中 太郎\"},{\"key\":\"phone\",\"label\":\"電話番号\",\"type\":\"tel\",\"required\":false,\"placeholder\":\"例：03-0000-0000\"},{\"key\":\"email\",\"label\":\"メールアドレス\",\"type\":\"email\",\"required\":true,\"placeholder\":\"例：info@example.co.jp\"},{\"key\":\"content\",\"label\":\"お問い合わせ内容\",\"type\":\"textarea\",\"required\":true,\"placeholder\":\"ご質問やご要望をご記入ください\"}]','送信が完了しました。担当者よりご連絡いたします。',1,1775345336),(2,'产品询盘','product-inquiry','[{\"key\":\"name\",\"label\":\"您的姓名\",\"type\":\"text\",\"required\":true,\"placeholder\":\"请输入姓名\"},{\"key\":\"phone\",\"label\":\"联系电话\",\"type\":\"tel\",\"required\":true,\"placeholder\":\"请输入电话\"},{\"key\":\"email\",\"label\":\"邮箱地址\",\"type\":\"email\",\"required\":false,\"placeholder\":\"请输入邮箱\"},{\"key\":\"company\",\"label\":\"公司名称\",\"type\":\"text\",\"required\":false,\"placeholder\":\"请输入公司名称\"},{\"key\":\"content\",\"label\":\"请描述您的需求\",\"type\":\"textarea\",\"required\":true,\"placeholder\":\"请描述您的需求\"}]','询盘已提交，我们将尽快与您联系！',1,1775345336);
/*!40000 ALTER TABLE `yikai_form_templates` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_forms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL DEFAULT 'contact' COMMENT '类型：contact/apply/custom',
  `product_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '关联产品ID',
  `product_title` varchar(255) NOT NULL DEFAULT '' COMMENT '产品名称快照',
  `source` varchar(30) NOT NULL DEFAULT 'contact' COMMENT '来源: contact/product/custom',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '电话',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱',
  `company` varchar(100) NOT NULL DEFAULT '' COMMENT '公司',
  `content` text COMMENT '内容',
  `extra` text COMMENT '额外字段JSON',
  `ip` varchar(45) NOT NULL DEFAULT '',
  `user_agent` varchar(500) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态：0新询盘 1已联系 2跟进中 3成交 4失败',
  `follow_admin` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '跟进人',
  `follow_note` text COMMENT '跟进备注',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_type` (`type`),
  KEY `idx_product` (`product_id`),
  KEY `idx_source` (`source`),
  KEY `idx_status` (`status`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='询盘数据';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_forms` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_jobs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '职位名称',
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `cover` varchar(255) NOT NULL DEFAULT '' COMMENT '封面图',
  `summary` text COMMENT '职位摘要',
  `content` longtext COMMENT '职位详情',
  `location` varchar(100) NOT NULL DEFAULT '' COMMENT '工作地点',
  `salary` varchar(50) NOT NULL DEFAULT '' COMMENT '薪资范围',
  `job_type` varchar(20) NOT NULL DEFAULT '' COMMENT '工作性质',
  `education` varchar(50) NOT NULL DEFAULT '' COMMENT '学历要求',
  `experience` varchar(50) NOT NULL DEFAULT '' COMMENT '经验要求',
  `headcount` varchar(20) NOT NULL DEFAULT '' COMMENT '招聘人数',
  `requirements` text COMMENT '任职要求',
  `views` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `is_top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1招聘中 0已关闭',
  `publish_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建人',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_top` (`is_top` DESC,`sort_order` DESC,`id` DESC),
  KEY `idx_job_lang` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='招聘管理';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_jobs` DISABLE KEYS */;
INSERT INTO `yikai_jobs` VALUES (1,'PHPシニアエンジニア','ja',0,'','自社プロダクトのバックエンド設計・開発を担当','<p>自社CMS・クラウドサービスのバックエンド設計・開発を担当していただきます。</p>','東京（リモート可）','年収500万〜800万円','正社員','大卒以上','3〜5年','2名','<h3>業務内容</h3>\n<ul>\n<li>自社CMS・クラウドサービスのバックエンド開発</li>\n<li>APIの設計・実装・最適化</li>\n<li>データベース設計・パフォーマンスチューニング</li>\n<li>コードレビュー・技術ドキュメント作成</li>\n</ul>\n\n<h3>応募条件</h3>\n<ul>\n<li>PHPでの開発経験3年以上</li>\n<li>MySQL / PostgreSQLの実務経験</li>\n<li>Gitを用いたチーム開発経験</li>\n<li>REST APIの設計・開発経験</li>\n</ul>\n\n<h3>歓迎スキル</h3>\n<ul>\n<li>Laravel / Symfony等フレームワークの経験</li>\n<li>Docker / Kubernetesの経験</li>\n<li>AWS / GCP等クラウドインフラの経験</li>\n</ul>\n\n<h3>待遇・福利厚生</h3>\n<ul>\n<li>各種社会保険完備</li>\n<li>通勤手当支給</li>\n<li>リモートワーク制度あり</li>\n<li>年間休日120日以上</li>\n<li>書籍購入補助・カンファレンス参加支援</li>\n</ul>',15,1,100,1,1770899116,1770899116,0,1),(2,'フロントエンドエンジニア','ja',0,'','自社プロダクトのフロントエンド開発・UI改善を担当','<p>自社プロダクトのフロントエンド開発・UI改善を担当していただきます。</p>','東京（リモート可）','年収400万〜650万円','正社員','大卒以上','1〜3年','1名','<h3>業務内容</h3>\n<ul>\n<li>Webアプリケーションのフロントエンド開発</li>\n<li>UI/UXの改善提案・実装</li>\n<li>レスポンシブデザインの実装</li>\n<li>パフォーマンス最適化</li>\n</ul>\n\n<h3>応募条件</h3>\n<ul>\n<li>HTML / CSS / JavaScriptの実務経験2年以上</li>\n<li>React / Vue.jsいずれかの経験</li>\n<li>Tailwind CSSまたは類似のCSSフレームワーク経験</li>\n</ul>\n\n<h3>歓迎スキル</h3>\n<ul>\n<li>TypeScriptの経験</li>\n<li>Figma等デザインツールの使用経験</li>\n<li>アクセシビリティ（a11y）への理解</li>\n</ul>\n\n<h3>待遇・福利厚生</h3>\n<ul>\n<li>各種社会保険完備</li>\n<li>通勤手当支給</li>\n<li>リモートワーク制度あり</li>\n<li>年間休日120日以上</li>\n<li>書籍購入補助・カンファレンス参加支援</li>\n</ul>',0,0,90,1,1770899116,1770899116,0,1);
/*!40000 ALTER TABLE `yikai_jobs` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_links` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `url` varchar(255) NOT NULL COMMENT '链接',
  `logo` varchar(255) NOT NULL DEFAULT '' COMMENT 'Logo',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort_order`),
  KEY `idx_lk_lang` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='合作伙伴';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_links` DISABLE KEYS */;
INSERT INTO `yikai_links` VALUES (1,'ja','易开网-域名注册','https://www.yikai.cn','','百度搜索引擎',1,1,1770899116);
/*!40000 ALTER TABLE `yikai_links` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_media` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '文件名',
  `path` varchar(255) NOT NULL COMMENT '存储路径',
  `url` varchar(255) NOT NULL COMMENT '访问URL',
  `type` varchar(20) NOT NULL DEFAULT 'image' COMMENT '类型：image/file/video',
  `ext` varchar(20) NOT NULL DEFAULT '' COMMENT '扩展名',
  `mime` varchar(100) NOT NULL DEFAULT '' COMMENT 'MIME类型',
  `size` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `width` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '图片宽度',
  `height` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '图片高度',
  `md5` varchar(32) NOT NULL DEFAULT '' COMMENT 'MD5',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_type` (`type`),
  KEY `idx_admin` (`admin_id`),
  KEY `idx_md5` (`md5`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='媒体库';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_media` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_media` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_members` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL DEFAULT '',
  `nickname` varchar(50) NOT NULL DEFAULT '',
  `avatar` varchar(255) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `last_login_time` int(11) unsigned NOT NULL DEFAULT '0',
  `last_login_ip` varchar(45) NOT NULL DEFAULT '',
  `login_count` int(11) unsigned NOT NULL DEFAULT '0',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  UNIQUE KEY `uk_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='前台会员表';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_members` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_metas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_metas` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `owner_type` varchar(30) NOT NULL,
  `owner_id` int(11) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(100) NOT NULL,
  `meta_value` longtext,
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_owner_key` (`owner_type`,`owner_id`,`meta_key`),
  KEY `idx_owner` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='メタデータ';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_metas` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_metas` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_plugins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) NOT NULL COMMENT '插件标识',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态：0禁用 1启用',
  `installed_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `activated_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '启用时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='插件表';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_plugins` DISABLE KEYS */;
INSERT INTO `yikai_plugins` VALUES (1,'search-replace',1,1770899116,1770899116),(3,'db-backup',1,1770899116,1770899116),(4,'back-to-top',1,1770899116,1770899116),(5,'translate',1,1775446827,1775446827);
/*!40000 ALTER TABLE `yikai_plugins` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_product_categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '父分类ID',
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `slug` varchar(100) NOT NULL DEFAULT '' COMMENT 'URL别名',
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `image` varchar(255) NOT NULL DEFAULT '' COMMENT '分类图片',
  `description` text COMMENT '分类描述',
  `seo_title` varchar(255) NOT NULL DEFAULT '',
  `seo_keywords` varchar(255) NOT NULL DEFAULT '',
  `seo_description` varchar(500) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `is_nav` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否导航显示',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_parent` (`parent_id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort_order`),
  KEY `idx_pc_lang` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='产品分类';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_product_categories` DISABLE KEYS */;
INSERT INTO `yikai_product_categories` VALUES (1,0,'スマートデバイス','smart-device','ja',0,'','スマートハードウェア製品シリーズ','','','',1,1,1,1770899116),(2,0,'ソフトウェアサービス','software','ja',0,'','企業向けソフトウェア・クラウドサービス','','','',1,1,2,1770899116),(3,1,'センサーモジュール','sensor-module','ja',0,'',NULL,'','','',1,1,1,1770899116),(4,1,'制御端末','control-terminal','ja',0,'',NULL,'','','',1,1,2,1770899116);
/*!40000 ALTER TABLE `yikai_product_categories` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_product_tag_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_product_tag_map` (
  `product_id` int(11) unsigned NOT NULL,
  `tag_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`product_id`,`tag_id`),
  KEY `idx_tag` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='产品标签关联';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_product_tag_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_product_tag_map` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_product_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_product_tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) NOT NULL COMMENT '标签组',
  `name` varchar(100) NOT NULL COMMENT '标签名',
  `slug` varchar(100) NOT NULL DEFAULT '',
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_group` (`group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='产品标签';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_product_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_product_tags` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_products` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `brand_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `title` varchar(255) NOT NULL COMMENT '产品名称',
  `subtitle` varchar(255) NOT NULL DEFAULT '' COMMENT '副标题',
  `slug` varchar(255) NOT NULL DEFAULT '' COMMENT 'URL别名',
  `cover` varchar(255) NOT NULL DEFAULT '' COMMENT '封面图',
  `images` text COMMENT '产品图片JSON',
  `summary` text COMMENT '简介',
  `content` longtext COMMENT '详情',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '价格',
  `market_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '型号',
  `specs` text COMMENT '规格参数JSON',
  `tags` varchar(255) NOT NULL DEFAULT '' COMMENT '标签',
  `product_type` varchar(20) NOT NULL DEFAULT 'custom' COMMENT '商品类型：standard标准制品 custom定制品',
  `material` varchar(50) NOT NULL DEFAULT '' COMMENT '素材：木材/アクリル/アルミ複合板/ステンレス 等',
  `scene` varchar(50) NOT NULL DEFAULT '' COMMENT '使用场景：オフィス/店舗/レストラン/カフェ/美容院/クリニック/住宅 等',
  `is_top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶',
  `is_recommend` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '热门',
  `is_new` tinyint(1) NOT NULL DEFAULT '0' COMMENT '新品',
  `views` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0下架 1上架',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_top` (`is_top`),
  KEY `idx_recommend` (`is_recommend`),
  KEY `idx_sort` (`sort_order`),
  KEY `idx_product_type` (`product_type`),
  KEY `idx_material` (`material`),
  KEY `idx_scene` (`scene`),
  KEY `idx_lang_status` (`lang`,`status`),
  KEY `idx_trans_group` (`translation_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='产品表';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_products` DISABLE KEYS */;
INSERT INTO `yikai_products` VALUES (1,'ja',0,1,0,'IoTスマートゲートウェイ','産業用高性能ゲートウェイ','iot-gateway','https://picsum.photos/800/600?random=10','https://picsum.photos/800/600?random=20\nhttps://picsum.photos/800/600?random=21\nhttps://picsum.photos/800/600?random=22\nhttps://picsum.photos/800/600?random=23','マルチプロトコル対応、エッジコンピューティング機能搭載','<h2>製品概要</h2><p>IoTスマートゲートウェイは、MQTT、HTTP、Modbus、OPC UAなど100種以上の通信プロトコルに対応した高性能エッジコンピューティングゲートウェイです。</p><h3>主な特長</h3><ul><li>Wi-Fi/4G/有線LANの複数接続方式に対応</li><li>内蔵エッジコンピューティングエンジン</li><li>100種以上の産業プロトコルに対応</li><li>産業用設計 −40°C〜85°C の広温度動作</li></ul><h3>適用分野</h3><p>スマートファクトリー、スマート農業、スマートシティ、エネルギー管理。</p>',2999.00,3599.00,'IOT-GW-100',NULL,'','custom','','',0,1,0,1,11,1,0,1770899116,1770899116,1),(2,'ja',0,2,0,'企業管理クラウド','ワンストップ企業DXソリューション','cloud-platform','https://picsum.photos/800/600?random=11',NULL,'ERP・CRM・OA機能を統合','<h2>製品概要</h2><p>ERP・CRM・OAの三大モジュールを統合したワンストップ企業管理クラウドプラットフォームです。</p><h3>機能モジュール</h3><ul><li><strong>ERP</strong> — 購買・在庫・生産・会計の一元管理</li><li><strong>CRM</strong> — 顧客管理・営業パイプライン・実績分析</li><li><strong>OA</strong> — ワークフロー・スケジュール管理・チャット</li></ul><h3>技術的優位性</h3><p>マイクロサービスアーキテクチャにより、オンプレミス・SaaSの両デプロイに対応。</p>',0.00,0.00,'EMS-CLOUD-V3',NULL,'','custom','','',0,1,0,1,8,1,0,1770899116,1770899116,1),(3,'ja',0,3,0,'温湿度センサー TH-200','高精度産業用温湿度センサー','th200-sensor','https://picsum.photos/800/600?random=12','https://picsum.photos/800/600?random=40\nhttps://picsum.photos/800/600?random=41','スイス製チップ搭載、精度±0.1°C。産業環境モニタリング、倉庫管理、スマート農業に最適。','<h2>製品概要</h2><p>スイス製高精度チップ搭載、精度±0.1°C / ±1.5%RHの温湿度センサーです。</p><h3>仕様</h3><ul><li>温度範囲：−40°C〜125°C</li><li>湿度範囲：0〜100%RH</li><li>通信：RS485 / Modbus RTU</li><li>電源：DC 12-24V</li><li>保護等級：IP65</li></ul>',0.00,0.00,'TH-200',NULL,'','custom','','',0,0,0,1,4,1,0,1770899116,1770899116,1),(4,'ja',0,3,0,'照度センサー LS-100','広範囲照度センサー','ls100-sensor','https://picsum.photos/800/600?random=13',NULL,'検出範囲0-200000Lux、RS485/Modbus通信対応。スマート農業・気象観測に幅広く活用。','<h2>製品概要</h2><p>測定範囲0〜200,000 Lux、高感度フォトダイオード採用の照度センサーです。</p><h3>仕様</h3><ul><li>測定範囲：0〜200,000 Lux</li><li>精度：±3%</li><li>通信：RS485 / Modbus</li><li>電源：DC 5-24V</li></ul><h3>適用分野</h3><p>スマート農業、気象観測、照明制御。</p>',0.00,0.00,'LS-100',NULL,'','custom','','',0,0,1,0,4,1,0,1770899116,1770899116,1),(5,'ja',0,4,0,'産業用エッジコントローラー EC-500','高性能エッジコンピューティング端末','ec500-controller','https://picsum.photos/800/600?random=14','https://picsum.photos/800/600?random=30\nhttps://picsum.photos/800/600?random=31\nhttps://picsum.photos/800/600?random=32','ARM Cortex-A72搭載、複数の産業プロトコルに対応、AIモデルのローカル推論に対応。','<h2>製品概要</h2><p>ARM Cortex-A72搭載、AIモデルのローカル推論に対応した産業用エッジコントローラーです。</p><h3>主な特長</h3><ul><li>4コア ARM Cortex-A72、1.8GHz</li><li>4GB RAM / 32GB eMMC</li><li>TensorFlow Lite / ONNX推論対応</li><li>豊富なI/O：4×RS485、2×CAN、4×DI、4×DO</li></ul>',0.00,0.00,'EC-500',NULL,'','custom','','',0,1,1,1,1,1,0,1770899116,1770899116,1),(6,'ja',0,4,0,'スマートゲートウェイコントローラー GC-300','マルチプロトコル統合ゲートウェイ','gc300-gateway','https://picsum.photos/800/600?random=15',NULL,'Wi-Fi/Zigbee/LoRa/4G同時対応、エッジコンピューティング内蔵、ワンストップデバイス管理。','<h2>製品概要</h2><p>Wi-Fi/Zigbee/LoRa/4Gの4プロトコル同時接続対応のスマートゲートウェイです。</p><h3>主な特長</h3><ul><li>4プロトコル同時接続、最大500台のデバイス管理</li><li>内蔵エッジコンピューティングエンジン</li><li>OTAリモートアップデート対応</li><li>Webベース管理画面、ノーコード設定</li></ul><h3>適用分野</h3><p>スマートビル、スマートホーム、産業IoT。</p>',0.00,0.00,'GC-300',NULL,'','custom','','',0,1,0,0,2,1,0,1770899116,1770899116,1);
/*!40000 ALTER TABLE `yikai_products` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '角色描述',
  `permissions` text COMMENT '权限JSON',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_roles` DISABLE KEYS */;
INSERT INTO `yikai_roles` VALUES (1,'超级管理员','拥有全部权限','[\"*\"]',1,1770899116),(2,'编辑','内容编辑权限','[\"content\",\"media\"]',1,1770899116),(3,'运营','运营管理权限','[\"content\",\"media\",\"form\",\"banner\",\"link\"]',1,1770899116);
/*!40000 ALTER TABLE `yikai_roles` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(50) NOT NULL DEFAULT 'basic' COMMENT '分组',
  `key` varchar(100) NOT NULL COMMENT '键名',
  `value` text COMMENT '值',
  `type` varchar(20) NOT NULL DEFAULT 'text' COMMENT '类型：text/textarea/number/select/image/editor',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '显示名称',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `options` text COMMENT '选项JSON',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_key` (`key`),
  KEY `idx_group` (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_settings` DISABLE KEYS */;
INSERT INTO `yikai_settings` VALUES (1,'basic','site_name','ikaiCMS','text','サイト名','',NULL,1),(2,'basic','site_keywords','企業サイト,CMS,コンテンツ管理','textarea','SEOキーワード','カンマ区切りで複数指定',NULL,2),(3,'basic','site_description','企業サイトの構築・運用に最適な軽量CMS','textarea','SEO説明文','',NULL,3),(4,'basic','site_logo','/images/logo.png','image','サイトロゴ','',NULL,4),(7,'basic','primary_color','#3B82F6','color','メインカラー','16進数カラーコード',NULL,6),(8,'basic','secondary_color','#1D4ED8','color','サブカラー','16進数カラーコード',NULL,7),(9,'contact','contact_phone','03-0000-0000','text','電話番号','',NULL,1),(10,'contact','contact_email','info@example.co.jp','text','メールアドレス','',NULL,2),(11,'contact','contact_address','東京都渋谷区XX町X丁目X-X','textarea','住所','',NULL,3),(12,'contact','contact_qrcode','','image','QRコード','',NULL,5),(13,'contact','contact_map','','image','地図画像','',NULL,6),(14,'banner','banner_height_pc','650','number','スライド高さ(PC)','ピクセル単位',NULL,9),(15,'banner','banner_height_mobile','300','number','スライド高さ(モバイル)','ピクセル単位',NULL,10),(16,'home','home_about_content','企業のデジタルトランスフォーメーションに特化したテクノロジー企業として、お客様に高品質な製品とサービスを提供しています。長年の実績を重ね、業界で影響力のある企業へと成長しました。','textarea','会社紹介文','トップページ「会社概要」セクションのテキスト',NULL,1),(17,'home','home_about_image','https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&q=80','image','会社紹介画像','トップページ「会社概要」セクションの画像',NULL,2),(18,'home','home_about_tag_title','プロフェッショナルサービス','text','バッジタイトル','画像左下のバッジタイトル',NULL,3),(19,'home','home_about_tag_desc','品質・革新・共創','text','バッジ説明','画像左下のバッジ説明文',NULL,4),(20,'home','home_stat_1_num','10+','text','統計数値1','',NULL,5),(21,'home','home_stat_1_text','業界実績','text','統計テキスト1','',NULL,6),(22,'home','home_stat_2_num','1000+','text','統計数値2','',NULL,7),(23,'home','home_stat_2_text','導入実績','text','統計テキスト2','',NULL,8),(24,'home','home_stat_3_num','50+','text','統計数値3','',NULL,9),(25,'home','home_stat_3_text','専門チーム','text','統計テキスト3','',NULL,10),(26,'home','home_stat_4_num','100%','text','統計数値4','',NULL,11),(27,'home','home_stat_4_text','顧客満足度','text','統計テキスト4','',NULL,12),(28,'home','home_advantage_desc','プロフェッショナルチームによる高品質サービス','text','強み説明','',NULL,13),(29,'home','home_adv_1_title','品質保証','text','強み1タイトル','',NULL,14),(30,'home','home_adv_1_desc','厳格な品質管理で、すべての製品が基準を満たすことを保証します','text','強み1説明','',NULL,15),(31,'home','home_adv_2_title','技術力','text','強み2タイトル','',NULL,16),(32,'home','home_adv_2_desc','継続的な研究開発で、技術の優位性を維持します','text','強み2説明','',NULL,17),(33,'home','home_adv_3_title','専門サポート','text','強み3タイトル','',NULL,18),(34,'home','home_adv_3_desc','専門チームによる24時間365日テクニカルサポート','text','強み3説明','',NULL,19),(35,'home','home_adv_4_title','共創共栄','text','強み4タイトル','',NULL,20),(36,'home','home_adv_4_desc','お客様との長期的なパートナーシップで、互いの成長を実現します','text','強み4説明','',NULL,21),(37,'home','home_cta_title','お取引を始めませんか？','text','CTAタイトル','アクション誘導セクションのタイトル',NULL,22),(38,'home','home_cta_desc','お気軽にご相談ください。最適なソリューションをご提案します','text','CTA説明','アクション誘導セクションの説明',NULL,23),(39,'email','smtp_host','','text','SMTPサーバー','例: smtp.gmail.com',NULL,1),(40,'email','smtp_port','465','text','SMTPポート','SSL:465、TLS:587',NULL,2),(41,'email','smtp_secure','ssl','text','暗号化方式','ssl/tls/空',NULL,3),(42,'email','smtp_user','','text','SMTPユーザー名','メールアドレス',NULL,4),(43,'email','smtp_pass','','text','SMTPパスワード','',NULL,5),(44,'email','mail_from','','text','送信元メール','空欄ならSMTPユーザー名を使用',NULL,6),(45,'email','mail_from_name','','text','送信者名','空欄ならサイト名を使用',NULL,7),(46,'email','mail_admin','','text','管理者メール','フォーム通知の送信先',NULL,8),(47,'email','mail_notify_form','0','text','フォーム送信通知','1:有効/0:無効',NULL,9),(48,'product','product_layout','sidebar','select','製品リストレイアウト','','{\"sidebar\":\"侧栏模式\",\"top\":\"顶栏模式\"}',11),(49,'home','home_show_links','0','select','パートナー表示','フッターにパートナーロゴを表示',NULL,24),(50,'contact','contact_form_title','オンラインお問い合わせ','text','フォームタイトル','',NULL,10),(52,'contact','contact_cards','[{\"icon\":\"phone\",\"label\":\"電話番号\",\"value\":\"03-0000-0000\"},{\"icon\":\"email\",\"label\":\"メールアドレス\",\"value\":\"info@example.co.jp\"},{\"icon\":\"location\",\"label\":\"所在地\",\"value\":\"東京都渋谷区XX町X丁目X-X\"},{\"icon\":\"clock\",\"label\":\"営業時間\",\"value\":\"平日 9:00〜18:00（土日祝休み）\"}]','contact_cards','連絡先カード','お問い合わせページ上部の情報カード（最大4つ）',NULL,0),(53,'product','show_price','0','select','価格表示','フロントで製品価格を表示','{\"0\":\"不显示\",\"1\":\"显示\"}',12),(56,'system','cms_version','1.0.0','text','CMSバージョン','システムが自動管理、手動変更不可',NULL,0),(57,'header','topbar_enabled','0','select','トップバー表示','ロゴ上部の通知バーエリア','{\"0\":\"隐藏\",\"1\":\"显示\"}',0),(58,'header','topbar_bg_color','#f3f4f6','color','トップバー背景色','トップバーの背景色',NULL,1),(59,'header','topbar_left','','code','トップバー左側','HTMLコード対応（電話番号やお知らせなど）',NULL,2),(60,'header','header_nav_layout','right','select','ナビレイアウト','ロゴの右側またはロゴの下に配置','{\"right\":\"Logo右侧\",\"below\":\"Logo下方通栏\"}',10),(61,'header','header_sticky','0','select','ヘッダー固定','ナビバーをページ上部に固定','{\"1\":\"是\",\"0\":\"否\"}',11),(62,'header','header_bg_color','#ffffff','color','背景色','16進数カラーコード',NULL,12),(63,'header','header_text_color','#4b5563','color','文字色','16進数カラーコード',NULL,13),(64,'footer','footer_columns','[{\"title\":\"会社概要\",\"content\":\"{{site_description}}\",\"col_span\":2},{\"title\":\"お問い合わせ\",\"content\":\"{{contact_info}}\",\"col_span\":1},{\"title\":\"フォロー\",\"content\":\"{{qrcode}}\",\"col_span\":1}]','footer_columns','フッターカラム','各列コンテンツ（最大4列）',NULL,1),(65,'footer','footer_bg_color','#1f2937','color','背景色','16進数カラーコード',NULL,2),(66,'footer','footer_bg_image','','image','背景画像','設定すると背景色の代わりに表示',NULL,3),(67,'footer','footer_text_color','#9ca3af','color','文字色','16進数カラーコード',NULL,4),(68,'basic','site_url','http://ikai.cms','text','サイトURL','例: https://www.example.com（末尾スラッシュなし）',NULL,0),(69,'code','custom_head_code','','code','Headコード','</head>直前に挿入（認証、SEOメタタグなど）',NULL,1),(70,'code','custom_body_code','','code','Bodyコード','</body>直前に挿入（解析コード、チャットなど）',NULL,2),(71,'basic','site_favicon','/favicon.ico','image','ファビコン','ブラウザタブのアイコン（.ico/.png形式）',NULL,5),(72,'home','home_show_banner','1','select','スライドショー表示','トップページバナースライド',NULL,30),(73,'home','home_show_about','1','select','会社概要表示','トップページ会社概要セクション',NULL,31),(74,'home','home_show_stats','1','select','統計データ表示','トップページ統計データセクション',NULL,32),(75,'home','home_show_channels','1','select','カテゴリセクション表示','製品・ニュースなどのトップページ表示',NULL,33),(76,'home','home_show_advantage','1','select','強みセクション表示','トップページ「私たちの強み」セクション',NULL,34),(77,'home','home_show_cta','1','select','CTA表示','トップページ下部のCTAセクション',NULL,35),(78,'home','home_blocks_config','[{\"type\":\"banner\",\"enabled\":true},{\"type\":\"about\",\"enabled\":true},{\"type\":\"stats\",\"enabled\":true},{\"type\":\"channels\",\"enabled\":true},{\"type\":\"testimonials\",\"enabled\":true},{\"type\":\"advantage\",\"enabled\":true},{\"type\":\"cta\",\"enabled\":true}]','home_blocks','トップページブロック設定','トップページブロックの順序と表示設定',NULL,40),(79,'home','home_testimonials','[{\"avatar\":\"\",\"name\":\"田中様\",\"company\":\"某テクノロジー株式会社\",\"content\":\"非常にプロフェッショナルなチームで、素晴らしい協力関係を築けました。製品の品質にも大変満足しています。\"},{\"avatar\":\"\",\"name\":\"佐藤様\",\"company\":\"某貿易株式会社\",\"content\":\"製品の品質が優れており、アフターサポートも迅速です。信頼できるパートナーです。\"},{\"avatar\":\"\",\"name\":\"鈴木様\",\"company\":\"某グループ会社\",\"content\":\"長年にわたる協力関係の中で、常に高品質なサービスを提供していただいています。強くお勧めします。\"}]','home_testimonials','お客様の声','トップページお客様の声セクション',NULL,26),(80,'home','home_testimonials_title','お客様の声','text','お客様の声タイトル','',NULL,27),(81,'home','home_testimonials_desc','パートナー企業様からのご評価','text','お客様の声説明','',NULL,28),(82,'home','home_stat_bg','','image','統計背景画像','データ統計セクションの背景画像',NULL,12),(83,'home','home_about_layout','text_left','select','レイアウト','テキスト左/画像左','{\"text_left\":\"左文右图\",\"image_left\":\"左图右文\"}',6),(84,'home','home_adv_1_icon','check-circle','icon','強み1アイコン','',NULL,14),(85,'home','home_adv_2_icon','academic-cap','icon','強み2アイコン','',NULL,16),(86,'home','home_adv_3_icon','briefcase','icon','強み3アイコン','',NULL,18),(87,'home','home_adv_4_icon','users','icon','強み4アイコン','',NULL,20),(88,'header','show_member_entry','0','select','会員メニュー表示','ナビバーにログイン/登録リンクを表示','{\"0\":\"隐藏\",\"1\":\"显示\"}',3),(89,'member','allow_member_register','0','switch','会員登録許可','フロントでの会員登録を許可',NULL,1),(90,'member','download_require_login','0','switch','ダウンロードにログイン必要','ファイルダウンロードに会員ログインが必要',NULL,2),(91,'home','home_links_title','パートナー','text','リンクセクションタイトル','',NULL,25),(93,'footer','footer_nav','[{\"title\":\"\",\"links\":[{\"name\":\"プライバシーポリシー\",\"url\":\"/privacy.html\"},{\"name\":\"利用規約\",\"url\":\"/terms.html\"}]}]','footer_nav','フッターナビ','著作権バー上のナビリンクグループ',NULL,5),(95,'translate','translate_api','deepl','select','翻訳API','翻訳サービスプロバイダーを選択','{\"deepl\":\"DeepL\",\"google\":\"Google Translate\"}',1),(96,'translate','translate_api_key','','text','APIキー','DeepL: 無料キーを登録して取得',NULL,2),(100,'email','mail_tpl_register_subject','欢迎注册 — {{site_name}}','textarea','mail_tpl_register_subject','',NULL,20),(101,'email','mail_tpl_register_body','{{username}}，您好！\\n\\n欢迎注册 {{site_name}}！您的帐号已创建成功。\\n\\n请登录会员中心管理您的帐号：\\n{{site_url}}/member/\\n\\n如有任何问题，请随时联系我们。\\n\\n{{site_name}}\\n{{date}}','textarea','mail_tpl_register_body','',NULL,21),(102,'email','mail_tpl_forgot_subject','密码找回 — {{site_name}}','textarea','mail_tpl_forgot_subject','',NULL,22),(103,'email','mail_tpl_forgot_body','{{username}}，您好！\\n\\n您正在进行密码找回操作，请点击以下链接重置密码：\\n{{reset_link}}\\n\\n链接有效期为 30 分钟，如非本人操作请忽略此邮件。\\n\\n{{site_name}}\\n{{date}}','textarea','mail_tpl_forgot_body','',NULL,23),(104,'email','mail_tpl_reset_subject','密码已重置 — {{site_name}}','textarea','mail_tpl_reset_subject','',NULL,24),(105,'email','mail_tpl_reset_body','{{username}}，您好！\\n\\n您的密码已成功重置。如非本人操作，请立即联系我们修改密码。\\n\\n{{site_name}}\\n{{date}}','textarea','mail_tpl_reset_body','',NULL,25),(106,'email','mail_tpl_inquiry_subject','新询盘通知：{{product_title}} — {{site_name}}','textarea','mail_tpl_inquiry_subject','',NULL,26),(107,'email','mail_tpl_inquiry_body','您收到一条新的产品询盘：\\n\\n产品：{{product_title}}\\n姓名：{{name}}\\n电话：{{phone}}\\n邮箱：{{email}}\\n公司：{{company}}\\n内容：{{content}}\\n\\n时间：{{date}}\\nIP：{{ip}}\\n\\n后台查看：{{site_url}}/admin/form.php','textarea','mail_tpl_inquiry_body','',NULL,27),(110,'contact','contact_form_desc','','textarea','フォーム説明','タイトル下に表示する説明文',NULL,11),(111,'contact','contact_form_fields','[{\"key\":\"company\",\"label\":\"会社名\",\"type\":\"text\",\"required\":false,\"enabled\":true},{\"key\":\"name\",\"label\":\"お名前\",\"type\":\"text\",\"required\":true,\"enabled\":true},{\"key\":\"phone\",\"label\":\"電話番号\",\"type\":\"tel\",\"required\":false,\"enabled\":true},{\"key\":\"email\",\"label\":\"メールアドレス\",\"type\":\"email\",\"required\":true,\"enabled\":true},{\"key\":\"content\",\"label\":\"お問い合わせ内容\",\"type\":\"textarea\",\"required\":true,\"enabled\":true}]','contact_form_fields','フォームフィールド','フォームに表示するフィールドの設定',NULL,12),(112,'contact','contact_form_success','送信が完了しました。担当者よりご連絡いたします。','text','送信完了メッセージ','フォーム送信後に表示するメッセージ',NULL,13),(113,'contact','contact_hours','平日 9:00〜18:00（土日祝休み）','text','営業時間','例：平日 9:00〜18:00',NULL,4),(114,'social','social_links','[]','social_links','SNSリンク','フッター等に表示するSNSアイコンリンク',NULL,1),(115,'basic','current_theme','default','text','','',NULL,17),(118,'system','admin_lang','ja','select','','',NULL,14),(119,'basic','site_lang','ja','select','フロント言語','フロント画面の表示言語','{\"zh-CN\":\"中文\",\"ja\":\"日本語\"}',13),(121,'basic','admin_title','ikaiCMS','text','管理画面名称','管理画面左上に表示される名称',NULL,15),(122,'basic','admin_copyright','Powered by ikaiCMS | イーカイ株式会社','text','','',NULL,16),(123,'header','nav_home_text','ホーム','text','ナビ「ホーム」テキスト','空欄の場合は言語パックのデフォルト値を使用',NULL,0),(124,'footer','footer_copyright_text','© {year} {site_name} All Rights Reserved.','text','著作権テキスト','{year}=年、{site_name}=サイト名に自動置換',NULL,6),(125,'basic','admin_logo','','image','管理画面ロゴ','空欄の場合テキスト表示',NULL,21);
/*!40000 ALTER TABLE `yikai_settings` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_timelines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_timelines` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `lang` varchar(10) NOT NULL DEFAULT 'ja',
  `year` smallint(5) unsigned NOT NULL COMMENT '年份',
  `month` tinyint(3) unsigned DEFAULT '0' COMMENT '月份(0表示仅显示年)',
  `day` tinyint(3) unsigned DEFAULT '0' COMMENT '日期(0表示不显示)',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `content` text COMMENT '内容描述',
  `image` varchar(500) DEFAULT '' COMMENT '配图',
  `icon` varchar(50) DEFAULT '' COMMENT '图标(可选)',
  `color` varchar(20) DEFAULT '' COMMENT '颜色标记',
  `sort_order` int(11) DEFAULT '0' COMMENT '排序(越大越靠前)',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1显示 0隐藏',
  `created_at` int(10) unsigned DEFAULT '0',
  `updated_at` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_year` (`year`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort_order` DESC,`year` DESC,`month` DESC),
  KEY `idx_tl_lang` (`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='发展历程时间线';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_timelines` DISABLE KEYS */;
INSERT INTO `yikai_timelines` VALUES (1,'ja',2024,6,0,'ブランドリニューアル','コーポレートブランドを刷新。新ビジョンを発表。','','rocket','blue',100,1,1770899116,0),(2,'ja',2024,1,0,'受賞','「年間最優秀テクノロジー革新賞」を受賞。','','award','yellow',95,1,1770899116,0),(3,'ja',2023,8,0,'戦略提携','大手企業との戦略的パートナーシップを締結。','','handshake','green',90,1,1770899116,0),(4,'ja',2023,3,0,'新製品発表','次世代IoTゲートウェイ・クラウドプラットフォームを発表。','','box','purple',85,1,1770899116,0),(5,'ja',2022,10,0,'チーム拡充','社員数50名を突破。開発体制を強化。','','users','cyan',80,1,1770899116,0),(6,'ja',2022,5,0,'資金調達','シリーズAラウンドにて資金調達を完了。','','trending-up','red',75,1,1770899116,0),(7,'ja',2021,0,0,'事業拡大','大阪支社を開設。西日本エリアへの展開を本格化。','','map','indigo',70,1,1770899116,0),(8,'ja',2020,0,0,'会社設立','東京都渋谷区にて設立。IoTソリューション事業を開始。','','flag','primary',60,1,1770899116,0);
/*!40000 ALTER TABLE `yikai_timelines` ENABLE KEYS */;
DROP TABLE IF EXISTS `yikai_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yikai_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '昵称',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `role_id` int(11) unsigned NOT NULL DEFAULT '1' COMMENT '角色ID',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：0禁用 1启用',
  `last_login_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` varchar(45) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `login_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  KEY `idx_status` (`status`),
  KEY `idx_role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40000 ALTER TABLE `yikai_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `yikai_users` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

