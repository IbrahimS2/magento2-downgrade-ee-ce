-- Enable `entity_id` column for catalog product entity

ALTER TABLE `catalog_product_entity_datetime`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_decimal`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_gallery`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_int`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_media_gallery_value`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_media_gallery_value_to_entity`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_text`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_tier_price`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';
ALTER TABLE `catalog_product_entity_varchar`
    ADD COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Entity ID';

-- Clean duplicate for catalog product entity

DELETE e
FROM `catalog_product_entity` e
         LEFT OUTER JOIN (
    SELECT MAX(`updated_in`) as `last_updated_in`, `entity_id`
    FROM `catalog_product_entity`
    GROUP BY `entity_id`
) AS p
                         ON e.`entity_id` = p.`entity_id` AND e.`updated_in` = p.`last_updated_in`
WHERE p.`last_updated_in` IS NULL;

-- Populate `entity_id` column for catalog product entity

UPDATE `catalog_product_entity_datetime` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_decimal` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_gallery` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_int` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_media_gallery_value` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_media_gallery_value_to_entity` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_text` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_tier_price` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;
UPDATE `catalog_product_entity_varchar` v INNER JOIN `catalog_product_entity` e ON v.`row_id` = e.`row_id`
SET v.`entity_id` = e.`entity_id`
WHERE 1;

-- ------------------------------------------------------------------
-- Update the `entity_id` relation link for catalog product entity --
-- ------------------------------------------------------------------

-- Datetime
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_datetime`;
ALTER TABLE `catalog_product_entity_datetime`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_DATETIME_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Decimal
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_decimal`;
ALTER TABLE `catalog_product_entity_decimal`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_DECIMAL_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Int
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_int`;
ALTER TABLE `catalog_product_entity_int`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_INT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Text
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_text`;
ALTER TABLE `catalog_product_entity_text`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_TEXT_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Varchar
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_varchar`;
ALTER TABLE `catalog_product_entity_varchar`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_VARCHAR_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Gallery
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` ON `catalog_product_entity_gallery`;
ALTER TABLE `catalog_product_entity_gallery`
    ADD CONSTRAINT `CATALOG_PRODUCT_ENTITY_GALLERY_ENTITY_ID_ATTRIBUTE_ID_STORE_ID` UNIQUE KEY (`entity_id`, `attribute_id`, `store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Gallery value
DROP INDEX IF EXISTS `CAT_PRD_ENTT_MDA_GLR_VAL_ENTT_ID_VAL_ID_STORE_ID` ON `catalog_product_entity_media_gallery_value`;
ALTER TABLE `catalog_product_entity_media_gallery_value`
    ADD CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_ENTT_ID_VAL_ID_STORE_ID` UNIQUE KEY (`entity_id`, `value_id`, `store_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Gallery value to entity
DROP INDEX IF EXISTS `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_VAL_ID_ENTT_ID` ON `catalog_product_entity_media_gallery_value_to_entity`;
ALTER TABLE `catalog_product_entity_media_gallery_value_to_entity`
    ADD CONSTRAINT `CAT_PRD_ENTT_MDA_GLR_VAL_TO_ENTT_VAL_ID_ENTT_ID` UNIQUE KEY (`value_id`, `entity_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Tier price
DROP INDEX IF EXISTS `UNQ_E8AB433B9ACB00343ABB312AD2FAB087` ON `catalog_product_entity_tier_price`;
ALTER TABLE `catalog_product_entity_tier_price`
    ADD CONSTRAINT `UNQ_E8AB433B9ACB00343ABB312AD2FAB087` UNIQUE KEY (`entity_id`, `all_groups`, `customer_group_id`, `qty`, `website_id`),
    DROP COLUMN IF EXISTS `row_id`;

-- Entity
ALTER TABLE `catalog_product_entity`
    DROP FOREIGN KEY IF EXISTS `CATALOG_PRODUCT_ENTITY_ENTITY_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE`;
DROP INDEX IF EXISTS `CATALOG_PRODUCT_ENTITY_ENTITY_ID_CREATED_IN_UPDATED_IN` ON `catalog_product_entity`;
ALTER TABLE `catalog_product_entity`
    DROP COLUMN IF EXISTS `row_id`,
    DROP COLUMN IF EXISTS `created_in`,
    DROP COLUMN IF EXISTS `updated_in`,
    MODIFY COLUMN `entity_id` INT(10) UNSIGNED NOT NULL DEFAULT 0 AUTO_INCREMENT COMMENT 'Entity ID',
    ADD PRIMARY KEY (`entity_id`);

-- Foreign keys
ALTER TABLE `catalog_product_entity_datetime`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_decimal`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_int`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_text`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_varchar`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_gallery`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_media_gallery_value`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_media_gallery_value_to_entity`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;
ALTER TABLE `catalog_product_entity_tier_price`
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

-- ----------------
-- Drop sequence --
-- ----------------

ALTER TABLE `catalog_category_product`
    DROP FOREIGN KEY IF EXISTS `CAT_CTGR_PRD_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
    ADD FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `catalog_compare_item`
    DROP FOREIGN KEY IF EXISTS `CATALOG_COMPARE_ITEM_PRODUCT_ID_SEQUENCE_PRODUCT_SEQUENCE_VALUE`,
    ADD FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `catalog_product_bundle_price_index`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_BNDL_PRICE_IDX_ENTT_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
    ADD FOREIGN KEY (`entity_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;

ALTER TABLE `catalog_product_bundle_selection`
    DROP FOREIGN KEY IF EXISTS `CAT_PRD_BNDL_SELECTION_PRD_ID_SEQUENCE_PRD_SEQUENCE_VAL`,
    ADD FOREIGN KEY (`product_id`) REFERENCES `catalog_product_entity` (`entity_id`) ON DELETE CASCADE ON UPDATE RESTRICT;


-- catalog_product_link
-- catalog_product_index_tier_price
-- catalog_product_website
-- catalog_product_relation
-- catalog_product_super_link
-- catalog_url_rewrite_product_category
-- cataloginventory_stock_item
-- product_alert_price
-- product_alert_stock
-- report_compared_product_index
-- report_viewed_product_aggregated_daily
-- report_viewed_product_aggregated_monthly
-- report_viewed_product_aggregated_yearly
-- report_viewed_product_index
-- weee_tax
-- wishlist_item


DROP TABLE `sequence_product`;

-- todo add constraint name for the foreign keys
