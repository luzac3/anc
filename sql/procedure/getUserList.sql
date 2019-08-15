DROP PROCEDURE IF EXISTS getUserList;
DELIMITER //
-- ********************************************************************************************
-- getUserList すべてのユーザーを取得する
--
-- 【処理概要】
--  すべてのユーザーを取得する
--
--
-- 【呼び出し元画面】
--   リスト
--
-- 【引数】
--      なし
--
--
-- 【戻り値】
--      exit_cd            : exit_cd
--      正常：0
--      異常：99
-- --------------------------------------------------------------------------------------------
-- 【更新履歴】
--  2019.7.30 大杉　新規作成
-- ********************************************************************************************
CREATE PROCEDURE `getUserList`(
    OUT `exit_cd` INTEGER
)
COMMENT 'イベントリスト取得'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET exit_cd = 99;

    set @query = CONCAT("
        SELECT
            JNNR_CD
            ,JNNR_NM
        FROM
            T_JNNR
        ;
        ");

    SET @query_text = @query;

        -- 実行
    PREPARE main_query FROM @query_text;
    EXECUTE main_query;
    DEALLOCATE PREPARE main_query;

    SET exit_cd = 0;

END
//
DELIMITER ;
