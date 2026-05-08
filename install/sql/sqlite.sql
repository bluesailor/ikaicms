-- ============================================================
-- Yikai CMS - SQLite 数据库结构
-- PHP 8.0+, SQLite 3
-- ============================================================

PRAGMA foreign_keys = OFF;

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_users;
CREATE TABLE yikai_users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    nickname TEXT NOT NULL DEFAULT '',
    email TEXT NOT NULL DEFAULT '',
    avatar TEXT NOT NULL DEFAULT '',
    role_id INTEGER NOT NULL DEFAULT 1,
    status INTEGER NOT NULL DEFAULT 1,
    last_login_time INTEGER NOT NULL DEFAULT 0,
    last_login_ip TEXT NOT NULL DEFAULT '',
    login_count INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_users_status ON yikai_users(status);
CREATE INDEX idx_users_role ON yikai_users(role_id);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_roles;
CREATE TABLE yikai_roles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    permissions TEXT,
    status INTEGER NOT NULL DEFAULT 1,
    created_at INTEGER NOT NULL DEFAULT 0
);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_channels;
CREATE TABLE yikai_channels (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    parent_id INTEGER NOT NULL DEFAULT 0,
    name TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    lang TEXT NOT NULL DEFAULT 'ja',
    translation_group_id INTEGER NOT NULL DEFAULT 0,
    type TEXT NOT NULL DEFAULT 'list',
    album_id INTEGER NOT NULL DEFAULT 0,
    icon TEXT NOT NULL DEFAULT '',
    image TEXT NOT NULL DEFAULT '',
    description TEXT,
    content TEXT,
    redirect_type TEXT NOT NULL DEFAULT 'auto',
    redirect_url TEXT NOT NULL DEFAULT '',
    link_url TEXT NOT NULL DEFAULT '',
    link_target TEXT NOT NULL DEFAULT '_self',
    seo_title TEXT NOT NULL DEFAULT '',
    seo_keywords TEXT NOT NULL DEFAULT '',
    seo_description TEXT NOT NULL DEFAULT '',
    is_nav INTEGER NOT NULL DEFAULT 1,
    is_home INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    is_system INTEGER NOT NULL DEFAULT 0,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_channels_parent ON yikai_channels(parent_id);
CREATE INDEX idx_channels_type ON yikai_channels(type);
CREATE INDEX idx_channels_status ON yikai_channels(status);
CREATE INDEX idx_channels_sort ON yikai_channels(sort_order);
CREATE INDEX idx_channels_lang ON yikai_channels(lang);

-- -----------------------------------------------------------
-- 内容表（通用）
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_contents;
CREATE TABLE yikai_contents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    channel_id INTEGER NOT NULL DEFAULT 0,
    lang TEXT NOT NULL DEFAULT 'ja',
    translation_group_id INTEGER NOT NULL DEFAULT 0,
    type TEXT NOT NULL DEFAULT 'article',
    title TEXT NOT NULL,
    subtitle TEXT NOT NULL DEFAULT '',
    slug TEXT NOT NULL DEFAULT '',
    cover TEXT NOT NULL DEFAULT '',
    images TEXT,
    summary TEXT,
    content TEXT,
    content_type TEXT NOT NULL DEFAULT 'html',
    blocks_data TEXT,
    author TEXT NOT NULL DEFAULT '',
    source TEXT NOT NULL DEFAULT '',
    tags TEXT NOT NULL DEFAULT '',
    attachment TEXT NOT NULL DEFAULT '',
    download_count INTEGER NOT NULL DEFAULT 0,
    price REAL NOT NULL DEFAULT 0,
    specs TEXT,
    -- 案例特有
    client_name TEXT NOT NULL DEFAULT '',
    industry TEXT NOT NULL DEFAULT '',
    duration TEXT NOT NULL DEFAULT '',
    result_metric TEXT NOT NULL DEFAULT '',
    -- 招聘特有
    location TEXT NOT NULL DEFAULT '',
    salary TEXT NOT NULL DEFAULT '',
    requirements TEXT,
    headcount TEXT NOT NULL DEFAULT '',
    job_type TEXT NOT NULL DEFAULT '',
    education TEXT NOT NULL DEFAULT '',
    experience TEXT NOT NULL DEFAULT '',
    is_top INTEGER NOT NULL DEFAULT 0,
    is_recommend INTEGER NOT NULL DEFAULT 0,
    is_hot INTEGER NOT NULL DEFAULT 0,
    views INTEGER NOT NULL DEFAULT 0,
    likes INTEGER NOT NULL DEFAULT 0,
    seo_title TEXT NOT NULL DEFAULT '',
    seo_keywords TEXT NOT NULL DEFAULT '',
    seo_description TEXT NOT NULL DEFAULT '',
    status INTEGER NOT NULL DEFAULT 1,
    sort_order INTEGER NOT NULL DEFAULT 0,
    publish_time INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0,
    admin_id INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_contents_channel ON yikai_contents(channel_id);
CREATE INDEX idx_contents_type ON yikai_contents(type);
CREATE INDEX idx_contents_status ON yikai_contents(status);
CREATE INDEX idx_contents_publish ON yikai_contents(publish_time);
CREATE INDEX idx_contents_sort ON yikai_contents(sort_order);
CREATE INDEX idx_contents_top ON yikai_contents(is_top);
CREATE INDEX idx_contents_recommend ON yikai_contents(is_recommend);
CREATE INDEX idx_contents_hot ON yikai_contents(is_hot);
CREATE INDEX idx_contents_lang ON yikai_contents(lang);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_media;
CREATE TABLE yikai_media (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    path TEXT NOT NULL,
    url TEXT NOT NULL,
    type TEXT NOT NULL DEFAULT 'image',
    ext TEXT NOT NULL DEFAULT '',
    mime TEXT NOT NULL DEFAULT '',
    size INTEGER NOT NULL DEFAULT 0,
    width INTEGER NOT NULL DEFAULT 0,
    height INTEGER NOT NULL DEFAULT 0,
    md5 TEXT NOT NULL DEFAULT '',
    admin_id INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_media_type ON yikai_media(type);
CREATE INDEX idx_media_admin ON yikai_media(admin_id);
CREATE INDEX idx_media_md5 ON yikai_media(md5);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_settings;
CREATE TABLE yikai_settings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    "group" TEXT NOT NULL DEFAULT 'basic',
    "key" TEXT NOT NULL UNIQUE,
    value TEXT,
    type TEXT NOT NULL DEFAULT 'text',
    name TEXT NOT NULL DEFAULT '',
    tip TEXT NOT NULL DEFAULT '',
    options TEXT,
    sort_order INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_settings_group ON yikai_settings("group");

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_forms;
CREATE TABLE yikai_forms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT NOT NULL DEFAULT 'contact',
    product_id INTEGER NOT NULL DEFAULT 0,
    product_title TEXT NOT NULL DEFAULT '',
    source TEXT NOT NULL DEFAULT 'contact',
    name TEXT NOT NULL DEFAULT '',
    phone TEXT NOT NULL DEFAULT '',
    email TEXT NOT NULL DEFAULT '',
    company TEXT NOT NULL DEFAULT '',
    content TEXT,
    extra TEXT,
    ip TEXT NOT NULL DEFAULT '',
    user_agent TEXT NOT NULL DEFAULT '',
    status INTEGER NOT NULL DEFAULT 0,
    follow_admin INTEGER NOT NULL DEFAULT 0,
    follow_note TEXT,
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_forms_type ON yikai_forms(type);
CREATE INDEX idx_forms_status ON yikai_forms(status);
CREATE INDEX idx_forms_created ON yikai_forms(created_at);
CREATE INDEX idx_forms_product ON yikai_forms(product_id);
CREATE INDEX idx_forms_source ON yikai_forms(source);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_admin_logs;
CREATE TABLE yikai_admin_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    admin_id INTEGER NOT NULL DEFAULT 0,
    admin_name TEXT NOT NULL DEFAULT '',
    module TEXT NOT NULL DEFAULT '',
    action TEXT NOT NULL DEFAULT '',
    description TEXT NOT NULL DEFAULT '',
    url TEXT NOT NULL DEFAULT '',
    method TEXT NOT NULL DEFAULT '',
    request_data TEXT,
    ip TEXT NOT NULL DEFAULT '',
    user_agent TEXT NOT NULL DEFAULT '',
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_logs_admin ON yikai_admin_logs(admin_id);
CREATE INDEX idx_logs_module ON yikai_admin_logs(module);
CREATE INDEX idx_logs_created ON yikai_admin_logs(created_at);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_links;
CREATE TABLE yikai_links (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    lang TEXT NOT NULL DEFAULT 'ja',
    name TEXT NOT NULL,
    url TEXT NOT NULL,
    logo TEXT NOT NULL DEFAULT '',
    description TEXT NOT NULL DEFAULT '',
    status INTEGER NOT NULL DEFAULT 1,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_links_status ON yikai_links(status);
CREATE INDEX idx_links_sort ON yikai_links(sort_order);
CREATE INDEX idx_links_lang ON yikai_links(lang);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_banners;
CREATE TABLE yikai_banners (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    position TEXT NOT NULL DEFAULT 'home',
    lang TEXT NOT NULL DEFAULT 'ja',
    title TEXT NOT NULL DEFAULT '',
    subtitle TEXT NOT NULL DEFAULT '',
    btn1_text TEXT NOT NULL DEFAULT '',
    btn1_url TEXT NOT NULL DEFAULT '',
    btn2_text TEXT NOT NULL DEFAULT '',
    btn2_url TEXT NOT NULL DEFAULT '',
    image TEXT NOT NULL,
    image_mobile TEXT NOT NULL DEFAULT '',
    link_url TEXT NOT NULL DEFAULT '',
    link_target TEXT NOT NULL DEFAULT '_self',
    start_time INTEGER NOT NULL DEFAULT 0,
    end_time INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_banners_position ON yikai_banners(position);
CREATE INDEX idx_banners_lang ON yikai_banners(lang);
CREATE INDEX idx_banners_status ON yikai_banners(status);
CREATE INDEX idx_banners_sort ON yikai_banners(sort_order);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_banner_groups;
CREATE TABLE yikai_banner_groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    slug TEXT NOT NULL,
    height_pc INTEGER NOT NULL DEFAULT 500,
    height_mobile INTEGER NOT NULL DEFAULT 250,
    autoplay_delay INTEGER NOT NULL DEFAULT 5000,
    sort_order INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE UNIQUE INDEX uk_banner_groups_slug ON yikai_banner_groups(slug);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_article_categories;
CREATE TABLE yikai_article_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    parent_id INTEGER NOT NULL DEFAULT 0,
    name TEXT NOT NULL,
    slug TEXT NOT NULL DEFAULT '',
    image TEXT NOT NULL DEFAULT '',
    description TEXT,
    seo_title TEXT NOT NULL DEFAULT '',
    seo_keywords TEXT NOT NULL DEFAULT '',
    seo_description TEXT NOT NULL DEFAULT '',
    status INTEGER NOT NULL DEFAULT 1,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_article_cat_parent ON yikai_article_categories(parent_id);
CREATE INDEX idx_article_cat_status ON yikai_article_categories(status);
CREATE INDEX idx_article_cat_sort ON yikai_article_categories(sort_order);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_articles;
CREATE TABLE yikai_articles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL DEFAULT 0,
    title TEXT NOT NULL,
    subtitle TEXT NOT NULL DEFAULT '',
    slug TEXT NOT NULL DEFAULT '',
    cover TEXT NOT NULL DEFAULT '',
    summary TEXT,
    content TEXT,
    author TEXT NOT NULL DEFAULT '',
    source TEXT NOT NULL DEFAULT '',
    tags TEXT NOT NULL DEFAULT '',
    is_top INTEGER NOT NULL DEFAULT 0,
    is_recommend INTEGER NOT NULL DEFAULT 0,
    is_hot INTEGER NOT NULL DEFAULT 0,
    views INTEGER NOT NULL DEFAULT 0,
    likes INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    publish_time INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0,
    admin_id INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_articles_category ON yikai_articles(category_id);
CREATE INDEX idx_articles_status ON yikai_articles(status);
CREATE INDEX idx_articles_publish ON yikai_articles(publish_time);
CREATE INDEX idx_articles_top ON yikai_articles(is_top);
CREATE INDEX idx_articles_recommend ON yikai_articles(is_recommend);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_product_categories;
CREATE TABLE yikai_product_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    parent_id INTEGER NOT NULL DEFAULT 0,
    name TEXT NOT NULL,
    slug TEXT NOT NULL DEFAULT '',
    lang TEXT NOT NULL DEFAULT 'ja',
    translation_group_id INTEGER NOT NULL DEFAULT 0,
    image TEXT NOT NULL DEFAULT '',
    description TEXT,
    seo_title TEXT NOT NULL DEFAULT '',
    seo_keywords TEXT NOT NULL DEFAULT '',
    seo_description TEXT NOT NULL DEFAULT '',
    status INTEGER NOT NULL DEFAULT 1,
    is_nav INTEGER NOT NULL DEFAULT 1,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_product_cat_parent ON yikai_product_categories(parent_id);
CREATE INDEX idx_product_cat_lang ON yikai_product_categories(lang);
CREATE INDEX idx_product_cat_status ON yikai_product_categories(status);
CREATE INDEX idx_product_cat_sort ON yikai_product_categories(sort_order);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_products;
CREATE TABLE yikai_products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL DEFAULT 0,
    brand_id INTEGER NOT NULL DEFAULT 0,
    lang TEXT NOT NULL DEFAULT 'ja',
    translation_group_id INTEGER NOT NULL DEFAULT 0,
    title TEXT NOT NULL,
    subtitle TEXT NOT NULL DEFAULT '',
    slug TEXT NOT NULL DEFAULT '',
    cover TEXT NOT NULL DEFAULT '',
    images TEXT,
    summary TEXT,
    content TEXT,
    price REAL NOT NULL DEFAULT 0,
    market_price REAL NOT NULL DEFAULT 0,
    model TEXT NOT NULL DEFAULT '',
    specs TEXT,
    tags TEXT NOT NULL DEFAULT '',
    product_type TEXT NOT NULL DEFAULT 'custom',
    material TEXT NOT NULL DEFAULT '',
    scene TEXT NOT NULL DEFAULT '',
    is_top INTEGER NOT NULL DEFAULT 0,
    is_recommend INTEGER NOT NULL DEFAULT 0,
    is_hot INTEGER NOT NULL DEFAULT 0,
    is_new INTEGER NOT NULL DEFAULT 0,
    views INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0,
    admin_id INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_products_category ON yikai_products(category_id);
CREATE INDEX idx_products_status ON yikai_products(status);
CREATE INDEX idx_products_top ON yikai_products(is_top);
CREATE INDEX idx_products_recommend ON yikai_products(is_recommend);
CREATE INDEX idx_products_sort ON yikai_products(sort_order);
CREATE INDEX idx_products_lang ON yikai_products(lang);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_albums;
CREATE TABLE yikai_albums (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL DEFAULT 0,
    name TEXT NOT NULL,
    slug TEXT NOT NULL DEFAULT '',
    cover TEXT NOT NULL DEFAULT '',
    description TEXT,
    photo_count INTEGER NOT NULL DEFAULT 0,
    sort_order INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    created_at INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_albums_category ON yikai_albums(category_id);
CREATE INDEX idx_albums_status ON yikai_albums(status);
CREATE INDEX idx_albums_sort ON yikai_albums(sort_order DESC, id DESC);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_album_photos;
CREATE TABLE yikai_album_photos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    album_id INTEGER NOT NULL,
    title TEXT NOT NULL DEFAULT '',
    image TEXT NOT NULL,
    thumb TEXT NOT NULL DEFAULT '',
    description TEXT NOT NULL DEFAULT '',
    sort_order INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_album_photos_album ON yikai_album_photos(album_id);
CREATE INDEX idx_album_photos_sort ON yikai_album_photos(sort_order DESC, id DESC);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_download_categories;
CREATE TABLE yikai_download_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT NOT NULL DEFAULT '',
    sort_order INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    created_at INTEGER NOT NULL DEFAULT 0
);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_downloads;
CREATE TABLE yikai_downloads (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER NOT NULL DEFAULT 0,
    lang TEXT NOT NULL DEFAULT 'ja',
    translation_group_id INTEGER NOT NULL DEFAULT 0,
    title TEXT NOT NULL,
    description TEXT,
    cover TEXT NOT NULL DEFAULT '',
    file_url TEXT NOT NULL DEFAULT '',
    file_name TEXT NOT NULL DEFAULT '',
    file_size INTEGER NOT NULL DEFAULT 0,
    file_ext TEXT NOT NULL DEFAULT '',
    download_count INTEGER NOT NULL DEFAULT 0,
    is_external INTEGER NOT NULL DEFAULT 0,
    require_login INTEGER NOT NULL DEFAULT 0,
    sort_order INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    created_at INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0,
    admin_id INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_downloads_category ON yikai_downloads(category_id);
CREATE INDEX idx_downloads_status ON yikai_downloads(status);
CREATE INDEX idx_downloads_sort ON yikai_downloads(sort_order DESC, id DESC);
CREATE INDEX idx_downloads_lang ON yikai_downloads(lang);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_jobs;
CREATE TABLE yikai_jobs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    lang TEXT NOT NULL DEFAULT 'ja',
    translation_group_id INTEGER NOT NULL DEFAULT 0,
    cover TEXT NOT NULL DEFAULT '',
    summary TEXT,
    content TEXT,
    location TEXT NOT NULL DEFAULT '',
    salary TEXT NOT NULL DEFAULT '',
    job_type TEXT NOT NULL DEFAULT '',
    education TEXT NOT NULL DEFAULT '',
    experience TEXT NOT NULL DEFAULT '',
    headcount TEXT NOT NULL DEFAULT '',
    requirements TEXT,
    views INTEGER NOT NULL DEFAULT 0,
    is_top INTEGER NOT NULL DEFAULT 0,
    sort_order INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    publish_time INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0,
    admin_id INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_jobs_status ON yikai_jobs(status);
CREATE INDEX idx_jobs_top ON yikai_jobs(is_top DESC, sort_order DESC, id DESC);
CREATE INDEX idx_jobs_lang ON yikai_jobs(lang);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_timelines;
CREATE TABLE yikai_timelines (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    lang TEXT NOT NULL DEFAULT 'ja',
    year INTEGER NOT NULL,
    month INTEGER NOT NULL DEFAULT 0,
    day INTEGER NOT NULL DEFAULT 0,
    title TEXT NOT NULL,
    content TEXT,
    image TEXT NOT NULL DEFAULT '',
    icon TEXT NOT NULL DEFAULT '',
    color TEXT NOT NULL DEFAULT '',
    sort_order INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    created_at INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_timelines_year ON yikai_timelines(year);
CREATE INDEX idx_timelines_status ON yikai_timelines(status);
CREATE INDEX idx_timelines_sort ON yikai_timelines(sort_order DESC, year DESC, month DESC);
CREATE INDEX idx_timelines_lang ON yikai_timelines(lang);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_plugins;
CREATE TABLE yikai_plugins (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    slug TEXT NOT NULL UNIQUE,
    status INTEGER NOT NULL DEFAULT 0,
    installed_at INTEGER NOT NULL DEFAULT 0,
    activated_at INTEGER NOT NULL DEFAULT 0
);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_members;
CREATE TABLE yikai_members (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    email TEXT NOT NULL DEFAULT '',
    nickname TEXT NOT NULL DEFAULT '',
    avatar TEXT NOT NULL DEFAULT '',
    status INTEGER NOT NULL DEFAULT 1,
    last_login_time INTEGER NOT NULL DEFAULT 0,
    last_login_ip TEXT NOT NULL DEFAULT '',
    login_count INTEGER NOT NULL DEFAULT 0,
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE UNIQUE INDEX uk_members_email ON yikai_members(email);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_form_templates;
CREATE TABLE yikai_form_templates (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    fields TEXT,
    success_message TEXT NOT NULL DEFAULT '提交成功，感谢您的反馈！',
    status INTEGER NOT NULL DEFAULT 1,
    created_at INTEGER NOT NULL DEFAULT 0
);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_brands;
CREATE TABLE yikai_brands (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    slug TEXT NOT NULL DEFAULT '',
    lang TEXT NOT NULL DEFAULT 'ja',
    translation_group_id INTEGER NOT NULL DEFAULT 0,
    logo TEXT NOT NULL DEFAULT '',
    country TEXT NOT NULL DEFAULT '',
    description TEXT,
    url TEXT NOT NULL DEFAULT '',
    sort_order INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_brands_lang ON yikai_brands(lang);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_product_tags;
CREATE TABLE yikai_product_tags (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_name TEXT NOT NULL,
    name TEXT NOT NULL,
    slug TEXT NOT NULL DEFAULT '',
    lang TEXT NOT NULL DEFAULT 'ja',
    translation_group_id INTEGER NOT NULL DEFAULT 0,
    sort_order INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1
);
CREATE INDEX idx_product_tags_group ON yikai_product_tags(group_name);
CREATE INDEX idx_product_tags_lang ON yikai_product_tags(lang);

-- -----------------------------------------------------------
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_product_tag_map;
CREATE TABLE yikai_product_tag_map (
    product_id INTEGER NOT NULL,
    tag_id INTEGER NOT NULL,
    PRIMARY KEY (product_id, tag_id)
);
CREATE INDEX idx_tag_map_tag ON yikai_product_tag_map(tag_id);

-- -----------------------------------------------------------
-- AI 调用日志
-- -----------------------------------------------------------
DROP TABLE IF EXISTS yikai_ai_logs;
CREATE TABLE yikai_ai_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    provider TEXT NOT NULL DEFAULT '',
    model TEXT NOT NULL DEFAULT '',
    action TEXT NOT NULL DEFAULT '',
    prompt_tokens INTEGER NOT NULL DEFAULT 0,
    completion_tokens INTEGER NOT NULL DEFAULT 0,
    total_tokens INTEGER NOT NULL DEFAULT 0,
    success INTEGER NOT NULL DEFAULT 1,
    error_msg TEXT NOT NULL DEFAULT '',
    admin_id INTEGER NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE yikai_metas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_type TEXT NOT NULL,
    owner_id INTEGER NOT NULL DEFAULT 0,
    meta_key TEXT NOT NULL,
    meta_value TEXT,
    created_at INTEGER NOT NULL DEFAULT 0,
    updated_at INTEGER NOT NULL DEFAULT 0
);
CREATE UNIQUE INDEX idx_metas_owner_key ON yikai_metas (owner_type, owner_id, meta_key);
CREATE INDEX idx_metas_owner ON yikai_metas (owner_type, owner_id);

CREATE TABLE yikai_extfields (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_type TEXT NOT NULL,
    field_key TEXT NOT NULL,
    field_name TEXT NOT NULL,
    field_type TEXT NOT NULL DEFAULT 'text',
    options TEXT,
    placeholder TEXT NOT NULL DEFAULT '',
    help_text TEXT NOT NULL DEFAULT '',
    is_required INTEGER NOT NULL DEFAULT 0,
    sort_order INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 1,
    created_at INTEGER NOT NULL DEFAULT 0
);
CREATE UNIQUE INDEX idx_extfields_owner_key ON yikai_extfields (owner_type, field_key);
CREATE INDEX idx_extfields_owner ON yikai_extfields (owner_type, status, sort_order);

PRAGMA foreign_keys = ON;

-- ============================================================
-- ============================================================

-- ============================================================
-- ============================================================

-- @demo:start

UPDATE yikai_channels SET content = '<h2>关于我们</h2>
<p>我们是一家专注于企业数字化转型的科技公司，致力于为客户提供优质的产品与服务。公司成立于2010年，总部位于上海，是一家集研发、生产、销售、服务于一体的高新技术企业。</p>

<h3>企业愿景</h3>
<p>成为行业领先的数字化解决方案提供商，用科技创造价值，助力企业实现智能化升级。</p>

<h3>核心价值观</h3>
<ul>
<li><strong>创新</strong> - 持续创新，追求卓越</li>
<li><strong>务实</strong> - 脚踏实地，专注品质</li>
<li><strong>共赢</strong> - 合作共赢，共创未来</li>
</ul>

<p>欢迎通过左侧菜单了解更多关于我们的信息。</p>' WHERE id = 1;

-- ============================================================
-- 旧文章分类表（保留结构，不插入数据，已由 channels 统一管理）
-- ============================================================

-- ============================================================
-- ============================================================

UPDATE yikai_contents SET
    images = 'https://picsum.photos/seed/case-5-a/1200/900
https://picsum.photos/seed/case-5-b/1200/900
https://picsum.photos/seed/case-5-c/1200/900
https://picsum.photos/seed/case-5-d/1200/900',
    client_name = '某大型制造企业',
    industry = '智能制造',
    duration = '2023-06 ~ 2024-02',
    result_metric = '生产效率提升 30%，运营成本降低 20%，产品良率提高 15%'
WHERE type = 'case' AND title LIKE '某大型制造企业%';

-- ============================================================
-- 旧文章表（保留结构，不插入数据，已由 contents 统一管理）
-- ============================================================

-- ============================================================
-- ============================================================

-- ============================================================
-- ============================================================

-- ============================================================
-- ============================================================

-- ============================================================
-- ============================================================

-- ============================================================
-- ============================================================

-- ============================================================
-- ============================================================

-- ============================================================
-- ============================================================

-- ============================================================
-- ============================================================

-- ============================================================
-- ============================================================

-- @demo:end

-- ============================================================
-- 默认初始数据 (Japanese / 日本語デフォルトデータ)
-- 自动从 ikai_cms 主数据库生成 — 编辑请重跑 _rebuild_install_sql.php
-- ============================================================

-- yikai_roles: 3 rows (auto-generated, ja default)
INSERT INTO yikai_roles (`id`,`name`,`description`,`permissions`,`status`,`created_at`) VALUES
(1,'超级管理员','拥有全部权限','["*"]',1,1770899116),
(2,'编辑','内容编辑权限','["content","media"]',1,1770899116),
(3,'运营','运营管理权限','["content","media","form","banner","link"]',1,1770899116);

-- yikai_settings: 114 rows (auto-generated, ja default)
INSERT INTO yikai_settings (`id`,`group`,`key`,`value`,`type`,`name`,`tip`,`options`,`sort_order`) VALUES
(1,'basic','site_name','ikaiCMS','text','サイト名','',NULL,1),
(2,'basic','site_keywords','企業サイト,CMS,コンテンツ管理','textarea','SEOキーワード','カンマ区切りで複数指定',NULL,2),
(3,'basic','site_description','企業サイトの構築・運用に最適な軽量CMS','textarea','SEO説明文','',NULL,3),
(4,'basic','site_logo','/images/logo.png','image','サイトロゴ','',NULL,4),
(7,'basic','primary_color','#3B82F6','color','メインカラー','16進数カラーコード',NULL,6),
(8,'basic','secondary_color','#1D4ED8','color','サブカラー','16進数カラーコード',NULL,7),
(9,'contact','contact_phone','03-0000-0000','text','電話番号','',NULL,1),
(10,'contact','contact_email','info@example.co.jp','text','メールアドレス','',NULL,2),
(11,'contact','contact_address','東京都渋谷区XX町X丁目X-X','textarea','住所','',NULL,3),
(12,'contact','contact_qrcode','','image','QRコード','',NULL,5),
(13,'contact','contact_map','','image','地図画像','',NULL,6),
(14,'banner','banner_height_pc',650,'number','スライド高さ(PC)','ピクセル単位',NULL,9),
(15,'banner','banner_height_mobile',300,'number','スライド高さ(モバイル)','ピクセル単位',NULL,10),
(16,'home','home_about_content','企業のデジタルトランスフォーメーションに特化したテクノロジー企業として、お客様に高品質な製品とサービスを提供しています。長年の実績を重ね、業界で影響力のある企業へと成長しました。','textarea','会社紹介文','トップページ「会社概要」セクションのテキスト',NULL,1),
(17,'home','home_about_image','https://images.unsplash.com/photo-1497366216548-37526070297c?w=800&q=80','image','会社紹介画像','トップページ「会社概要」セクションの画像',NULL,2),
(18,'home','home_about_tag_title','プロフェッショナルサービス','text','バッジタイトル','画像左下のバッジタイトル',NULL,3),
(19,'home','home_about_tag_desc','品質・革新・共創','text','バッジ説明','画像左下のバッジ説明文',NULL,4),
(20,'home','home_stat_1_num','10+','text','統計数値1','',NULL,5),
(21,'home','home_stat_1_text','業界実績','text','統計テキスト1','',NULL,6),
(22,'home','home_stat_2_num','1000+','text','統計数値2','',NULL,7),
(23,'home','home_stat_2_text','導入実績','text','統計テキスト2','',NULL,8),
(24,'home','home_stat_3_num','50+','text','統計数値3','',NULL,9),
(25,'home','home_stat_3_text','専門チーム','text','統計テキスト3','',NULL,10),
(26,'home','home_stat_4_num','100%','text','統計数値4','',NULL,11),
(27,'home','home_stat_4_text','顧客満足度','text','統計テキスト4','',NULL,12),
(28,'home','home_advantage_desc','プロフェッショナルチームによる高品質サービス','text','強み説明','',NULL,13),
(29,'home','home_adv_1_title','品質保証','text','強み1タイトル','',NULL,14),
(30,'home','home_adv_1_desc','厳格な品質管理で、すべての製品が基準を満たすことを保証します','text','強み1説明','',NULL,15),
(31,'home','home_adv_2_title','技術力','text','強み2タイトル','',NULL,16),
(32,'home','home_adv_2_desc','継続的な研究開発で、技術の優位性を維持します','text','強み2説明','',NULL,17),
(33,'home','home_adv_3_title','専門サポート','text','強み3タイトル','',NULL,18),
(34,'home','home_adv_3_desc','専門チームによる24時間365日テクニカルサポート','text','強み3説明','',NULL,19),
(35,'home','home_adv_4_title','共創共栄','text','強み4タイトル','',NULL,20),
(36,'home','home_adv_4_desc','お客様との長期的なパートナーシップで、互いの成長を実現します','text','強み4説明','',NULL,21),
(37,'home','home_cta_title','お取引を始めませんか？','text','CTAタイトル','アクション誘導セクションのタイトル',NULL,22),
(38,'home','home_cta_desc','お気軽にご相談ください。最適なソリューションをご提案します','text','CTA説明','アクション誘導セクションの説明',NULL,23),
(39,'email','smtp_host','','text','SMTPサーバー','例: smtp.gmail.com',NULL,1),
(40,'email','smtp_port',465,'text','SMTPポート','SSL:465、TLS:587',NULL,2),
(41,'email','smtp_secure','ssl','text','暗号化方式','ssl/tls/空',NULL,3),
(42,'email','smtp_user','','text','SMTPユーザー名','メールアドレス',NULL,4),
(43,'email','smtp_pass','','text','SMTPパスワード','',NULL,5),
(44,'email','mail_from','','text','送信元メール','空欄ならSMTPユーザー名を使用',NULL,6),
(45,'email','mail_from_name','','text','送信者名','空欄ならサイト名を使用',NULL,7),
(46,'email','mail_admin','','text','管理者メール','フォーム通知の送信先',NULL,8),
(47,'email','mail_notify_form',0,'text','フォーム送信通知','1:有効/0:無効',NULL,9),
(48,'product','product_layout','sidebar','select','製品リストレイアウト','','{"sidebar":"侧栏模式","top":"顶栏模式"}',11),
(49,'home','home_show_links',0,'select','パートナー表示','フッターにパートナーロゴを表示',NULL,24),
(50,'contact','contact_form_title','オンラインお問い合わせ','text','フォームタイトル','',NULL,10),
(52,'contact','contact_cards','[{"icon":"phone","label":"電話番号","value":"03-0000-0000"},{"icon":"email","label":"メールアドレス","value":"info@example.co.jp"},{"icon":"location","label":"所在地","value":"東京都渋谷区XX町X丁目X-X"},{"icon":"clock","label":"営業時間","value":"平日 9:00〜18:00（土日祝休み）"}]','contact_cards','連絡先カード','お問い合わせページ上部の情報カード（最大4つ）',NULL,0),
(53,'product','show_price',0,'select','価格表示','フロントで製品価格を表示','{"0":"不显示","1":"显示"}',12),
(56,'system','cms_version','1.0.0','text','CMSバージョン','システムが自動管理、手動変更不可',NULL,0),
(57,'header','topbar_enabled',0,'select','トップバー表示','ロゴ上部の通知バーエリア','{"0":"隐藏","1":"显示"}',0),
(58,'header','topbar_bg_color','#f3f4f6','color','トップバー背景色','トップバーの背景色',NULL,1),
(59,'header','topbar_left','','code','トップバー左側','HTMLコード対応（電話番号やお知らせなど）',NULL,2),
(60,'header','header_nav_layout','right','select','ナビレイアウト','ロゴの右側またはロゴの下に配置','{"right":"Logo右侧","below":"Logo下方通栏"}',10),
(61,'header','header_sticky',0,'select','ヘッダー固定','ナビバーをページ上部に固定','{"1":"是","0":"否"}',11),
(62,'header','header_bg_color','#ffffff','color','背景色','16進数カラーコード',NULL,12),
(63,'header','header_text_color','#4b5563','color','文字色','16進数カラーコード',NULL,13),
(64,'footer','footer_columns','[{"title":"会社概要","content":"{{site_description}}","col_span":2},{"title":"お問い合わせ","content":"{{contact_info}}","col_span":1},{"title":"フォロー","content":"{{qrcode}}","col_span":1}]','footer_columns','フッターカラム','各列コンテンツ（最大4列）',NULL,1),
(65,'footer','footer_bg_color','#1f2937','color','背景色','16進数カラーコード',NULL,2),
(66,'footer','footer_bg_image','','image','背景画像','設定すると背景色の代わりに表示',NULL,3),
(67,'footer','footer_text_color','#9ca3af','color','文字色','16進数カラーコード',NULL,4),
(68,'basic','site_url','http://ikai.cms','text','サイトURL','例: https://www.example.com（末尾スラッシュなし）',NULL,0),
(69,'code','custom_head_code','','code','Headコード','</head>直前に挿入（認証、SEOメタタグなど）',NULL,1),
(70,'code','custom_body_code','','code','Bodyコード','</body>直前に挿入（解析コード、チャットなど）',NULL,2),
(71,'basic','site_favicon','/favicon.ico','image','ファビコン','ブラウザタブのアイコン（.ico/.png形式）',NULL,5),
(72,'home','home_show_banner',1,'select','スライドショー表示','トップページバナースライド',NULL,30),
(73,'home','home_show_about',1,'select','会社概要表示','トップページ会社概要セクション',NULL,31),
(74,'home','home_show_stats',1,'select','統計データ表示','トップページ統計データセクション',NULL,32),
(75,'home','home_show_channels',1,'select','カテゴリセクション表示','製品・ニュースなどのトップページ表示',NULL,33),
(76,'home','home_show_advantage',1,'select','強みセクション表示','トップページ「私たちの強み」セクション',NULL,34),
(77,'home','home_show_cta',1,'select','CTA表示','トップページ下部のCTAセクション',NULL,35),
(78,'home','home_blocks_config','[{"type":"banner","enabled":true},{"type":"about","enabled":true,"bg_opacity":100,"text_light":false,"layout":"container"},{"type":"stats","enabled":true,"bg_opacity":100,"text_light":false,"layout":"container"},{"type":"channel:7","enabled":true,"bg_opacity":100,"text_light":false,"layout":"container"},{"type":"channel:9","enabled":true,"bg_opacity":100,"text_light":false,"layout":"container"},{"type":"channel:12","enabled":true,"bg_opacity":100,"text_light":false,"layout":"container"},{"type":"testimonials","enabled":true,"bg_opacity":100,"text_light":false,"layout":"container"},{"type":"advantage","enabled":true,"bg_opacity":100,"text_light":true,"layout":"container"},{"type":"cta","enabled":true,"bg_opacity":100,"text_light":true,"layout":"container"}]','home_blocks','トップページブロック設定','トップページブロックの順序と表示設定',NULL,40),
(79,'home','home_testimonials','[{"avatar":"","name":"田中様","company":"某テクノロジー株式会社","content":"非常にプロフェッショナルなチームで、素晴らしい協力関係を築けました。製品の品質にも大変満足しています。"},{"avatar":"","name":"佐藤様","company":"某貿易株式会社","content":"製品の品質が優れており、アフターサポートも迅速です。信頼できるパートナーです。"},{"avatar":"","name":"鈴木様","company":"某グループ会社","content":"長年にわたる協力関係の中で、常に高品質なサービスを提供していただいています。強くお勧めします。"}]','home_testimonials','お客様の声','トップページお客様の声セクション',NULL,26),
(80,'home','home_testimonials_title','お客様の声','text','お客様の声タイトル','',NULL,27),
(81,'home','home_testimonials_desc','パートナー企業様からのご評価','text','お客様の声説明','',NULL,28),
(82,'home','home_stat_bg','','image','統計背景画像','データ統計セクションの背景画像',NULL,12),
(83,'home','home_about_layout','text_left','select','レイアウト','テキスト左/画像左','{"text_left":"左文右图","image_left":"左图右文"}',6),
(84,'home','home_adv_1_icon','check-circle','icon','強み1アイコン','',NULL,14),
(85,'home','home_adv_2_icon','academic-cap','icon','強み2アイコン','',NULL,16),
(86,'home','home_adv_3_icon','briefcase','icon','強み3アイコン','',NULL,18),
(87,'home','home_adv_4_icon','users','icon','強み4アイコン','',NULL,20),
(88,'header','show_member_entry',0,'select','会員メニュー表示','ナビバーにログイン/登録リンクを表示','{"0":"隐藏","1":"显示"}',3),
(89,'member','allow_member_register',0,'switch','会員登録許可','フロントでの会員登録を許可',NULL,1),
(90,'member','download_require_login',0,'switch','ダウンロードにログイン必要','ファイルダウンロードに会員ログインが必要',NULL,2),
(91,'home','home_links_title','パートナー','text','リンクセクションタイトル','',NULL,25),
(93,'footer','footer_nav','[{"title":"","links":[{"name":"プライバシーポリシー","url":"\/privacy.html"},{"name":"利用規約","url":"\/terms.html"}]}]','footer_nav','フッターナビ','著作権バー上のナビリンクグループ',NULL,5),
(95,'translate','translate_api','deepl','select','翻訳API','翻訳サービスプロバイダーを選択','{"deepl":"DeepL","google":"Google Translate"}',1),
(96,'translate','translate_api_key','','text','APIキー','DeepL: 無料キーを登録して取得',NULL,2),
(100,'email','mail_tpl_register_subject','欢迎注册 — {{site_name}}','textarea','mail_tpl_register_subject','',NULL,20),
(101,'email','mail_tpl_register_body','{{username}}，您好！\n\n欢迎注册 {{site_name}}！您的帐号已创建成功。\n\n请登录会员中心管理您的帐号：\n{{site_url}}/member/\n\n如有任何问题，请随时联系我们。\n\n{{site_name}}\n{{date}}','textarea','mail_tpl_register_body','',NULL,21),
(102,'email','mail_tpl_forgot_subject','密码找回 — {{site_name}}','textarea','mail_tpl_forgot_subject','',NULL,22),
(103,'email','mail_tpl_forgot_body','{{username}}，您好！\n\n您正在进行密码找回操作，请点击以下链接重置密码：\n{{reset_link}}\n\n链接有效期为 30 分钟，如非本人操作请忽略此邮件。\n\n{{site_name}}\n{{date}}','textarea','mail_tpl_forgot_body','',NULL,23),
(104,'email','mail_tpl_reset_subject','密码已重置 — {{site_name}}','textarea','mail_tpl_reset_subject','',NULL,24),
(105,'email','mail_tpl_reset_body','{{username}}，您好！\n\n您的密码已成功重置。如非本人操作，请立即联系我们修改密码。\n\n{{site_name}}\n{{date}}','textarea','mail_tpl_reset_body','',NULL,25),
(106,'email','mail_tpl_inquiry_subject','新询盘通知：{{product_title}} — {{site_name}}','textarea','mail_tpl_inquiry_subject','',NULL,26),
(107,'email','mail_tpl_inquiry_body','您收到一条新的产品询盘：\n\n产品：{{product_title}}\n姓名：{{name}}\n电话：{{phone}}\n邮箱：{{email}}\n公司：{{company}}\n内容：{{content}}\n\n时间：{{date}}\nIP：{{ip}}\n\n后台查看：{{site_url}}/admin/form.php','textarea','mail_tpl_inquiry_body','',NULL,27),
(110,'contact','contact_form_desc','','textarea','フォーム説明','タイトル下に表示する説明文',NULL,11),
(111,'contact','contact_form_fields','[{"key":"company","label":"会社名","type":"text","required":false,"enabled":true},{"key":"name","label":"お名前","type":"text","required":true,"enabled":true},{"key":"phone","label":"電話番号","type":"tel","required":false,"enabled":true},{"key":"email","label":"メールアドレス","type":"email","required":true,"enabled":true},{"key":"content","label":"お問い合わせ内容","type":"textarea","required":true,"enabled":true}]','contact_form_fields','フォームフィールド','フォームに表示するフィールドの設定',NULL,12),
(112,'contact','contact_form_success','送信が完了しました。担当者よりご連絡いたします。','text','送信完了メッセージ','フォーム送信後に表示するメッセージ',NULL,13),
(113,'contact','contact_hours','平日 9:00〜18:00（土日祝休み）','text','営業時間','例：平日 9:00〜18:00',NULL,4),
(114,'social','social_links','[]','social_links','SNSリンク','フッター等に表示するSNSアイコンリンク',NULL,1),
(115,'basic','current_theme','default','text','','',NULL,17),
(118,'system','admin_lang','ja','select','','',NULL,14),
(119,'basic','site_lang','ja','select','フロント言語','フロント画面の表示言語','{"zh-CN":"中文","ja":"日本語"}',13),
(121,'basic','admin_title','ikaiCMS','text','管理画面名称','管理画面左上に表示される名称',NULL,15),
(122,'basic','admin_copyright','Powered by ikaiCMS | イーカイ株式会社','text','','',NULL,16),
(123,'header','nav_home_text','ホーム','text','ナビ「ホーム」テキスト','空欄の場合は言語パックのデフォルト値を使用',NULL,0),
(124,'footer','footer_copyright_text','© {year} {site_name} All Rights Reserved.','text','著作権テキスト','{year}=年、{site_name}=サイト名に自動置換',NULL,6),
(125,'basic','admin_logo','','image','管理画面ロゴ','空欄の場合テキスト表示',NULL,21),
(126,'basic','ai_provider','deepseek','text','ai_provider','',NULL,0),
(127,'basic','ai_api_key','eRbBNABdb3LgisG9R/F6NCLkg89ooDCn7IjQuOwjQX7QPI4gt4GUQlVEqzzZuJc1','text','ai_api_key','',NULL,0),
(128,'basic','ai_model','deepseek-v4-flash','text','ai_model','',NULL,0),
(129,'basic','ai_base_url','','text','ai_base_url','',NULL,0);

-- yikai_channels: 17 rows (auto-generated, ja default)
INSERT INTO yikai_channels (`id`,`lang`,`translation_group_id`,`parent_id`,`name`,`slug`,`type`,`album_id`,`icon`,`image`,`description`,`content`,`redirect_type`,`redirect_url`,`link_url`,`link_target`,`seo_title`,`seo_keywords`,`seo_description`,`is_nav`,`is_home`,`status`,`is_system`,`sort_order`,`created_at`,`updated_at`) VALUES
(1,'ja',0,0,'会社概要','company','page',0,'','','会社情報','<table style="width:100%;border-collapse:collapse">
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">会社名</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">株式会社○○（かぶしきがいしゃ ○○）</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">設立</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">2020年4月</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">代表者</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">代表取締役　○○ ○○</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">資本金</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">1,000万円</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">従業員数</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">50名（2024年4月現在）</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">事業内容</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">・IoTソリューションの企画・開発・販売<br>・企業向けクラウドサービスの提供<br>・システムインテグレーション<br>・テクニカルサポート・コンサルティング</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">本社所在地</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">〒150-0000<br>東京都渋谷区XX町X丁目X-X XXビル 5F</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">大阪支社</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">〒530-0000<br>大阪府大阪市北区XX町X丁目X-X XXビル 3F</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">電話番号</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">03-0000-0000</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">FAX</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">03-0000-0001</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">メールアドレス</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">info@example.co.jp</td>
</tr>
<tr style="border-bottom:1px solid #e5e7eb">
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">取引銀行</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">三菱UFJ銀行 ○○支店<br>みずほ銀行 ○○支店</td>
</tr>
<tr>
<th style="padding:16px 20px;text-align:left;width:180px;background:#f9fafb;font-weight:bold;font-size:14px;color:#374151;vertical-align:top">主要取引先</th>
<td style="padding:16px 20px;font-size:14px;color:#4b5563">株式会社○○<br>○○株式会社<br>○○グループ（順不同・敬称略）</td>
</tr>
</table>','none','','','_self','','','',1,0,1,1,1,1770899116,0),
(2,'ja',0,1,'代表挨拶','greeting','page',0,'','','代表取締役からのメッセージ',NULL,'none','','','_self','','','',1,0,1,1,1,1770899116,0),
(3,'ja',0,1,'企業理念','philosophy','page',0,'','','ミッション・ビジョン・バリュー',NULL,'none','','','_self','','','',1,0,1,1,2,1770899116,0),
(4,'ja',0,1,'沿革','history','page',0,'','','会社の歩み',NULL,'none','','','_self','','','',1,0,1,1,3,1770899116,0),
(5,'ja',0,1,'アクセス','access','page',0,'','','所在地・交通案内',NULL,'none','','','_self','','','',1,0,1,1,4,1770899116,0),
(6,'ja',0,0,'事業内容','service','page',0,'','','事業内容のご紹介',NULL,'auto','','','_self','','','',1,0,1,1,2,1770899116,0),
(7,'ja',0,0,'製品情報','product','product',0,'','','製品・サービス一覧',NULL,'auto','','','_self','','','',1,1,1,1,3,1770899116,0),
(9,'ja',0,0,'導入事例','works','case',0,'','','お客様の導入事例',NULL,'auto','','','_self','','','',1,1,1,1,4,1770899116,0),
(12,'ja',0,0,'お知らせ','news','list',0,'','','最新のお知らせ',NULL,'auto','','','_self','','','',1,1,1,1,5,1770899116,0),
(13,'ja',0,12,'ニュース','company-news','list',0,'','','企業ニュース',NULL,'auto','','','_self','','','',1,0,1,1,1,1770899116,0),
(14,'ja',0,12,'プレスリリース','press','list',0,'','','プレスリリース',NULL,'auto','','','_self','','','',1,0,1,1,2,1770899116,0),
(17,'ja',0,0,'よくあるご質問','faq','list',0,'','','お客様からよく寄せられるご質問',NULL,'auto','','','_self','','','',1,0,1,1,7,1770899116,0),
(19,'ja',0,0,'採用情報','recruit','job',0,'','','一緒に働く仲間を募集しています',NULL,'auto','','','_self','','','',1,0,1,1,6,1770899116,0),
(20,'ja',0,0,'お問い合わせ','contact','page',0,'','','お問い合わせフォーム',NULL,'none','','','_self','','','',1,0,1,1,8,1770899116,0),
(29,'ja',0,0,'プライバシーポリシー','privacy','page',0,'','','個人情報の取り扱いについて',NULL,'none','','','_self','','','',0,0,1,1,98,1770899116,0),
(30,'ja',0,0,'利用規約','terms','page',0,'','','ウェブサイトのご利用条件',NULL,'none','','','_self','','','',0,0,1,1,99,1770899116,0),
(31,'ja',0,0,'サイトマップ','sitemap-page','page',0,'','','サイト全体の構成',NULL,'none','','','_self','','','',0,0,1,1,97,1770899116,0);

-- yikai_contents: 12 rows (auto-generated, ja default)
INSERT INTO yikai_contents (`id`,`lang`,`translation_group_id`,`channel_id`,`type`,`title`,`subtitle`,`slug`,`cover`,`images`,`summary`,`content`,`content_type`,`blocks_data`,`author`,`source`,`tags`,`attachment`,`download_count`,`price`,`specs`,`location`,`salary`,`requirements`,`client_name`,`industry`,`duration`,`result_metric`,`headcount`,`job_type`,`education`,`experience`,`is_top`,`is_recommend`,`is_hot`,`views`,`likes`,`seo_title`,`seo_keywords`,`seo_description`,`status`,`sort_order`,`publish_time`,`created_at`,`updated_at`,`admin_id`) VALUES
(1,'ja',0,2,'article','代表挨拶','','greeting','',NULL,'企業のデジタルトランスフォーメーションに特化し、お客様に高品質な製品とサービスを提供しています。','<h2>ご挨拶</h2>
<p>平素より格別のお引き立てを賜り、誠にありがとうございます。</p>

<p>当社は2010年の設立以来、企業のデジタルトランスフォーメーションを支援するテクノロジー企業として、研究開発・製造・販売・サポートを一貫して行ってまいりました。おかげさまで、業界において確かな実績と信頼を築くことができました。</p>

<h2>私たちの強み</h2>
<ul>
<li><strong>技術力</strong>：複数のコア特許技術を保有</li>
<li><strong>品質保証</strong>：ISO9001品質マネジメントシステム認証取得</li>
<li><strong>専門サポート</strong>：24時間365日のテクニカルサポート体制</li>
<li><strong>豊富な実績</strong>：1,000社以上の企業様にサービスを提供</li>
</ul>

<h2>今後のビジョン</h2>
<p>技術革新を原動力とし、お客様のニーズを第一に考え、業界をリードするソリューションプロバイダーを目指してまいります。今後とも変わらぬご支援を賜りますよう、よろしくお願い申し上げます。</p>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',1,1,0,100,0,'','','',1,0,1770899116,1770899116,0,1),
(2,'ja',0,3,'article','企業理念','','philosophy','',NULL,'ミッション・ビジョン・バリュー','<h2>ミッション（使命）</h2>
<p>テクノロジーの力で価値を創造し、お客様に卓越した製品とサービスを提供します。</p>

<h2>ビジョン（将来像）</h2>
<p>業界で最も信頼され、尊敬される企業となり、社会の発展に貢献します。</p>

<h2>バリュー（価値観）</h2>
<ul>
<li><strong>革新</strong> — 常に新しい挑戦を続け、卓越を追求します</li>
<li><strong>誠実</strong> — 誠実さと透明性をすべての行動の基盤とします</li>
<li><strong>共創</strong> — お客様・パートナー・社員と共に成長します</li>
<li><strong>品質</strong> — 妥協のない品質で、期待を超える成果を目指します</li>
</ul>

<h2>行動指針</h2>
<ul>
<li>お客様の課題を自分事として捉え、最適なソリューションを提案する</li>
<li>チームワークを大切にし、多様な視点を活かす</li>
<li>失敗を恐れず挑戦し、そこから学び成長する</li>
<li>社会的責任を果たし、持続可能な事業を推進する</li>
</ul>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',0,0,0,50,0,'','','',1,0,1770899116,1770899116,0,1),
(5,'ja',0,9,'case','大手製造企業のDXプロジェクト','','manufacturing-dx','/images/case-demo.jpg',NULL,'お客様の生産効率を30%向上させました','<h3>プロジェクト背景</h3>
<p>クライアントは国内大手製造企業で、5つの生産拠点と2,000台以上の設備を保有。設備データの分断、生産計画の属人化、品質トレーサビリティの困難さなどの課題を抱え��いました。</p>
<h3>ソリューション</h3>
<ul>
<li><strong>設備連携</strong>：200台以上のIoTゲートウェイを導��し、全生産設備のリアルタイムデータ��集を実現</li>
<li><strong>データ基盤</strong>：統合データプラットフォームを構築し、ERP・MES・WMSシステムを連携</li>
<li><strong>AI排程</strong>：AIアルゴリズムによるスマートスケジューリングシステムで生産計画を最適化</li>
<li><strong>品質追跡</strong>：全工程QRコードトレーサビリティ体制を構築</li>
</ul>
<h3>導入成果</h3>
<ul>
<li>生産効率 <strong>30%</strong> 向上</li>
<li>設備停止時間 <strong>45%</strong> 削減</li>
<li>製品不良率 <strong>60%</strong> 低減</li>
<li>在庫回転率 <strong>25%</strong> 改善</li>
</ul>
<p>導入期間6ヶ月、稼働開始から初年度で投資回収を達成しました。</p>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',1,1,0,201,0,'大手製造企業のDXプロジェクト','DX,製造業,IoT,スマートファクトリー','大手製造企業のデジタルトランスフォーメーションを支援し、生産効率30%向上を実現。',1,0,1770899116,1770899116,0,1),
(6,'ja',0,13,'article','「年間最優秀テクノロジー革新賞」を受賞','','tech-award','https://picsum.photos/800/500?random=11',NULL,'先日開催された業界年間表彰式にて、当社が技術革新分野での優れた成果を評価され、受賞いたしました。','<p>先日開催された2024年度業界表彰式において、当社は技術革新分野での顕著な実績が認められ、「年間最優秀テクノロジー革新賞」を受賞いたしました。</p>

<p>今回の受賞は、長年にわたり技術革新に取り組んできた当社の姿勢が評価されたものです。当社は常に技術研究開発をコア競争力として位置付け、毎年多くのリソースを製品開発と技術向上に投入してまいりました。</p>

<p>代表取締役は「この賞は全社員の努力の成果です。今後も革新の精神を持ち続け、お客様により大きな価値を提供してまいります」と述べました。</p>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',1,1,1,818,0,'','','',1,0,1770899116,1770899116,0,1),
(7,'ja',0,14,'article','DXトレンドレポート2024を発表','','dx-report','https://picsum.photos/800/500?random=12',NULL,'最新の業界調査レポートにより、企業のDXが不可避のトレンドであることが示されました。','<p>このたび、業界の権威ある調査機関が「2024年企業DXトレンドレポート」を発表しました。主な調査結果は以下の通りです。</p>

<ul>
<li>80%以上の企業がDXに着手済み</li>
<li>クラウド、ビッグデータ、AIがDXの3大コア技術</li>
<li>2025年までにDX関連投資が50%増加する見込み</li>
</ul>

<p>レポートでは、企業は早期にDX戦略を策定し、適切なテクノロジーパートナーを選定した上で、段階的にDXを推進することを推奨しています。</p>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',0,0,0,307,0,'','','',1,0,1770899116,1770899116,0,1),
(8,'ja',0,16,'article','サービスフロー','','process','',NULL,'标准化的服务流程，确保服务质量','<div style="max-width:800px;margin:0 auto;">
<p style="text-align:center;color:#6b7280;margin-bottom:2em;">標準化されたサービスフローで、すべてのプロジェ���トを高品質にお届けします。</p>
<div style="display:flex;align-items:flex-start;margin-bottom:2em;"><div style="flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#3b82f6,#60a5fa);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;">1</div><div style="margin-left:20px;flex:1;"><h3 style="margin-top:0;margin-bottom:4px;">ヒアリング</h3><p style="color:#6b7280;">お客様の業務課題やご要望を詳しくお伺いし、要件定義書を作成します。</p></div></div>
<div style="display:flex;align-items:flex-start;margin-bottom:2em;"><div style="flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#10b981,#34d399);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;">2</div><div style="margin-left:20px;flex:1;"><h3 style="margin-top:0;margin-bottom:4px;">設計・提案</h3><p style="color:#6b7280;">システム設計、ハードウェア選定、ネットワーク設計、プロジェクト計画を策定しご提案します。</p></div></div>
<div style="display:flex;align-items:flex-start;margin-bottom:2em;"><div style="flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#8b5cf6,#a78bfa);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;">3</div><div style="margin-left:20px;flex:1;"><h3 style="margin-top:0;margin-bottom:4px;">開発・構築</h3><p style="color:#6b7280;">アジャイル開発で定期的に進捗をご報告。重要マイルストーンではお客様にレビューいただきます。</p></div></div>
<div style="display:flex;align-items:flex-start;margin-bottom:2em;"><div style="flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#f59e0b,#fbbf24);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;">4</div><div style="margin-left:20px;flex:1;"><h3 style="margin-top:0;margin-bottom:4px;">テスト・検収</h3><p style="color:#6b7280;">機能テスト、性能テスト、セキュリティテスト、受入テストを実施し、安定稼働を確認後に本番移行します。</p></div></div>
<div style="display:flex;align-items:flex-start;margin-bottom:2em;"><div style="flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#ef4444,#f87171);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;">5</div><div style="margin-left:20px;flex:1;"><h3 style="margin-top:0;margin-bottom:4px;">研修・納品</h3><p style="color:#6b7280;">操作研修と技術ドキュメントをご提供し、お客様が独立して運用できるよう支援します。</p></div></div>
<div style="display:flex;align-items:flex-start;margin-bottom:2em;"><div style="flex-shrink:0;width:60px;height:60px;background:linear-gradient(135deg,#06b6d4,#22d3ee);border-radius:50%;display:flex;align-items:center;justify-content:center;color:#fff;font-size:24px;font-weight:700;">6</div><div style="margin-left:20px;flex:1;"><h3 style="margin-top:0;margin-bottom:4px;">アフターサポート</h3><p style="color:#6b7280;">24時間365日の技術サポート、定期点検、システム最適化を提供します。</p></div></div>
</div>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',1,0,0,150,0,'サービスフロー','サービスフロー,導入プ��セス','6ステップの標準サービスフロー。',1,0,1770899116,1770899116,0,1),
(9,'ja',0,17,'article','製品の使い方について','','product-guide','',NULL,'新規ユーザー向けクイックスタートガイド','<h2>クイックスタート手順</h2>
<ol>
<li><strong>アカウント登録</strong>：公式サイトにアクセスし、登録ボタンからアカウントを作成します</li>
<li><strong>プラン選択</strong>：ご利用目的に合ったプランをお選びください</li>
<li><strong>初期設定</strong>：ガイドに沿って基本設定を行います</li>
<li><strong>ご利用開始</strong>：ログイン後すぐにご利用いただけます</li>
</ol>
<p>ご不明な点がございましたら、<a href="/contact.html">お問い合わせページ</a>よりお気軽にご連絡ください。</p>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',0,0,0,204,0,'','','',1,0,1770899116,1770899116,0,1),
(13,'ja',0,20,'article','お問い合わせ','','contact','',NULL,NULL,'<p>お気軽にお問い合わせください。</p>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',0,0,0,0,0,'','','',1,0,0,1770899116,1770899116,0),
(14,'ja',0,29,'article','プライバシーポリシー','','privacy','',NULL,'個人情報の取り扱いについて','<h2>プライバシーポリシー</h2>
<p>当社（以下「当社」）は、お客様の個人情報の重要性を認識し、個人情報の保護に関する法律（個人情報保護法）を遵守するとともに、以下のプライバシーポリシーに従い、適切な取り扱い及び保護に努めます。</p>

<h3>1. 個人情報の収集</h3>
<p>当社は、以下の場合に個人情報を収集することがあります。</p>
<ul>
<li><strong>お問い合わせフォーム</strong>：お名前、メールアドレス、電話番号、会社名など</li>
<li><strong>アクセスログ</strong>：IPアドレス、ブラウザの種類、アクセス日時、閲覧ページなど</li>
<li><strong>Cookie</strong>：ユーザー体験の向上およびサイト機能の改善のために使用します</li>
</ul>

<h3>2. 個人情報の利用目的</h3>
<p>収集した個人情報は、以下の目的で利用いたします。</p>
<ul>
<li>サービスの提供、維持、改善</li>
<li>お問い合わせやご依頼への対応</li>
<li>サービスに関するご連絡・ご案内</li>
<li>不正行為の防止</li>
</ul>

<h3>3. 個人情報の管理</h3>
<p>当社は、個人情報の正確性を保ち、不正アクセス、漏洩、改ざん、紛失を防止するため、適切な技術的・組織的措置を講じます。</p>

<h3>4. 第三者への提供</h3>
<p>当社は、以下の場合を除き、お客様の個人情報を第三者に提供することはありません。</p>
<ul>
<li>お客様の同意がある場合</li>
<li>法令に基づく場合</li>
<li>当社の権利・利益を保護するために必要な場合</li>
</ul>

<h3>5. Cookieの使用について</h3>
<p>当サイトでは、ユーザー体験の向上のためCookieを使用しています。ブラウザの設定によりCookieの受け入れを拒否することが可能ですが、一部の機能が正常に動作しなくなる場合があります。</p>

<h3>6. プライバシーポリシーの変更</h3>
<p>当社は、必要に応じて本ポリシーを変更することがあります。変更後のポリシーは当ページに掲載いたします。定期的にご確認いただくことをお勧めいたします。</p>

<h3>7. お問い合わせ</h3>
<p>本プライバシーポリシーに関するご質問は、<a href="/contact.html">お問い合わせページ</a>よりご連絡ください。</p>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',0,0,0,0,0,'','','',1,0,1770899116,1770899116,0,1),
(15,'ja',0,30,'article','利用規約','','terms','',NULL,'ウェブサイトのご利用条件','<h2>利用規約</h2>
<p>本ウェブサイト（以下「当サイト」）をご利用いただく前に、以下の利用規約をよくお読みください。当サイトをご利用になることにより、本規約に同意したものとみなされます。</p>

<h3>1. サービスについて</h3>
<p>当サイトで提供する情報およびサービスは参考目的であり、予告なく変更、中断、終了する場合があります。</p>

<h3>2. 禁止事項</h3>
<p>当サイトのご利用にあたり、以下の行為を禁止します。</p>
<ul>
<li>法令に違反する行為</li>
<li>ウイルスや悪意のあるコードを含むコンテンツの送信</li>
<li>他者の知的財産権その他の権利を侵害する行為</li>
<li>当サイトの正常な運営を妨害する行為</li>
</ul>

<h3>3. 知的財産権</h3>
<p>当サイトに掲載されているすべてのコンテンツ（テキスト、画像、動画、ソフトウェア、デザインを含む）は、著作権法およびその他の知的財産権法により保護されています。当社の書面による許可なく、複製、転載、改変、商用利用することはできません。</p>

<h3>4. 免責事項</h3>
<ul>
<li>当サイトの情報は一般的な参考情報であり、いかなる助言や保証を構成するものではありません。</li>
<li>当サイトの情報の正確性、完全性、最新性について保証するものではありません。</li>
<li>当サイトの利用に起因するいかなる直接的または間接的な損害についても、当社は責任を負いません。</li>
<li>当サイトには第三者のウェブサイトへのリンクが含まれる場合がありますが、当社はそれらのサイトの内容について一切の責任を負いません。</li>
</ul>

<h3>5. アカウント管理</h3>
<p>当サイトでアカウントを登録された場合、アカウント情報およびパスワードの管理はお客様の責任となります。アカウント情報の漏洩による損害について、当社は責任を負いかねます。</p>

<h3>6. プライバシー</h3>
<p>個人情報の取り扱いについては、<a href="/privacy.html">プライバシーポリシー</a>をご参照ください。</p>

<h3>7. 規約の変更</h3>
<p>当社は、本利用規約を随時変更する権利を有します。変更後の規約は当ページに掲載され、当サイトを継続してご利用になることにより、変更後の規約に同意したものとみなされます。</p>

<h3>8. 準拠法</h3>
<p>本利用規約は日本法に準拠するものとし、本規約に関する紛争については、東京地方裁判所を第一審の専属的合意管轄裁判所とします。</p>

<h3>9. お問い合わせ</h3>
<p>本利用規約に関するご質問は、<a href="/contact.html">お問い合わせページ</a>よりご連絡ください。</p>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',0,0,0,0,0,'','','',1,0,1770899116,1770899116,0,1),
(16,'ja',0,4,'article','沿革','','history','',NULL,'会社の歩み','<p>当社の設立から現在までの歩みをご紹介します。</p>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',0,0,0,0,0,'','','',1,0,1775432984,1775432984,1775432984,1),
(17,'ja',0,5,'article','アクセス','','access','',NULL,'所在地・交通案内','<h2>本社</h2>
<p>〒150-0000<br>東京都渋谷区XX町X丁目X-X XXビル 5F</p>

<h3>電車でお越しの方</h3>
<ul>
<li>JR山手線「渋谷駅」南口より徒歩5分</li>
<li>東京メトロ銀座線「渋谷駅」出口3より徒歩3分</li>
</ul>

<h3>お車でお越しの方</h3>
<p>首都高速3号渋谷線「渋谷IC」より約5分<br>※ビル地下に有料駐車場がございます</p>

<h2>大阪支社</h2>
<p>〒530-0000<br>大阪府大阪市北区XX町X丁目X-X XXビル 3F</p>

<h3>電車でお越しの方</h3>
<ul>
<li>JR大阪環状線「大阪駅」より徒歩8分</li>
<li>大阪メトロ御堂筋線「梅田駅」より徒歩5分</li>
</ul>

<h2>お問い合わせ</h2>
<table style="width:100%;border-collapse:collapse">
<tr><td style="padding:8px 0;width:120px"><strong>電話番号</strong></td><td style="padding:8px 0">03-0000-0000</td></tr>
<tr><td style="padding:8px 0"><strong>FAX</strong></td><td style="padding:8px 0">03-0000-0001</td></tr>
<tr><td style="padding:8px 0"><strong>メール</strong></td><td style="padding:8px 0">info@example.co.jp</td></tr>
<tr><td style="padding:8px 0"><strong>営業時間</strong></td><td style="padding:8px 0">平日 9:00〜18:00（土日祝休み）</td></tr>
</table>','html',NULL,'','','','',0,'0.00',NULL,'','',NULL,'','','','','','','','',0,0,0,0,0,'','','',1,0,1775432984,1775432984,1775432984,1);

-- yikai_banner_groups: 4 rows (auto-generated, ja default)
INSERT INTO yikai_banner_groups (`id`,`name`,`slug`,`height_pc`,`height_mobile`,`autoplay_delay`,`sort_order`,`status`,`created_at`) VALUES
(1,'首页','home',650,300,5000,0,1,0),
(2,'关于我们','about',500,250,5000,1,1,0),
(3,'产品中心','product',500,250,5000,2,1,0),
(4,'案例展示','case',500,250,5000,3,1,0);

-- yikai_banners: 3 rows (auto-generated, ja default)
INSERT INTO yikai_banners (`id`,`position`,`lang`,`title`,`subtitle`,`btn1_text`,`btn1_url`,`btn2_text`,`btn2_url`,`image`,`image_mobile`,`link_url`,`link_target`,`start_time`,`end_time`,`status`,`sort_order`,`created_at`) VALUES
(1,'home','ja','デジタルトランスフォーメーション','企業のスマート化を支援します','会社概要','/company.html','ダウンロード','/download.html','https://picsum.photos/1920/600?random=1','','/company.html','_self',0,0,1,1,1770899116),
(2,'home','ja','プロフェッショナル技術サポート','24時間365日、安心のサポート体制','詳しく見る','/service.html','','','https://picsum.photos/1920/600?random=2','','/service.html','_self',0,0,1,2,1770899116),
(3,'home','ja','イノベーションが未来を拓く','継続的な革新で卓越を追求します','','','','','https://picsum.photos/1920/600?random=3','','','_self',0,0,1,3,1770899116);

-- yikai_links: 1 rows (auto-generated, ja default)
INSERT INTO yikai_links (`id`,`lang`,`name`,`url`,`logo`,`description`,`status`,`sort_order`,`created_at`) VALUES
(1,'ja','易开网-域名注册','https://www.yikai.cn','','百度搜索引擎',1,1,1770899116);

-- yikai_product_categories: 4 rows (auto-generated, ja default)
INSERT INTO yikai_product_categories (`id`,`parent_id`,`name`,`slug`,`lang`,`translation_group_id`,`image`,`description`,`seo_title`,`seo_keywords`,`seo_description`,`status`,`is_nav`,`sort_order`,`created_at`) VALUES
(1,0,'スマートデバイス','smart-device','ja',0,'','スマートハードウェア製品シリーズ','','','',1,1,1,1770899116),
(2,0,'ソフトウェアサービス','software','ja',0,'','企業向けソフトウェア・クラウドサービス','','','',1,1,2,1770899116),
(3,1,'センサーモジュール','sensor-module','ja',0,'',NULL,'','','',1,1,1,1770899116),
(4,1,'制御端末','control-terminal','ja',0,'',NULL,'','','',1,1,2,1770899116);

-- yikai_products: 6 rows (auto-generated, ja default)
INSERT INTO yikai_products (`id`,`lang`,`translation_group_id`,`category_id`,`brand_id`,`title`,`subtitle`,`slug`,`cover`,`images`,`summary`,`content`,`price`,`market_price`,`model`,`specs`,`tags`,`product_type`,`material`,`scene`,`is_top`,`is_recommend`,`is_hot`,`is_new`,`views`,`status`,`sort_order`,`created_at`,`updated_at`,`admin_id`) VALUES
(1,'ja',0,1,0,'IoTスマートゲートウェイ','産業用高性能ゲートウェイ','iot-gateway','https://picsum.photos/800/600?random=10','https://picsum.photos/800/600?random=20
https://picsum.photos/800/600?random=21
https://picsum.photos/800/600?random=22
https://picsum.photos/800/600?random=23','マルチプロトコル対応、エッジコンピューティング機能搭載','<h2>製品概要</h2><p>IoTスマートゲートウェイは、MQTT、HTTP、Modbus、OPC UAなど100種以上の通信プロトコルに対応した高性能エッジコンピューティングゲートウェイです。</p><h3>主な特長</h3><ul><li>Wi-Fi/4G/有線LANの複数接続方式に対応</li><li>内蔵エッジコンピューティングエンジン</li><li>100種以上の産業プロトコルに対応</li><li>産業用設計 −40°C〜85°C の広温度動作</li></ul><h3>適用分野</h3><p>スマートファクトリー、スマート農業、スマートシティ、エネルギー管理。</p>','2999.00','3599.00','IOT-GW-100',NULL,'','custom','','',0,1,0,1,11,1,0,1770899116,1770899116,1),
(2,'ja',0,2,0,'企業管理クラウド','ワンストップ企業DXソリューション','cloud-platform','https://picsum.photos/800/600?random=11',NULL,'ERP・CRM・OA機能を統合','<h2>製品概要</h2><p>ERP・CRM・OAの三大モジュールを統合したワンストップ企業管理クラウドプラットフォームです。</p><h3>機能モジュール</h3><ul><li><strong>ERP</strong> — 購買・在庫・生産・会計の一元管理</li><li><strong>CRM</strong> — 顧客管理・営業パイプライン・実績分析</li><li><strong>OA</strong> — ワークフロー・スケジュール管理・チャット</li></ul><h3>技術的優位性</h3><p>マイクロサービスアーキテクチャにより、オンプレミス・SaaSの両デプロイに対応。</p>','0.00','0.00','EMS-CLOUD-V3',NULL,'','custom','','',0,1,0,1,8,1,0,1770899116,1770899116,1),
(3,'ja',0,3,0,'温湿度センサー TH-200','高精度産業用温湿度センサー','th200-sensor','https://picsum.photos/800/600?random=12','https://picsum.photos/800/600?random=40
https://picsum.photos/800/600?random=41','スイス製チップ搭載、精度±0.1°C。産業環境モニタリング、倉庫管理、スマート農業に最適。','<h2>製品概要</h2><p>スイス製高精度チップ搭載、精度±0.1°C / ±1.5%RHの温湿度センサーです。</p><h3>仕様</h3><ul><li>温度範囲：−40°C〜125°C</li><li>湿度範囲：0〜100%RH</li><li>通信：RS485 / Modbus RTU</li><li>電源：DC 12-24V</li><li>保護等級：IP65</li></ul>','0.00','0.00','TH-200',NULL,'','custom','','',0,0,0,1,4,1,0,1770899116,1770899116,1),
(4,'ja',0,3,0,'照度センサー LS-100','広範囲照度センサー','ls100-sensor','https://picsum.photos/800/600?random=13',NULL,'検出範囲0-200000Lux、RS485/Modbus通信対応。スマート農業・気象観測に幅広く活用。','<h2>製品概要</h2><p>測定範囲0〜200,000 Lux、高感度フォトダイオード採用の照度センサーです。</p><h3>仕様</h3><ul><li>測定範囲：0〜200,000 Lux</li><li>精度：±3%</li><li>通信：RS485 / Modbus</li><li>電源：DC 5-24V</li></ul><h3>適用分野</h3><p>スマート農業、気象観測、照明制御。</p>','0.00','0.00','LS-100',NULL,'','custom','','',0,0,1,0,4,1,0,1770899116,1770899116,1),
(5,'ja',0,4,0,'産業用エッジコントローラー EC-500','高性能エッジコンピューティング端末','ec500-controller','https://picsum.photos/800/600?random=14','https://picsum.photos/800/600?random=30
https://picsum.photos/800/600?random=31
https://picsum.photos/800/600?random=32','ARM Cortex-A72搭載、複数の産業プロトコルに対応、AIモデルのローカル推論に対応。','<h2>製品概要</h2><p>ARM Cortex-A72搭載、AIモデルのローカル推論に対応した産業用エッジコントローラーです。</p><h3>主な特長</h3><ul><li>4コア ARM Cortex-A72、1.8GHz</li><li>4GB RAM / 32GB eMMC</li><li>TensorFlow Lite / ONNX推論対応</li><li>豊富なI/O：4×RS485、2×CAN、4×DI、4×DO</li></ul>','0.00','0.00','EC-500',NULL,'','custom','','',0,1,1,1,1,1,0,1770899116,1770899116,1),
(6,'ja',0,4,0,'スマートゲートウェイコントローラー GC-300','マルチプロトコル統合ゲートウェイ','gc300-gateway','https://picsum.photos/800/600?random=15',NULL,'Wi-Fi/Zigbee/LoRa/4G同時対応、エッジコンピューティング内蔵、ワンストップデバイス管理。','<h2>製品概要</h2><p>Wi-Fi/Zigbee/LoRa/4Gの4プロトコル同時接続対応のスマートゲートウェイです。</p><h3>主な特長</h3><ul><li>4プロトコル同時接続、最大500台のデバイス管理</li><li>内蔵エッジコンピューティングエンジン</li><li>OTAリモートアップデート対応</li><li>Webベース管理画面、ノーコード設定</li></ul><h3>適用分野</h3><p>スマートビル、スマートホーム、産業IoT。</p>','0.00','0.00','GC-300',NULL,'','custom','','',0,1,0,0,2,1,0,1770899116,1770899116,1);

-- yikai_form_templates: 2 rows (auto-generated, ja default)
INSERT INTO yikai_form_templates (`id`,`name`,`slug`,`fields`,`success_message`,`status`,`created_at`) VALUES
(1,'联系表单','contact','[{"key":"company","label":"会社名","type":"text","required":false,"placeholder":"例：株式会社○○"},{"key":"name","label":"お名前","type":"text","required":true,"placeholder":"例：田中 太郎"},{"key":"phone","label":"電話番号","type":"tel","required":false,"placeholder":"例：03-0000-0000"},{"key":"email","label":"メールアドレス","type":"email","required":true,"placeholder":"例：info@example.co.jp"},{"key":"content","label":"お問い合わせ内容","type":"textarea","required":true,"placeholder":"ご質問やご要望をご記入ください"}]','送信が完了しました。担当者よりご連絡いたします。',1,1775345336),
(2,'产品询盘','product-inquiry','[{"key":"name","label":"您的姓名","type":"text","required":true,"placeholder":"请输入姓名"},{"key":"phone","label":"联系电话","type":"tel","required":true,"placeholder":"请输入电话"},{"key":"email","label":"邮箱地址","type":"email","required":false,"placeholder":"请输入邮箱"},{"key":"company","label":"公司名称","type":"text","required":false,"placeholder":"请输入公司名称"},{"key":"content","label":"请描述您的需求","type":"textarea","required":true,"placeholder":"请描述您的需求"}]','询盘已提交，我们将尽快与您联系！',1,1775345336);

-- yikai_timelines: 8 rows (auto-generated, ja default)
INSERT INTO yikai_timelines (`id`,`lang`,`year`,`month`,`day`,`title`,`content`,`image`,`icon`,`color`,`sort_order`,`status`,`created_at`,`updated_at`) VALUES
(1,'ja',2024,6,0,'ブランドリニューアル','コーポレートブランドを刷新。新ビジョンを発表。','','rocket','blue',100,1,1770899116,0),
(2,'ja',2024,1,0,'受賞','「年間最優秀テクノロジー革新賞」を受賞。','','award','yellow',95,1,1770899116,0),
(3,'ja',2023,8,0,'戦略提携','大手企業との戦略的パートナーシップを締結。','','handshake','green',90,1,1770899116,0),
(4,'ja',2023,3,0,'新製品発表','次世代IoTゲートウェイ・クラウドプラットフォームを発表。','','box','purple',85,1,1770899116,0),
(5,'ja',2022,10,0,'チーム拡充','社員数50名を突破。開発体制を強化。','','users','cyan',80,1,1770899116,0),
(6,'ja',2022,5,0,'資金調達','シリーズAラウンドにて資金調達を完了。','','trending-up','red',75,1,1770899116,0),
(7,'ja',2021,0,0,'事業拡大','大阪支社を開設。西日本エリアへの展開を本格化。','','map','indigo',70,1,1770899116,0),
(8,'ja',2020,0,0,'会社設立','東京都渋谷区にて設立。IoTソリューション事業を開始。','','flag','primary',60,1,1770899116,0);

-- yikai_albums: 3 rows (auto-generated, ja default)
INSERT INTO yikai_albums (`id`,`category_id`,`name`,`slug`,`cover`,`description`,`photo_count`,`sort_order`,`status`,`created_at`,`updated_at`) VALUES
(7,0,'荣誉资质','honor','/images/cert-1.jpg','企业荣誉证书与资质认证',1,100,1,1770899116,0),
(8,0,'团队风采','team','','团队活动与员工风采展示',0,90,1,1770899116,0),
(9,0,'企业环境','environment','','公司办公环境与生产车间',0,80,1,1770899116,0);

-- yikai_album_photos: 1 rows (auto-generated, ja default)
INSERT INTO yikai_album_photos (`id`,`album_id`,`title`,`image`,`thumb`,`description`,`sort_order`,`status`,`created_at`) VALUES
(1,7,'授权证书','/images/cert-1.jpg','/images/cert-1.jpg','企业授权认证证书',1,1,1770899116);

-- yikai_download_categories: 3 rows (auto-generated, ja default)
INSERT INTO yikai_download_categories (`id`,`name`,`description`,`sort_order`,`status`,`created_at`) VALUES
(1,'产品手册','产品使用手册和说明文档',1,1,1770899116),
(2,'软件下载','软件安装包和工具',2,1,1770899116),
(3,'技术文档','技术规范和开发文档',3,1,1770899116);

-- yikai_downloads: 3 rows (auto-generated, ja default)
INSERT INTO yikai_downloads (`id`,`category_id`,`lang`,`translation_group_id`,`title`,`description`,`cover`,`file_url`,`file_name`,`file_size`,`file_ext`,`download_count`,`is_external`,`require_login`,`sort_order`,`status`,`created_at`,`updated_at`,`admin_id`) VALUES
(1,1,'ja',0,'製品マニュアル V2.0','最新版の製品マニュアルです。設定方法やFAQを含みます。','','','',0,'pdf',128,0,0,100,1,1770899116,0,0),
(2,2,'ja',0,'クライアントソフト V3.5.1','Windows用クライアントソフトウェアのインストーラーです。','','','',0,'zip',256,0,0,90,1,1770899116,0,0),
(3,3,'ja',0,'API仕様書','開発者向けAPI仕様書の完全版です。','','','',0,'pdf',89,0,0,80,1,1770899116,0,0);

-- yikai_jobs: 2 rows (auto-generated, ja default)
INSERT INTO yikai_jobs (`id`,`title`,`lang`,`translation_group_id`,`cover`,`summary`,`content`,`location`,`salary`,`job_type`,`education`,`experience`,`headcount`,`requirements`,`views`,`is_top`,`sort_order`,`status`,`publish_time`,`created_at`,`updated_at`,`admin_id`) VALUES
(1,'PHPシニアエンジニア','ja',0,'','自社プロダクトのバックエンド設計・開発を担当','<p>自社CMS・クラウドサービスのバックエンド設計・開発を担当していただきます。</p>','東京（リモート可）','年収500万〜800万円','正社員','大卒以上','3〜5年','2名','<h3>業務内容</h3>
<ul>
<li>自社CMS・クラウドサービスのバックエンド開発</li>
<li>APIの設計・実装・最適化</li>
<li>データベース設計・パフォーマンスチューニング</li>
<li>コードレビュー・技術ドキュメント作成</li>
</ul>

<h3>応募条件</h3>
<ul>
<li>PHPでの開発経験3年以上</li>
<li>MySQL / PostgreSQLの実務経験</li>
<li>Gitを用いたチーム開発経験</li>
<li>REST APIの設計・開発経験</li>
</ul>

<h3>歓迎スキル</h3>
<ul>
<li>Laravel / Symfony等フレームワークの経験</li>
<li>Docker / Kubernetesの経験</li>
<li>AWS / GCP等クラウドインフラの経験</li>
</ul>

<h3>待遇・福利厚生</h3>
<ul>
<li>各種社会保険完備</li>
<li>通勤手当支給</li>
<li>リモートワーク制度あり</li>
<li>年間休日120日以上</li>
<li>書籍購入補助・カンファレンス参加支援</li>
</ul>',15,1,100,1,1770899116,1770899116,0,1),
(2,'フロントエンドエンジニア','ja',0,'','自社プロダクトのフロントエンド開発・UI改善を担当','<p>自社プロダクトのフロントエンド開発・UI改善を担当していただきます。</p>','東京（リモート可）','年収400万〜650万円','正社員','大卒以上','1〜3年','1名','<h3>業務内容</h3>
<ul>
<li>Webアプリケーションのフロントエンド開発</li>
<li>UI/UXの改善提案・実装</li>
<li>レスポンシブデザインの実装</li>
<li>パフォーマンス最適化</li>
</ul>

<h3>応募条件</h3>
<ul>
<li>HTML / CSS / JavaScriptの実務経験2年以上</li>
<li>React / Vue.jsいずれかの経験</li>
<li>Tailwind CSSまたは類似のCSSフレームワーク経験</li>
</ul>

<h3>歓迎スキル</h3>
<ul>
<li>TypeScriptの経験</li>
<li>Figma等デザインツールの使用経験</li>
<li>アクセシビリティ（a11y）への理解</li>
</ul>

<h3>待遇・福利厚生</h3>
<ul>
<li>各種社会保険完備</li>
<li>通勤手当支給</li>
<li>リモートワーク制度あり</li>
<li>年間休日120日以上</li>
<li>書籍購入補助・カンファレンス参加支援</li>
</ul>',0,0,90,1,1770899116,1770899116,0,1);

-- yikai_plugins: 4 rows (auto-generated, ja default)
INSERT INTO yikai_plugins (`id`,`slug`,`status`,`installed_at`,`activated_at`) VALUES
(1,'search-replace',1,1770899116,1770899116),
(3,'db-backup',1,1770899116,1770899116),
(4,'back-to-top',1,1770899116,1770899116),
(5,'translate',1,1775446827,1775446827);

