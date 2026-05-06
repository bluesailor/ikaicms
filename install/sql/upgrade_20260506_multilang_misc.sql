-- 多言語対応の補完: brands / links / product_categories / product_tags 4 表に lang・translation_group_id 列を追加
-- 既存 7 表の lang 列を varchar(5) → varchar(10) に拡張 (zh-Hant / en-US 等への対応余裕)
-- 双语管理用の lang インデックスを追加 (canonical ikaicms 命名に準拠)

-- ============================================================
-- 1. 既存 lang 列を varchar(10) に拡張 (デフォルト値 'ja' 維持)
-- ============================================================
ALTER TABLE `yikai_banners`   MODIFY COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja';
ALTER TABLE `yikai_channels`  MODIFY COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja';
ALTER TABLE `yikai_contents`  MODIFY COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja';
ALTER TABLE `yikai_downloads` MODIFY COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja';
ALTER TABLE `yikai_jobs`      MODIFY COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja';
ALTER TABLE `yikai_products`  MODIFY COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja';
ALTER TABLE `yikai_timelines` MODIFY COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja';

-- ============================================================
-- 2. 4 表に多言語列を新規追加
-- ============================================================
ALTER TABLE `yikai_brands`
  ADD COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja' AFTER `slug`,
  ADD COLUMN `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang`;

ALTER TABLE `yikai_links`
  ADD COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja' AFTER `id`;

ALTER TABLE `yikai_product_categories`
  ADD COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja' AFTER `slug`,
  ADD COLUMN `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang`;

ALTER TABLE `yikai_product_tags`
  ADD COLUMN `lang` varchar(10) NOT NULL DEFAULT 'ja' AFTER `slug`,
  ADD COLUMN `translation_group_id` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang`;

-- ============================================================
-- 3. lang インデックス追加 (canonical ikaicms に準拠)
--    brands と product_tags は canonical でも lang インデックスなし
-- ============================================================
ALTER TABLE `yikai_banners`            ADD INDEX `idx_banner_lang` (`lang`);
ALTER TABLE `yikai_channels`           ADD INDEX `idx_lang` (`lang`);
ALTER TABLE `yikai_contents`           ADD INDEX `idx_lang_status` (`lang`, `status`),
                                       ADD INDEX `idx_trans_group` (`translation_group_id`);
ALTER TABLE `yikai_downloads`          ADD INDEX `idx_dl_lang` (`lang`);
ALTER TABLE `yikai_jobs`               ADD INDEX `idx_job_lang` (`lang`);
ALTER TABLE `yikai_links`              ADD INDEX `idx_lk_lang` (`lang`);
ALTER TABLE `yikai_product_categories` ADD INDEX `idx_pc_lang` (`lang`);
ALTER TABLE `yikai_products`           ADD INDEX `idx_lang_status` (`lang`, `status`),
                                       ADD INDEX `idx_trans_group` (`translation_group_id`);
ALTER TABLE `yikai_timelines`          ADD INDEX `idx_tl_lang` (`lang`);
